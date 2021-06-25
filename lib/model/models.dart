import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'taskType.dart';

//! this model may have a provider

//TODO: add task icon (string) as an attribute & taskAccentColor. to avoid check in each widget for the task type

/// task data model
class Task with ChangeNotifier {
  //TODO:check if id is string or double => <int>
  String name, description, projectName;
  int id;
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
      this.name,
      this.description,
      this.taskCreator, //task creator id
      this.parentCheckpoint,
      this.datePlannedEnd,
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

  factory Task.formJson(Map<String, dynamic> json) {
    return Task(
      id: (json["id"]),
      name: json["name"],
      description: json["description"],
      datePlannedStart: DateTime.parse(json["plannedStartDate"]),
      datePlannedEnd: DateTime.parse(json["plannedEndDate"]),
      dateActualStart: DateTime.parse(json["actualStartDate"]),
      dateActualEnd: json["actualEndDate"] != null ? DateTime.parse(json["actualEndDate"]) : null,
      taskCreator: User.fromJson(json['creator']),
      parentCheckpoint: json['parentCheckPoint'] != null ? CheckPoint.fromJson(json['parentCheckPoint']) : null,
      members: ((json['assignedUsers'] ?? []) as List).map((user) => User.fromJson(user)).toList(),
      checkPoints:
          json['childCheckPoints'] != null ? List<CheckPoint>.generate(json['childCheckPoints'].length, (index) => CheckPoint.fromJson(json['childCheckPoints'][index])) : [],
    );
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

  // [percentage] = -1: means that this checkpoint doesn't have any subtask, so use checkbox, otherwise show progress
  int percentage;

  final List<Task> subtasks;

  CheckPoint({
    @required this.id,
    @required this.name,
    this.subtasks,
    this.isFinished = false,
    this.percentage = 0,
    this.description,
  });

  factory CheckPoint.fromJson(Map<String, dynamic> json) {
    return CheckPoint(
        id: json['id'],
        name: json['checkpointText'],
        description: json['description'],
        percentage: json['percentage'],
        subtasks: json['subTasks'] == null ? null : (json['subTasks'] as List).map((subtask) => Task.formJson(subtask)).toList()
        //subtasks: []
        );
  }

  @override
  bool operator ==(other) => Object is CheckPoint && other.id == id && other.name == name && other.description == description;

  CheckPoint copyWith({
    int id,
    String name,
    String description,
    int percentage,
    bool isFinished,
    List<Task> subtasks,
  }) {
    return CheckPoint(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      percentage: percentage ?? this.percentage,
      isFinished: isFinished ?? this.isFinished,
      subtasks: subtasks ?? this.subtasks,
    );
  }
}

class User {
  //TODO make id String
  //final id;
  final String userName;
  final String name;
  final String jobTitle;
  final String imageUrl;

  //TODO:check if the userName is required
  const User({@required this.userName, this.imageUrl, this.name, this.jobTitle});

  factory User.fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) return null;
    return User(
        userName: json['userName'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        jobTitle: json['jobTitle']);
  }

  @override
  bool operator ==(Object other) => other is User && other.userName == userName;
}

// class Project {
//   final int id;
//   String name, description;
//   final DateTime datePlannedStart, datePlannedEnd, dateActualStart, dateActualEnd, dateCreated;
//   final User creator;
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
  final String code;
  final DateTime dateCreated;
  final User leader;
  String name, description;
  List<User> members;

  //TODO: remove these
  List<Task> tasks;

  Team({
    this.id,
    @required this.name,
    this.description,
    this.code,
    this.dateCreated,
    this.leader,
    this.members,
    this.tasks = const [],
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        code: json['teamCode'],
        dateCreated: DateTime.parse(json['createdAt']),
        //TODO; remove null check
        leader: json['leader'] != null ? User.fromJson(json['leader']) : null);
  }
}

///this class holds user session data
class Session {
  final roomId, sessionId, teamId;
  final Task task;
  final DateTime startTime;
  DateTime endTime;
  Duration extraDuration;

  Session({this.teamId, @required this.task, @required this.roomId, @required this.sessionId, @required this.startTime, this.endTime, this.extraDuration = Duration.zero});

  factory Session.fromJson(Map json) => Session(
      teamId: json['task']['teamId'],
      task: Task.formJson(json['task']),
      roomId: json['task']['team']['roomId'],
      sessionId: json['id'],
      endTime: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      extraDuration: json['extraTime'] != null ? Duration(minutes: json['extraTime']) : Duration.zero,
      startTime: DateTime.parse(json['startDate']));

  Session copyWith({int taskId, int roomId, int teamId, int sessionId, DateTime startTime, DateTime endTime}) {
    return Session(
        task: taskId ?? this.task,
        roomId: roomId ?? this.roomId,
        teamId: teamId ?? this.teamId,
        sessionId: sessionId ?? this.sessionId,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime);
  }

  ///calculates session duration if the [endTime] is not null
  Duration get duration {
    if (endTime != null) {
      return endTime.difference(startTime);
    }
    return null;
  }

  Duration get totalDuration => duration + extraDuration;
}
