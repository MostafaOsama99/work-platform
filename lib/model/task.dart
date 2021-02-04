import 'package:flutter/foundation.dart';

//! this model may have a provider

//TODO: add task icon (string) as an attribute & taskAccentColor. to avoid check in each widget for the task type

/// task data model
class Task {
  //TODO:check if id is string or double => <int>
  final String name, id, description, projectName;
  final DateTime datePlannedStart, datePlannedEnd, dateActualStart, dateActualEnd;
  final List<CheckPoint> checkPoints;
  final List<String> members;

  final double progress;

  //TODO:check Task dataType here !
  final Task dependentTask;

  /// if this task is a subtask, [parentCheckpoint] going to curry the parent task checkpoint
  final CheckPoint parentCheckpoint;

  final String taskCreator;

  const Task(
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
  final bool isFinished;

  /// [percentage] = -1: means that this checkpoint doesn't have any subtask, so use checkbox, otherwise show progress
  final int percentage;

  const CheckPoint({
    @required this.id,
    @required this.name,
    @required this.isFinished,
    this.percentage = -1,
    this.description,
  });
}

class User {
  final int id;
  final String userName;
  final String imageUrl;
  final name;
  final String jobTitle;

  //TODO:check if the userName is required
  User({this.userName, @required this.id, this.imageUrl, @required this.name, this.jobTitle});
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

  const Team(
      {@required this.id,
      @required this.name,
      this.description,
      this.leader,
      this.members,
      this.code,
      this.dateCreated});
}
