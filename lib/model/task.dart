import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'taskType.dart';

//! this model may have a provider

//TODO: add task icon (string) as an attribute & taskAccentColor. to avoid check in each widget for the task type

/// task data model
class Task {
  //TODO:check if id is string or double => <int>
  String name, id, description, projectName;
  DateTime datePlannedStart, datePlannedEnd, dateActualStart, dateActualEnd;
  final List<CheckPoint> checkPoints;
  List<User> members;

  int progress;

  /// task Weather assigned to team or members
  Team assignedTeam;

  //TODO:check Task dataType here !
  final Task dependentTask;

  /// if this task is a subtask, [parentCheckpoint] going to curry the parent task checkpoint
  final CheckPoint parentCheckpoint;

  //make this final
  User taskCreator;

  Task(
      {@required this.id,
      @required this.name,
      this.description,
      this.taskCreator, //task creator id
      this.parentCheckpoint,
      @required this.datePlannedEnd,
      this.dateActualStart,
      this.dateActualEnd,
      this.datePlannedStart,
      this.progress = 0,
      this.projectName, //project id
      this.dependentTask,
      this.assignedTeam,
      this.checkPoints,
      this.members}) {
    getType;
  }

  ///holds which task type is
  taskType type;

  /// [getType] defines task type
  get getType {
    if (dependentTask != null)
      type = taskType.dependentTask;
    else if (parentCheckpoint != null)
      type = taskType.subTask;
    else
      type = taskType.task;
  }
}

class CheckPoint {
  final int id;
  final String name, description;
  final bool isFinished;

  /// [percentage] = -1: means that this checkpoint doesn't have any subtask, so use checkbox, otherwise show progress
  final int percentage;

  const CheckPoint({
    @required this.id,
    @required this.name,
    this.isFinished = false,
    this.percentage = -1,
    this.description,
  });
}

class User {
  final int id;
  final String userName;
  final name;
  final String jobTitle;
  final String imageUrl;

  //TODO:check if the userName is required
  const User({this.userName, @required this.id, this.imageUrl, @required this.name, @required this.jobTitle});
}

// class Project {
//   final int id;
//   final String name;
//   final User creator;
//   final DateTime datePlannedStart, datePlannedEnd, dateActualStart, dateActualEnd, dateCreated;
//   final List<Team> teams;
//
//   //TODO: add list of teams
//   const Project(
//       {this.id,
//       this.name,
//       this.creator,
//       this.teams,
//       this.datePlannedStart,
//       this.datePlannedEnd,
//       this.dateActualStart,
//       this.dateActualEnd,
//       this.dateCreated});
// }

class Team {
  final int id;
  final String name, description, code;
  final DateTime dateCreated;
  final User leader;
  final List<User> members;
  List<Task> tasks;

  Team(
      {this.id,
      @required this.name,
      this.description,
      this.leader,
      this.members,
      this.code,
      this.dateCreated,
      this.tasks = const []});
}
