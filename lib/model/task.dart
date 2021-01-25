import 'package:flutter/foundation.dart';

//! this model may have a provider

//TODO: add task icon (string) as an attribute & taskAccentColor. to avoid check in each widget for the task type

/// task data model
class Task {
  //TODO:check if id is string or double => <int>
  final String name, id, description, projectName;
  final DateTime datePlannedStart,
      datePlannedEnd,
      dateActualStart,
      dateActualEnd;
  final List<CheckPoint> checkPoints;
  final List<String> members;

  final double progress;

  final String dependentTaskId;

  /// if this task is a subtask, [parentCheckpoint] going to curry the parent task checkpoint
  final CheckPoint parentCheckpoint;

  final String taskCreator;

  const Task(
      {@required this.id,
      @required this.name,
      this.description,
      this.taskCreator,
      this.parentCheckpoint,
      @required this.datePlannedEnd,
      this.dateActualStart,
      this.dateActualEnd,
      this.datePlannedStart,
      this.progress = 0,
      this.projectName,
      this.dependentTaskId,
      this.checkPoints,
      this.members});

  // var teamData = {
  //   'teams': <dynamic>[
  //     {
  //       'id': 'teamId',
  //       'TeamName': 'teamName',
  //       //'userRole': 'userRole',
  //       'tasks': {
  //         {'taskId', 'TaskName', 'DatePlannedEnd<iso>', 'percentage<int>'},
  //       }
  //     },
  //   ]
  // };


  // var projectData = {
  //   'projectId':{
  //     'name','plannedEndDate','projectCreator','teams'
  //   }
  // };

 }

class CheckPoint {
  final String name, id, description;
  final bool value;

  /// [percentage] = -1: means that this checkpoint doesn't have any subtask, so use checkbox, otherwise show progress
  final int percentage;

  const CheckPoint({
    @required this.id,
    @required this.name,
    @required this.value,
    this.percentage = -1,
    this.description,
  });
}
