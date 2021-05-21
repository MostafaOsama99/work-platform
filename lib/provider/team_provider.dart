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

  List<Task> get tasks => [..._team.tasks.reversed];

  Future<void> joinTeam(String teamCode) => get('/users/jointeam/$teamCode', (_) {});

  ///create team under a specific team
  Future<bool> createTeam(int roomId, String name, String description) => post(
      '/teams/rooms/$roomId/parentteam/${_team.id}',
      json.encode({
        'name': name,
        'description': description,
      })
      //, (responseData) => null
      );

  updateTeam(String name, String description) async {
    bool _isSuccess = await put('/teams/${_team.id}', json.encode({'name': name ?? _team.name, 'description': description ?? _team.description}));
    if (_isSuccess != null) {
      _team.name = name ?? _team.name;
      _team.description = description ?? _team.description;
      notifyListeners();
    }
  }

  Future<void> fetchMembers() => get('/teams/${_team.id}/members', (response) {
        _team.members = List.generate((response as List).length, (index) => User.fromJson(response[index]));
      });

  Future<void> createTask(Task task) async {
    int newTaskId;
    await post(
        //if the task is assigned to a team, it will have the team, other wise : it will have member's team
        task.parentCheckpoint == null ? '/teams/${task.assignedTeam.id}/tasks' : '/tasks/subtask/${task.parentCheckpoint.id}',
        json.encode({
          "name": task.name,
          "description": task.description,
          "plannedStartDate": task.datePlannedStart.toIso8601String(),
          "plannedEndDate": task.datePlannedEnd.toIso8601String(),
          "actualStartDate": task.dateActualStart.toIso8601String(),
          "isFinished": false,
          "childCheckpoints":
              List.generate(task.checkPoints.length, (index) => {"checkpointText": task.checkPoints[index].name, "description": task.checkPoints[index].description}),
        }),
        (response) => newTaskId = response as int);
    //assign team members
    if (task.assignedTeam.id == _team.id) await assignMembers(newTaskId, task.members);
  }

  //assign members to the task
  //updates data locally, should i re-fetch it instead ??
  assignMembers(int taskId, List<User> assignedMembers) =>
      post('/tasks/$taskId/assignedusers', json.encode(List.generate(assignedMembers.length, (index) => assignedMembers[index].userName)), (_) {
        _team.tasks.firstWhere((task) => task.id == taskId).members.addAll(assignedMembers);
      });

  getTasks() async {
    fetchMembers();

    await get('/teams/${_team.id}/tasks', (response) {
      _team.tasks = [];
      (response as List).forEach((task) => _team.tasks.add(Task.formJson(task)));
    });
  }

  ///find specific task by id
  Task findById(int id) => _team.tasks.firstWhere((task) => task.id == id);

  removeAssignedMembers(int taskId, List<String> removedUserNames) => delete('/tasks/$taskId/assignedusers', json.encode(removedUserNames), (_) {
        team.tasks.firstWhere((task) => task.id == taskId).members.removeWhere((member) => removedUserNames.contains(member.userName));
        notifyListeners();
      });
}
