import 'package:flutter/foundation.dart';

//! this model may have a provider

/// task data model
class Task {
  //TODO:check if id is string or double
  final String name, id, description, projectName;
  final DateTime datePlannedStart,
      datePlannedEnd,
      dateActualStart,
      dateActualEnd;
  final List<CheckPoint> checkPoints;
  final List<String> members;

  final String dependentTaskId;

  final double progress;

  /// if this task is a subtask, [parentCheckpoint] going to curry the parent task checkpoint
  final CheckPoint parentCheckpoint;

  final String taskCreator;

  const Task({
    @required this.id,
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
    this.members
  });
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
