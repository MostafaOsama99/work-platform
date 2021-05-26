import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:project/model/models.dart';
import 'package:project/provider/team_provider.dart';
import '/model/room.dart';
import 'data_constants.dart';

class RoomProvider extends ChangeNotifier {
  Room _room;

  ///user rooms
  List<Room> _rooms = [];

  List<Team> _roomTeams = [];

  get roomDescription => _room.description;

  List<Room> get rooms => [..._rooms];

  List<Team> get roomTeams => [..._roomTeams];

  User get roomCreator => _room.creator;

  int get roomId => _room?.id;

  // 0 means no open session
  Session _currentSession;

  Session get session => _currentSession;

  //set changeCurrentRoomId(int value) => _room = value;

  //int get currentRoomId => _roomId;

  void changeRoom(int roomId) {
    _room = _rooms.firstWhere((room) => room.id == roomId);
    //getUserTeams(reload: true);
    notifyListeners();
  }

  // Future<void> getRoom([int roomId]) =>
  //     _get('/rooms/${roomId?? _roomId}', (responseData) {
  //       (responseData as Map<String,dynamic>)
  //     });
  //Your are invited to join my  Room 2/main  team
  // Kindly use this code to join: 48cb2ab3-f3e3-49f8-8198-b78272286c34

  Future<bool> createRoom(String name, String description) => post(KCreateRoom, json.encode({"name": name, "description": description})
      //, (_) => true
      );

  ///get all user team in current room from the database
  /// it does not load the data unless u set [reload] to true, or if uou send another [roomId] it will load the new room teams
  Future<void> getUserTeams({bool reload = false, int roomId}) async {
    if (!reload && roomId == null) {
      print('Exit');
      return null;
    }

    print('getting teams');
    await get('/users/rooms/${roomId ?? _room.id}/teams', (responseData) {
      _roomTeams = [];
      (responseData as List<dynamic>).forEach((element) => _roomTeams.add(Team.fromJson(element)));
    });
  }

  /// get all current user rooms
  Future<void> getUserRooms() => get(KGetUserRoomsEndpoint,
          //save user rooms in _rooms
          (rooms) {
        (rooms as List).forEach((element) => _rooms.add(Room.formJson(element)));
      });

  openSession(Session session) => get('/users/task/${session.task.id}/sessions/open', (response) {
        print(response);
        _currentSession = session.copyWith(sessionId: response);
      });

  closeSession() => get('/users/task/sessions/${_currentSession.sessionId}/close?extra-time=0', (_) {
        _currentSession = null;
      });

  Future<void> currentSession() => get('/users/task/sessions/current', (response) async {
        if (response != null) {
          print(response['task']);
          (response as Map).keys.forEach((element) {
            print(element);
          });
          await getTaskById(response['taskId']).then((task) {
            response['task'] = task;
            print(task);
            print(response['task']);
            _currentSession = Session.fromJson(response);
          });
        }
      });

  updateSessionTask(Task sessionTask) async {
    sessionTask.checkPoints.forEach((element) => print(element.id));
    await put(
        '/tasks/${sessionTask.id}',
        json.encode({
          "name": sessionTask.name,
          "description": sessionTask.description,
          "plannedStartDate": sessionTask.datePlannedStart.toIso8601String(),
          "plannedEndDate": sessionTask.datePlannedEnd.toIso8601String(),
          "childCheckpoints": List.generate(
              sessionTask.checkPoints.length,
              (index) => {
                    'id': sessionTask.checkPoints[index].id ?? 0,
                    "checkpointText": sessionTask.checkPoints[index].name,
                    "description": sessionTask.checkPoints[index].description,
                    'percentage': sessionTask.checkPoints[index].percentage
                  }),
        }),
        (_) {});

    // if(_)
    // //internal update
    // int taskIndex = _team.tasks.indexOf(findById(newTask.id));
    // _team.tasks[taskIndex] = await getTaskById(newTask.id);
    notifyListeners();
  }
}

//TODO: remove this
Future<Map> getTaskById(int taskId) async {
  Map _task;
  await get('/tasks/$taskId', (res) {
    _task = res;
  });
  return _task;
}
