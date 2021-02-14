import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:project/constants.dart';
import 'package:project/widgets/custom_expansion_title.dart';

import 'package:project/widgets/task/checkpoint_description.dart';
import 'package:project/widgets/task/descriptionTextField.dart';
import 'package:project/widgets/task/description_widget.dart';
import 'package:project/widgets/task/task_flexibleSpace.dart';

import '../model/task.dart';
import '../widgets/task/task_card.dart' as tc;

class TaskScreen extends StatefulWidget {
  final Task task;

  const TaskScreen(this.task);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool _isEditing = false;
  bool _showCheckpointDesc = true;

  @override
  Widget build(BuildContext context) {
    /// [taskAccentColor] holding color used in task icon, checkboxes for checkpoints
    Color taskAccentColor;
    String taskIcon;

    if (widget.task.dependentTask != null) {
      taskAccentColor = Colors.purple;
      taskIcon = 'assets/icons/subtask-dependent.png';
    } else if (widget.task.parentCheckpoint != null) {
      taskAccentColor = Colors.amber;
      taskIcon = 'assets/icons/subtask.png';
    } else {
      taskAccentColor = Colors.greenAccent.shade400;
      taskIcon = 'assets/icons/task.png';
    }

    final notificationHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            // forceElevated: true,
            collapsedHeight: 50,
            toolbarHeight: 49.9999,
            expandedHeight: widget.task.dependentTask != null ? 180 : 150,
            actions: [
              IconButton(
                icon: _isEditing
                    ? Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      )
                    : Icon(Icons.edit, color: Colors.white),
                splashRadius: 20,
                onPressed: () => setState(() => _isEditing = !_isEditing),
              ),
              IconButton(
                  icon: Transform.rotate(
                      angle: 3.14 / 4,
                      child: Icon(
                        Icons.attach_file,
                        color: Colors.white,
                      )),
                  onPressed: null)
            ],

            flexibleSpace: BuildFlexibleSpace(task: widget.task),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              if (widget.task.parentCheckpoint != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 200),
                    //You can Replace this with your desired WIDTH and HEIGHT

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.adjust,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 8),
                            Text(widget.task.parentCheckpoint.name)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Text('description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(widget.task.parentCheckpoint.description),
                        ),
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: DescriptionWidget(
                  widget.task.description,
                  taskAccentColor: taskAccentColor,
                ),
              ),
              Divider(
                endIndent: 25,
                indent: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'Checkpoints',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: taskAccentColor,
                      //   shadows: <Shadow>[
                      //   Shadow(
                      //     offset: Offset(1.0, 1.0),
                      //     blurRadius: 2.0,
                      //     color: Colors.white,
                      //   ),
                      // ],
                         ),
                    ),
                    Spacer(),
                    Switch(
                      value: _showCheckpointDesc,
                      onChanged: (_) => setState(() => _showCheckpointDesc = !_showCheckpointDesc),
                      activeColor: taskAccentColor,
                    ),
                    // IconButton(
                    //   icon: Icon(_showCheckpointDesc? Icons.chat_bubble :Icons.radio_button_checked_rounded),
                    //   onPressed: () => setState(()=> _showCheckpointDesc = !_showCheckpointDesc),
                    //   splashRadius: 20,
                    // )
                  ],
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return CheckpointWidget(
                  checkPoint: widget.task.checkPoints[index],
                  taskAccentColor: taskAccentColor,
                  isEditing: _isEditing,
                  showDescription: _showCheckpointDesc,
                );
              },
              childCount: widget.task.checkPoints.length,
            ),
          )
        ],
      ),
    );
  }
}

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
