import 'package:flutter/material.dart';
import 'package:project/widgets/task/editTextField_method.dart';

import '../../constants.dart';

//TODO: add enable editing attribute to disable/enable edit button
class DescriptionWidget extends StatefulWidget {
  final String description;
  final double width;

  const DescriptionWidget(this.description, double width)
      : this.width = width - 20; //20 padding

  @override
  _DescriptionWidgetState createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  final _descriptionController = TextEditingController();

  bool _expandDes = false;
  bool _exceedLines;

  TextSpan span;

  TextPainter tp;

  ///calculating text field height going to be according to textField value & device width - padding
  ///if textField lines exceed 4 it enables onTap to expand functionality otherwise it's disabled
  textFieldLines() {
    span = TextSpan(text: _descriptionController.value.text);
    tp = TextPainter(text: span, maxLines: 3, textDirection: TextDirection.ltr); // maxLines 3 => 4 actual
    tp.layout(maxWidth: widget.width);
    setState(() {
      _exceedLines = tp.didExceedMaxLines;
      //make sure that previous state is true for [_expandDes] to set maxLines to null
      if (!_exceedLines) _expandDes = true;
    });
  }

  @override
  void initState() {
    _descriptionController.text = widget.description.trim();

    ///calculating text field height going to be according to textField value & device width - padding
    span = TextSpan(text: _descriptionController.value.text);
    tp = TextPainter(text: span, maxLines: 3, textDirection: TextDirection.ltr);
    tp.layout(maxWidth: widget.width);
    _exceedLines = tp.didExceedMaxLines;

    //_descriptionController.addListener(textFieldLines);
    super.initState();
  }

  @override
  void dispose() {
    //_descriptionController.removeListener(textFieldLines);
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Description',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              IconButton(
                  splashRadius: 20,
                  splashColor: Color.fromRGBO(8, 77, 99, 1),
                  icon: Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    Future(()=> editTextField(context, _descriptionController, maxLines: 7)).then((_) => textFieldLines());
                  }),
            ],
          ),
        ),
        TextField(
          readOnly: true,
          autofocus: false,
          controller: _descriptionController,
          maxLines: _expandDes ? null : 4,
          onTap: _exceedLines
              ? () => setState(() => _expandDes = !_expandDes)
              : null,
          //disable the onTap function if the description is short
          decoration: TEXT_FIELD_DECORATION_2,
        ),
      ],
    );
  }
}
