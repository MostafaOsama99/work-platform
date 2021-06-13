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

  String get roomDescription => _room.description;

  String get roomName => _room?.name;

  List<Room> get rooms => [..._rooms];

  List<Team> get roomTeams => [..._roomTeams];

  User get roomCreator => _room.creator;

  int get roomId => _room?.id;

  // 0 means no open session
  Session _currentSession;

  Session get session => _currentSession;

  Duration _previousSessionsDuration = Duration.zero;

  Duration get previousSessionsDuration => _previousSessionsDuration;

  void setSessionExtraDuration(Duration duration) {
    _currentSession.extraDuration = duration ?? Duration.zero;
    notifyListeners();
  }

  List<Session> _previousSessions = [];

  bool isRoomCreator(username) => username == _room.creator.userName;

  void clear() {
    _room = null;
    _rooms = [];
    _roomTeams = [];
    _currentSession = null;
    _previousSessions = [];
  }

  //set changeCurrentRoomId(int value) => _room = value;

  //int get currentRoomId => _roomId;

  void changeRoom(int roomId) {
    _room = _rooms.firstWhere((room) => room.id == roomId);
    getUserTeams(reload: true);
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
      return null;
    }

    print('getting teams');
    await get('/users/rooms/${roomId ?? _room.id}/teams', (responseData) {
      _roomTeams = [];
      (responseData as List<dynamic>).forEach((element) => _roomTeams.add(Team.fromJson(element)));
    });
  }

  updateRoom(String name, String description) async {
    bool _isSuccess = await put('/rooms/${_room.id}', json.encode({'name': name ?? _room.name, 'description': description ?? _room.description}));
    if (_isSuccess != null) {
      _room.name = name ?? _room.name;
      _room.description = description ?? _room.description;
      notifyListeners();
    }
  }

  /// get all current user rooms
  Future<void> getUserRooms() => get(KGetUserRoomsEndpoint,
          //save user rooms in _rooms
          (rooms) {
        _rooms = [];
        (rooms as List)
            .forEach((element) => _rooms.add(Room.formJson(element)));
      });

  //TODO REFACTOR: create session provider separated out of room provider
  Future<void> openSession(Session session) => get('/users/task/${session.task.id}/sessions/open', (response) {
        print(response);
        _currentSession = session.copyWith(sessionId: response);
      });

  Future<void> closeSession() => get('/users/task/sessions/${_currentSession.sessionId}/close?extra-time=${session.extraDuration?.inMinutes ?? 0}', (_) {
        _previousSessions.add(_currentSession);
        _previousSessionsDuration += _currentSession.extraDuration;
        _currentSession = null;
        notifyListeners();
      });

  Future<void> currentSession() => get('/users/task/sessions/current', (response) async {
        if (response != null) {
          _currentSession = Session.fromJson(response);
        }
      });

  /// this API returns all sessions between given time, and if there's an opened one (active session) it returns also.
  /// so we have to remove this one to [_currentSession] as opened one, and to calculate [_previousSessionsDuration] correctly
  Future<void> getPreviousSessions(DateTime startTime, DateTime endTime) =>
      get('/users/task/sessions?start-date=${startTime.toIso8601String()}&end-date=${endTime.toIso8601String()}', (response) {
        if ((response as List).isNotEmpty) {
          _previousSessions = [];
          (response as List).forEach((json) {
            if (json['endDate'] == null) {
              _currentSession = Session.fromJson(json);
            } else
              _previousSessions.add(Session.fromJson(json));
          });
          _calcPreviousSessionsDuration();
        }
      });

  void _calcPreviousSessionsDuration() {
    Duration total = Duration.zero;
    _previousSessions.forEach((session) => total += session.totalDuration);
    _previousSessionsDuration = total;
  }

  Future<void> updateSessionTask(Task sessionTask) async {
    await put(
        '/tasks/${sessionTask.id}',
        json.encode({
          "name": sessionTask.name,
          "childCheckpoints":
              List.generate(sessionTask.checkPoints.length, (index) => {'id': sessionTask.checkPoints[index].id ?? 0, 'percentage': sessionTask.checkPoints[index].percentage}),
        }),
        (_) {});

    // if(_)
    // //internal update
    // int taskIndex = _team.tasks.indexOf(findById(newTask.id));
    // _team.tasks[taskIndex] = await getTaskById(newTask.id);
    notifyListeners();
  }
}