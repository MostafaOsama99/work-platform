import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/models.dart';
import '../model/taskType.dart';
import 'data_constants.dart';

class TeamProvider extends ChangeNotifier {
  TeamProvider([this._team]);

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
    //print(task.parentCheckpoint.id);
    String newTaskId;
    await post(
      //if the task is assigned to a team, it will have the team, other wise : it will have member's team
        task.parentCheckpoint == null ? '/teams/${task.assignedTeam.id}/tasks' : '/tasks/subtask/${task.parentCheckpoint.id}',
        json.encode({
          "teamId": _team.id,
          "name": task.name,
          "description": task.description,
          "plannedStartDate": task.datePlannedStart.toIso8601String(),
          "plannedEndDate": task.datePlannedEnd.toIso8601String(),
          "actualStartDate": task.dateActualStart.toIso8601String(),
          "isFinished": false,
          "childCheckpoints":
          List.generate(task.checkPoints.length, (index) => {"checkpointText": task.checkPoints[index].name, "description": task.checkPoints[index].description}),
        }),
            (response) => newTaskId = response);
    //assign team members
    if (task.assignedTeam.id == _team.id) await post('/tasks/$newTaskId/assignedusers', json.encode(List.generate(task.members.length, (index) => task.members[index].userName)));
  }

  //assign members to the task
  //updates data locally, should i re-fetch it instead ??
  assignMembers(int taskId, List<User> assignedMembers) =>
      post('/tasks/$taskId/assignedusers', json.encode(List.generate(assignedMembers.length, (index) => assignedMembers[index].userName)), (_) {
        _team.tasks.firstWhere((task) => task.id == taskId).members.addAll(assignedMembers);
      });

  Future<void> getTasks([bool reload = false]) async {
    if (!reload) return;
    //TODO: remove fetch members call from here
    fetchMembers();

    await get('/teams/${_team.id}/tasks', (response) {
      _team.tasks = [];
      (response as List).forEach((task) {
        print(task);
        _team.tasks.add(Task.formJson(task));
      });
    });
  }

  ///find specific task by id
  Task findById(int id) => _team.tasks.firstWhere((task) => task.id == id);

  removeAssignedMembers(int taskId, List<String> removedUserNames) => delete('/tasks/$taskId/assignedusers', json.encode(removedUserNames), (_) {
    team.tasks.firstWhere((task) => task.id == taskId).members.removeWhere((member) => removedUserNames.contains(member.userName));
    notifyListeners();
  });

  updateTask(Task newTask) async {
    newTask.checkPoints.forEach((element) => print(element.id));
    await put(
        '/tasks/${newTask.id}',
        json.encode({
          "name": newTask.name,
          "description": newTask.description,
          "plannedStartDate": newTask.datePlannedStart.toIso8601String(),
          "plannedEndDate": newTask.datePlannedEnd.toIso8601String(),
          "childCheckpoints": List.generate(newTask.checkPoints.length,
                  (index) => {'id': newTask.checkPoints[index].id ?? 0, "checkpointText": newTask.checkPoints[index].name, "description": newTask.checkPoints[index].description}),
        }),
            (_) {});
    //internal update
    int taskIndex = _team.tasks.indexOf(findById(newTask.id));
    _team.tasks[taskIndex] = await getTaskById(newTask.id);
    notifyListeners();
  }

  Future<Task> getTaskById(int taskId) async {
    Task _task;
    await get('/tasks/$taskId', (res) {
      print(res['assignedUsers']);
      _task = Task.formJson(res);
    });
    return _task;
  }

  Future<void> deleteCheckpoints(List<int> checkpoints) async => delete('/checkpoints', json.encode(checkpoints));
}
