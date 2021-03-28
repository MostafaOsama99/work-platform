import 'package:flutter/material.dart';
import 'package:project/screen/main_screen/attachment%20screen.dart';

import '../constants.dart';
import '../demoData.dart';
import 'create_task_screen.dart';
import '../widgets/dateField_widget.dart';
import '../widgets/task/parent_checkpoint.dart';
import '../widgets/team_tile.dart';
import '../widgets/user_tile.dart';
import '../widgets/task/add_checkpoint_widget.dart';
import '../widgets/task/checkpoint_widget.dart';
import '../widgets/task/description_widget.dart';
import '../widgets/task/task_flexibleSpace.dart';

import '../model/task.dart';
import '../model/taskType.dart';

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
    final notificationHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: false,
            //forceElevated: false,
            collapsedHeight: 45,
            toolbarHeight: 44.9999,
            //automaticallyImplyLeading: false,
            expandedHeight: 125,
            //leading: IconButton(icon: Icon(Icons.arrow_back, size: 22),splashRadius: 15, onPressed: () =>Navigator.of(context).pop(),),
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
                  splashRadius: 20,
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => Attachment())))
            ],
            flexibleSpace: BuildFlexibleSpace(task: widget.task, isEdit: _isEditing),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              if (widget.task.dependentTask != null)
                Container(
                  //height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.2, 1],
                      colors: [
                        COLOR_ACCENT,
                        Colors.purple[700],
                      ],
                    ),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).scaffoldBackgroundColor, //Colors.black38, //COLOR_BACKGROUND,
                          ),
                          padding: const EdgeInsets.all(4.5),
                          child: Image.asset('assets/icons/task.png', color: Colors.purple)),
                      SizedBox(width: 8),
                      FittedBox(
                          child: Text(
                        widget.task.dependentTask.name,
                        style: TextStyle(fontSize: 15),
                      )),
                      Spacer(),
                      Icon(Icons.pause_circle_outline_rounded, size: 23, color: Colors.redAccent),
                      SizedBox(width: 8),
                      Text('after: ', style: TextStyle(fontSize: 15)),
                      DateField(initialDate: widget.task.dependentTask.datePlannedEnd),
                    ],
                  ),
                ),
              if (widget.task.parentCheckpoint != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12, right: 8, left: 8, bottom: 8),
                  child: ParentCheckpoint(
                    widget.task.parentCheckpoint,
                    taskAccentColor: taskTypes[widget.task.type].accentColor,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: DescriptionWidget(
                  widget.task.description,

                  taskAccentColor: taskTypes[widget.task.type].accentColor,
                ),
              ),
              Divider(endIndent: 25, indent: 25),
/*
  ///
  /// Checkpoints
  ///
*/
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'Checkpoints',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: taskTypes[widget.task.type].accentColor,
                      ),
                    ),
                    Spacer(),
                    Switch(
                      value: _showCheckpointDesc,
                      onChanged: (_) => setState(() => _showCheckpointDesc = !_showCheckpointDesc),
                      activeColor: taskTypes[widget.task.type].accentColor,
                    ),
                  ],
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return InkWell(
                  onLongPress: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => CreateTask(
                            teamMembers: users,
                            parentCheckpoint: widget.task.checkPoints[index],
                            cpStart: widget.task.datePlannedStart,
                            cpEnd: widget.task.datePlannedEnd,
                          ))),
                  child: CheckpointWidget(
                    checkPoint: widget.task.checkPoints[index],
                    taskAccentColor: taskTypes[widget.task.type].accentColor,
                    isEditing: _isEditing,
                    showDescription: _showCheckpointDesc,
                  ),
                );
              },
              childCount: widget.task.checkPoints.length,
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            if (_isEditing) AddCheckpointWidget(taskAccentColor: taskTypes[widget.task.type].accentColor),
/*
  ///
    ///assigned to:
  ///
*/
            Divider(endIndent: 25, indent: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    'Assigned to:',
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold, color: taskTypes[widget.task.type].accentColor),
                  ),
                  Spacer(),
                  widget.task.assignedTeam != null
                      ? InkWell(
                          onTap: _isEditing
                              ? () {
                                  //TODO:show Teams dialog
                                }
                              : null,
                          child: TeamTile(widget.task.assignedTeam))
                      : _isEditing
                          ? SizedBox(
                              height: 22,
                              child: IconButton(
                                  icon: Icon(Icons.add_circle_outline_rounded),
                                  padding: const EdgeInsets.all(0),
                                  tooltip: 'add member',
                                  color: Colors.white,
                                  splashRadius: 20,
                                  onPressed: () {
                                    //TODO:show add member dialog
                                  }))
                          : SizedBox()
                ],
              ),
            ),
          ])),
          if (widget.task.members != null)
            SliverList(
                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              return Row(
                children: [
                  SizedBox(width: 8),
                  if (_isEditing)
                    IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: widget.task.members.length > 1
                          ? () {
                              //TODO: handle remove this specific Member
                            }
                          : null,
                      splashRadius: 20,
                      iconSize: 30,
                      disabledColor: Colors.grey[800],
                      tooltip: 'remove user',
                      color: Colors.red,
                    ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 8),
                    child: UserTile(widget.task.members[index]),
                  )),
                ],
              );
            }, childCount: widget.task.members.length)),
/*
  ///
    ///Created by:
  ///
*/
          SliverList(
              delegate: SliverChildListDelegate([
            Divider(endIndent: 25, indent: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Created by:',
                style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.bold, color: taskTypes[widget.task.type].accentColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 12),
              child: UserTile(widget.task.taskCreator),
            ),
          ])),
        ],
      ),
    );
  }
}
