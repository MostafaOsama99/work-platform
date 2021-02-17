import 'package:flutter/material.dart';

/// enum for task types: task, subTask, dependentTask to define different settings for each task
/// such as icon , taskAccentColor
enum taskType { task, subTask, dependentTask }

final Map<taskType, _TaskType> taskTypes = {
  taskType.task: _Task(),
  taskType.subTask: _SubTask(),
  taskType.dependentTask: _DependentTask(),
};

// different approach
// class TaskType{
//   static const subTask = SubTask;
// }

class _TaskType {
  Color accentColor;

  String icon;
}

class _SubTask with _TaskType {
  Color accentColor = Colors.amber;
  String icon = 'assets/icons/subtask.png';
}

class _Task with _TaskType {
  Color accentColor = Colors.greenAccent[700];
  String icon = 'assets/icons/task.png';
}

class _DependentTask with _TaskType {
  Color accentColor = Colors.purple;
  String icon = 'assets/icons/subtask-dependent.png';
}
