import 'package:flutter/material.dart';
import 'package:project/widgets/task/editTextField_method.dart';

import 'descriptionTextField.dart';

//TODO: add enable editing attribute to disable/enable edit button
class DescriptionWidget extends StatelessWidget {
  final String description;
  final Color taskAccentColor;
  final bool isEditing;

  const DescriptionWidget(this.description,{ this.taskAccentColor = Colors.white, this.isEditing = false});

  @override
  Widget build(BuildContext context) {
  final _descriptionController = TextEditingController(text: description);

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text('Description',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: taskAccentColor)),
              ),
              if(isEditing)
              SizedBox(
                height: 22,
                child: IconButton(
                    splashRadius: 20,
                    splashColor: Color.fromRGBO(8, 77, 99, 1),
                    padding: const EdgeInsets.all(0),
                    icon: Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      editTextField(context, _descriptionController, maxLines: 7);
                    }),
              ),
            ],
          ),
          DescriptionTextField(controller: _descriptionController,width: MediaQuery.of(context).size.width-20),
        ],
      ),
    );
  }
}
