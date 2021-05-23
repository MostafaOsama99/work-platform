import 'package:flutter/material.dart';
import 'package:project/model/models.dart';

import '../../constants.dart';
import '../circular_checkBox.dart';
import 'checkpoint_description.dart';

//TODO: IMPORTANT save new data !!
class CheckpointWidget extends StatefulWidget {
  final CheckPoint checkPoint;
  final Color taskAccentColor;
  final bool isEditing;
  final bool showDescription;
  final Function(CheckPoint) onSave;
  final Function(CheckPoint) onRemove;
  final bool save;

  const CheckpointWidget(
      {Key key, @required this.checkPoint, this.taskAccentColor, this.isEditing = false, this.showDescription = true, this.onSave, this.onRemove, this.save = false})
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
  _CheckpointWidgetState createState() => _CheckpointWidgetState();
}

class _CheckpointWidgetState extends State<CheckpointWidget> {
  bool _value;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    _value = widget.checkPoint.isFinished;
    nameController.text = widget.checkPoint.name;
    descriptionController.text = widget.checkPoint.description;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.save) widget.onSave(CheckPoint(id: widget.checkPoint.id, name: nameController.value.text, description: descriptionController.value.text));

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
                  style: _value ? CheckpointWidget.TS_DONE : CheckpointWidget.TS_WORKING,
                  readOnly: !widget.isEditing,
                  enableInteractiveSelection: widget.isEditing,
                  controller: nameController,
                  autofocus: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              //Text(widget.checkPoint.name, style: _value ? CheckpointWidget.TS_DONE : CheckpointWidget.TS_WORKING,),
              Spacer(),
              widget.checkPoint.percentage <= 0
                  ? CircularCheckBox(value: _value, activeColor: widget.taskAccentColor.withOpacity(0.8), onChanged: (value) => setState(() => _value = value))
                  : Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        '${widget.checkPoint.percentage}%',
                        style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
                      ),
                    ),
              SizedBox(width: 8),
              //Expanded(child: tc.CheckPoint(checkPoint: widget.task.checkPoints[index], taskAccentColor: taskAccentColor))
            ],
          ),
        ),
        //if(widget.showDescription)
        Offstage(
          offstage: !widget.showDescription,
          child: Padding(
            padding: EdgeInsets.only(left: widget.isEditing ? 5 : 15, right: 15, bottom: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    if (widget.isEditing)
                      IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: widget.checkPoint.subtasks.isNotEmpty
                            ? () {
                                //TODO: handle remove this specific checkpoint, if it's not the last one
                              }
                            : null,
                        splashRadius: 20,
                        iconSize: 30,
                        disabledColor: Colors.grey[800],
                        tooltip: 'Delete Checkpoint',
                        color: Colors.red,
                      ),
                    Expanded(
                      child: Padding(
                          //padding: const EdgeInsets.only(left: 25, right: 15, top: 0, bottom: 15),
                          padding: EdgeInsets.only(left: widget.isEditing ? 5 : 25, right: 15),
                          child: Column(
                            children: [
                              CheckpointDescription(
                                controller: descriptionController,
                                readOnly: !widget.isEditing,
                                width: MediaQuery.of(context).size.width,
                              ),
                              if (widget.checkPoint.subtasks.isNotEmpty && widget.showDescription)
                                Container(
                                  decoration: BoxDecoration(
                                      color: COLOR_BACKGROUND,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(2.5), bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25), topRight: Radius.circular(5)),
                                      boxShadow: [BoxShadow(color: widget.taskAccentColor, offset: Offset(-1, 1))]),
                                  margin: const EdgeInsets.only(left: 15, top: 2, right: 15),
                                  padding: const EdgeInsets.only(left: 20, bottom: 3, right: 20, top: 3),
                                  child: Align(
                                      child: Text(
                                    '${widget.checkPoint.subtasks.length} subtasks created on it',
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
