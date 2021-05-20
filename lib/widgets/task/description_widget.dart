import 'package:flutter/material.dart';
import 'package:project/widgets/task/editTextField_method.dart';

import '../../constants.dart';
import 'descriptionTextField.dart';

//TODO: add enable editing attribute to disable/enable edit button
class DescriptionWidget extends StatelessWidget {
  final String description;
  final Color taskAccentColor;

  DescriptionWidget(this.description,{ this.taskAccentColor = Colors.white});


  @override
  Widget build(BuildContext context) {
  final _descriptionController = TextEditingController(text: description);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Description',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: taskAccentColor)),
              IconButton(
                  splashRadius: 20,
                  splashColor: Color.fromRGBO(8, 77, 99, 1),
                  icon: Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    editTextField(context, _descriptionController.value.text, maxLines: 7);
                  }),
            ],
          ),
        ),
        DescriptionTextField(controller: _descriptionController,width: MediaQuery.of(context).size.width-20),
      ],
    );
  }
}
