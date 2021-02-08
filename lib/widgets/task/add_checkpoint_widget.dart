import 'package:flutter/material.dart';
import 'package:project/model/task.dart';

import 'checkpoint_description.dart';
import 'checkpoint_widget.dart';

class AddCheckpointWidget extends StatefulWidget {
  final Color taskAccentColor;
  final Function(String title, String description) onSubmit;


  const AddCheckpointWidget({this.taskAccentColor, this.onSubmit});

  @override
  _AddCheckpointWidgetState createState() => _AddCheckpointWidgetState();
}

class _AddCheckpointWidgetState extends State<AddCheckpointWidget> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    //descriptionController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.adjust, color: widget.taskAccentColor, size: 18),
              SizedBox(width: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextField(
                  style: CheckpointWidget.TS_WORKING,
                  onChanged: (_) => setState(() {}),
                  controller: titleController,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'add checkpoint',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(0),
                  ),
                ),
              ),
              Spacer(),
              if (titleController.value.text.trim() != '')
                IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () {
                    widget.onSubmit(titleController.value.text, descriptionController.value.text);
                    setState(() {
                      titleController.text = '';
                      descriptionController.text = '';
                    });
                  },
                  splashRadius: 18,
                  color: Colors.green,
                ),
              SizedBox(width: 15),
            ],
          ),
        ),
        //if(widget.showDescription)
        Padding(
            padding: const EdgeInsets.only(left: 35, right: 30, top: 0, bottom: 8),
            child: CheckpointDescription(
              controller: descriptionController,
              width: MediaQuery.of(context).size.width,
              readOnly: false,
            )),
      ],
    );
  }
}
