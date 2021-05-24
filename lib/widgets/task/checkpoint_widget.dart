import 'package:flutter/material.dart';
import 'package:project/model/models.dart';

import '../../constants.dart';
import '../circular_checkBox.dart';
import 'checkpoint_description.dart';

//TODO: IMPORTANT save new data !!
class CheckpointWidget extends StatelessWidget {
  final CheckPoint checkPoint;
  final Color taskAccentColor;
  final bool isEditing;
  final bool showDescription;
  final Function(CheckPoint) onChanged;
  final Function(CheckPoint) onRemove;
  final bool enableDelete;

  //final bool save;

  const CheckpointWidget(
      {Key key, @required this.checkPoint, this.taskAccentColor, this.isEditing = false, this.showDescription = true, this.onChanged, this.onRemove, this.enableDelete = true})
      : super(key: key);

  static const TS_DONE = TextStyle(
    fontSize: 17,
    color: Colors.grey,
    fontStyle: FontStyle.italic,
    decoration: TextDecoration.lineThrough,
    decorationStyle: TextDecorationStyle.solid,
  );

  // ignore: non_constant_identifier_names
  static final TS_WORKING = TextStyle(fontSize: 17);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    bool _value = checkPoint.isFinished;
    nameController.text = checkPoint.name;
    descriptionController.text = checkPoint.description;

    //if (save) onSave(CheckPoint(id: checkPoint.id, name: nameController.value.text, description: descriptionController.value.text));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.adjust, color: taskAccentColor, size: 18),
              SizedBox(width: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextField(
                  style: _value ? CheckpointWidget.TS_DONE : CheckpointWidget.TS_WORKING,
                  readOnly: !isEditing,
                  onChanged: (name) => onChanged(checkPoint.copyWith(name: name)),
                  enableInteractiveSelection: isEditing,
                  controller: nameController,
                  autofocus: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              //Text(checkPoint.name, style: _value ? CheckpointWidget.TS_DONE : CheckpointWidget.TS_WORKING,),
              Spacer(),
              checkPoint.percentage <= 0
                  ? CircularCheckBox(value: _value, activeColor: taskAccentColor.withOpacity(0.8), onChanged: (value) => () => _value = value)
                  : Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        '${checkPoint.percentage}%',
                        style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
                      ),
                    ),
              SizedBox(width: 8),
              //Expanded(child: tc.CheckPoint(checkPoint: task.checkPoints[index], taskAccentColor: taskAccentColor))
            ],
          ),
        ),
        //if(showDescription)
        Offstage(
          offstage: !showDescription,
          child: Padding(
            padding: EdgeInsets.only(left: isEditing ? 5 : 15, right: 15, bottom: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    if (isEditing)
                      IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: checkPoint.subtasks.isEmpty && enableDelete ? () => onRemove(checkPoint) : null,
                        splashRadius: 20,
                        iconSize: 30,
                        disabledColor: Colors.grey[800],
                        tooltip: 'Delete Checkpoint',
                        color: Colors.red,
                      ),
                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(left: isEditing ? 5 : 25, right: 15),
                          child: Column(
                            children: [
                              CheckpointDescription(
                                onChanged: (description) => onChanged(checkPoint.copyWith(description: description)),
                                controller: descriptionController,
                                readOnly: !isEditing,
                                width: MediaQuery.of(context).size.width,
                              ),
                              //if it has subtasks
                              if (checkPoint.subtasks.isNotEmpty && showDescription)
                                Container(
                                  decoration: BoxDecoration(
                                      color: COLOR_BACKGROUND,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25),
                                        bottomRight: Radius.circular(20),
                                        topRight: Radius.circular(15),
                                      ),
                                      boxShadow: [BoxShadow(color: taskAccentColor, offset: Offset(-1, 1))]),
                                  margin: const EdgeInsets.only(left: 50, top: 2, right: 10),
                                  padding: const EdgeInsets.only(left: 20, bottom: 3, right: 20, top: 3),
                                  child: Align(
                                      child: Text(
                                    '${checkPoint.subtasks.length} subtasks created on it',
                                    style: TextStyle(color: Colors.white70, fontSize: 13),
                                  )),
                                ),
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
