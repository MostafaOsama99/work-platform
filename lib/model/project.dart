import 'package:flutter/material.dart';
import 'package:project/model/models.dart';

class Project {
  final String projectName, mangerName;
  final int id;
  final List<Teams> teams;
  DateTime startDate, endDate;
  final bool isFinished;
  final String description;

  Project(
      {this.teams,
      this.startDate,
      this.endDate,
      this.projectName,
      this.mangerName,
      this.id,
      this.isFinished,
      this.description});
}

class Teams {
  final String teamName, leaderName, description;
  final attachments;
  final int id;
  final listOfUser;
  final List<Task> tasks;

  Teams({this.teamName, this.leaderName, this.attachments, this.description, this.id, this.listOfUser, this.tasks});
}

class Attachments {
  final int id;
  final String name;
  final String url;
  final String date;
  Attachments({this.id,this.name,this.date,this.url});
}