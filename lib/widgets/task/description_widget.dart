import 'package:flutter/material.dart';
import 'package:project/widgets/task/editTextField_method.dart';

import '../../constants.dart';
import 'descriptionTextField.dart';

class EditableTextWidget extends StatelessWidget {
  final String description;
  final Color taskAccentColor;
  final Function(String value) onChanged;
  final bool enableEdit;
  final String title;
  final int maxLines;

  EditableTextWidget(this.description,
      {this.title = 'Description',
      this.taskAccentColor = Colors.white,
      this.onChanged,
      this.enableEdit = true,
      this.maxLines = 7})
      : assert(maxLines > 0);

  @override
  Widget build(BuildContext context) {
    final _descriptionController = TextEditingController(text: description);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 4),
                child: Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: taskAccentColor)),
              ),
              if (enableEdit)
                SizedBox(
                  height: 36,
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      splashRadius: 16,
                      splashColor: Color.fromRGBO(8, 77, 99, 1),
                      icon: Icon(Icons.edit, color: Colors.grey),
                      onPressed: () async {
                        final String result = await editTextField(
                            context, _descriptionController.value.text,
                            maxLines: maxLines);
                        if (result != null) onChanged(result);
                      }),
                ),
            ],
          ),
        ),
        DescriptionTextField(
            controller: _descriptionController,
            width: MediaQuery.of(context).size.width - 20),
      ],
    );
  }
}
