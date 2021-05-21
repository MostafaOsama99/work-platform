import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/models.dart';
import '../model/taskType.dart';
import 'data_constants.dart';

class TeamProvider extends ChangeNotifier {
  Team _team;

  Team get team => _team;

  set changeTeam(Team value) {
    _team = value;
    notifyListeners();
  }

  List<Task> get tasks => [..._team.tasks];

  Future<void> joinTeam(String teamCode) => get('/users/jointeam/$teamCode', (_) {});

  Future<void> fetchMembers() => get('/teams/${_team.id}/members', (response) {
        _team.members = List.generate((response as List).length, (index) => User.fromJson(response[index]));
      });

  Future<void> createTask(Task task) async {
    print(task.datePlannedStart.toIso8601String());

    final response = await post(
        //if the task is assigned to a team, it will have the team, other wise : it will have member's team
        task.parentCheckpoint == null ? '/teams/${task.assignedTeam.id}/tasks' : '/tasks/subtask/${task.parentCheckpoint.id}',
        json.encode({
          "name": task.name,
          "description": task.description,
          "plannedStartDate": "2021-05-16T11:45:21.125Z",
          "plannedEndDate": "2021-05-20T11:45:21.125Z",
          "actualStartDate": "2021-05-16T11:45:21.125Z",
          //"isFinished": false,
          "childCheckpoints":
              List.generate(task.checkPoints.length, (index) => {"checkpointText": task.checkPoints[index].name, "description": task.checkPoints[index].description}),
        }));
    print(response);
    //assign team members
    // if (task.assignedTeam.id == _team.id)
    //   await post('/tasks/{taskId}/assignedusers', json.encode(List.generate(task.members.length, (index) => task.members[index].userName)));
  }

  // //green task
  // _createNewTask(Task task) => post(
  //   //if the task is assigned to a team, it will have the team, other wise : it will have member's team
  //     '/teams/${task.assignedTeam.id}/tasks',
  //     json.encode({
  //       "name": task.name,
  //       "description": task.description,
  //       "plannedStartDate": task.datePlannedStart.toIso8601String(),
  //       "plannedEndDate": task.datePlannedEnd.toIso8601String(),
  //       "actualStartDate": task.dateActualStart.toIso8601String(),
  //       "isFinished": false,
  //       "childCheckpoints":
  //       List.generate(task.checkPoints.length, (index) => {"checkpointText": task.checkPoints[index].name, "description": task.checkPoints[index].description}),
  //     }));
  //
  // _createSubTask (Task task) => post(
  //   //if the task is assigned to a team, it will have the team, other wise : it will have member's team
  //     '/teams/${task.assignedTeam.id}/tasks',
  //     json.encode({
  //       "name": task.name,
  //       "description": task.description,
  //       "plannedStartDate": task.datePlannedStart.toIso8601String(),
  //       "plannedEndDate": task.datePlannedEnd.toIso8601String(),
  //       "actualStartDate": task.dateActualStart.toIso8601String(),
  //       "isFinished": false,
  //       "childCheckpoints":
  //       List.generate(task.checkPoints.length, (index) => {"checkpointText": task.checkPoints[index].name, "description": task.checkPoints[index].description}),
  //     }));

  getTasks() async {
    fetchMembers();
    await get('/teams/${_team.id}/tasks', (response) {
      _team.tasks = [];
      (response as List).forEach((task) => _team.tasks.add(Task.formJson(task)));
    });
  }
}
