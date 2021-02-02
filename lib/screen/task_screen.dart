import 'package:flutter/material.dart';
import 'package:project/constants.dart';

import '../widgets/custom_paint/parent_checkpoint.dart';
import '../widgets/task/add_checkpoint_widget.dart';
import '../widgets/task/checkpoint_widget.dart';
import '../widgets/task/description_widget.dart';
import '../widgets/task/task_flexibleSpace.dart';

import '../model/task.dart';

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.adjust,
                            color: taskAccentColor,
                          ),
                          SizedBox(width: 8),
                          Text(widget.task.parentCheckpoint.name,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17))
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: COLOR_BACKGROUND,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(2.5),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(5),
                                topRight: Radius.circular(5)),
                        boxShadow: [BoxShadow(color: taskAccentColor, offset: Offset(-1,1))]
                        ),
                        margin: const EdgeInsets.only(left: 10, top: 5),
                        padding: const EdgeInsets.only(left: 10,bottom: 10, right: 5, top: 5),
                        child: Text(widget.task.parentCheckpoint.description, style: TextStyle(fontSize: 15, height: 1.3),),
                      ),
                    ],
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
                      style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: taskAccentColor,
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
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            if (_isEditing) AddCheckpointWidget(taskAccentColor: taskAccentColor),
          ]))
        ],
      ),
    );
  }
}
