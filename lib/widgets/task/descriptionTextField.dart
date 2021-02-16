import 'package:flutter/material.dart';

import '../../constants.dart';

///fits for normal description and checkpoint description
class DescriptionTextField extends StatefulWidget {
  final double width;
  final TextEditingController controller;
  final decoration;
  final bool readOnly;

  const DescriptionTextField({this.controller, this.width, this.decoration, this.readOnly = true}); //20 padding

  @override
  _DescriptionTextFieldState createState() => _DescriptionTextFieldState();
}

class _DescriptionTextFieldState extends State<DescriptionTextField> {
  //final _descriptionController = TextEditingController();

  bool _expandDes = false;
  bool _exceedLines;

  TextSpan span;

  TextPainter tp;

  ///calculating text field height going to be according to textField value & device width - padding
  ///if textField lines exceed 4 it enables onTap to expand functionality otherwise it's disabled
  textFieldLines() {
    span = TextSpan(text: widget.controller.value.text);
    tp = TextPainter(
        text: span,
        maxLines: KDescriptionMaxLines-1,
        textDirection: TextDirection.ltr); // maxLines 3 => 4 actual
    tp.layout(maxWidth: widget.width);
    setState(() {
      _exceedLines = tp.didExceedMaxLines;
      //make sure that previous state is true for [_expandDes] to set maxLines to null
      if (!_exceedLines) _expandDes = true;
    });
  }

  @override
  void initState() {
    //_descriptionController.text = widget.description.trim();

    ///calculating text field height going to be according to textField value & device width - padding
    span = TextSpan(text: widget.controller.value.text);
    tp = TextPainter(text: span, maxLines: KDescriptionMaxLines-1, textDirection: TextDirection.ltr);
    tp.layout(maxWidth: widget.width);
    _exceedLines = tp.didExceedMaxLines;
    if (!_exceedLines) _expandDes = true;

    widget.controller.addListener(textFieldLines);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(textFieldLines);
    //widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
     // scrollPhysics: const NeverScrollableScrollPhysics(),
        readOnly: widget.readOnly,
        //enableInteractiveSelection: !widget.readOnly,
        autofocus: false,
        controller: widget.controller,
        maxLines: _expandDes ? null : KDescriptionMaxLines,
        onTap: _exceedLines
            ? () => setState(() => _expandDes = !_expandDes)
            : null,
        //disable the onTap function if the description is short
        decoration: widget.decoration ?? TEXT_FIELD_DECORATION_2
    );
  }
}