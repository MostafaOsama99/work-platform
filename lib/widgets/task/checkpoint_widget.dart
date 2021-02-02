import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:project/model/task.dart';

import 'checkpoint_description.dart';

//TODO: IMPORTANT save new data !!
class CheckpointWidget extends StatefulWidget {
  final CheckPoint checkPoint;
  final Color taskAccentColor;
  final bool isEditing;
  final bool showDescription;

  const CheckpointWidget(
      {Key key, this.checkPoint, this.taskAccentColor, this.isEditing = false, this.showDescription = true})
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
    _value = widget.checkPoint.value;
    nameController.text = widget.checkPoint.name;
    descriptionController.text = widget.checkPoint.description;
    super.initState();
  }

  @override
  void dispose() {
    // nameController.dispose();
    // descriptionController.dispose();
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
                  style: _value ? CheckpointWidget.TS_DONE : CheckpointWidget.TS_WORKING,
                  readOnly: !widget.isEditing,
                  controller: nameController,
                  autofocus: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(0),
                  ),
                ),
              ),
              //Text(widget.checkPoint.name, style: _value ? CheckpointWidget.TS_DONE : CheckpointWidget.TS_WORKING,),
              Spacer(),
              widget.checkPoint.percentage <= 0
                  ? CircularCheckBox(
                      value: _value,
                      checkColor: Colors.white,
                      //Theme.of(context).accentIconTheme.color,
                      activeColor: widget.taskAccentColor.withOpacity(0.8),
                      inactiveColor: Theme.of(context).appBarTheme.color,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      onChanged: (value) => setState(() => _value = value))
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
            child: Row(
              children: [
                if (widget.isEditing)
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      //TODO: handle remove this specific checkpoint, if it's not the last one
                    },
                    splashRadius: 20,
                    iconSize: 30,
                  ),
                Expanded(
                  child: Padding(
                      //padding: const EdgeInsets.only(left: 25, right: 15, top: 0, bottom: 15),
                      padding: EdgeInsets.only(left: widget.isEditing ? 5 : 25, right: 15),
                      child: CheckpointDescription(
                        controller: descriptionController,
                        readOnly: !widget.isEditing,
                        width: MediaQuery.of(context).size.width,
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

