import 'package:flutter/material.dart';

import '../../constants.dart';

editTextField(BuildContext context, TextEditingController controller,
    {int maxLines = 1}) {
  final _formKey = GlobalKey<FormState>();

  String _validate(String value) {
    if (value.length <= 3) return 'too short name !';
    return null;
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.of(context).pop();
    }
  }

  return showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      backgroundColor: COLOR_SCAFFOLD,
      //Color.fromRGBO(8, 77, 99, 1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      builder: (BuildContext context) {
        return SizedBox(
          //size of keyboard + padding + button + TextField
          height: MediaQuery.of(context).viewInsets.bottom +
              35 +
              60 +
              13 +
              maxLines * 20.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      autofocus: true,
                      maxLines: maxLines,
                      textInputAction: maxLines == 1
                          ? TextInputAction.done
                          : TextInputAction.newline,
                      onSaved: (value) {
                        controller.text = value.trim();
                      },
                      initialValue: controller.value.text,
                      decoration: TEXT_FIELD_DECORATION.copyWith(
                          fillColor: COLOR_BACKGROUND,
                          errorStyle: TextStyle(height: 1),
                          contentPadding: const EdgeInsets.all(12),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: COLOR_ACCENT))),
                      validator: _validate,
                      onFieldSubmitted: (_) => _submit(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlineButton(
                          borderSide:
                          BorderSide(color: COLOR_ACCENT, width: 2),
                          highlightedBorderColor: Colors.red,
                          child: Transform.rotate(
                              angle: (22/7) / 4, //45 degree
                              child: Icon(Icons.add, color: Colors.red)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      OutlineButton(
                          highlightColor: COLOR_BACKGROUND,
                          borderSide:
                          BorderSide(color: COLOR_ACCENT, width: 2),
                          highlightedBorderColor: Colors.green,
                          child: Icon(Icons.done, color: Colors.green),
                          onPressed: _submit)
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}

