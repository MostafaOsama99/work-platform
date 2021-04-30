import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:project/model/models.dart';

import '/constants.dart';
import '/model/room.dart';
import '/model/http_exception.dart';
import 'data_constants.dart';

class RoomProvider extends ChangeNotifier {
  Room _room;

  int _parentTeamId = 1;

  ///user rooms
  List<Room> _rooms = [];

  get roomDescription => _room.description;

  List<Room> get rooms => [..._rooms];

  List<Team> _roomTeams = [];

  List<Team> get roomTeams => _roomTeams;

  User get roomCreator => _room.creator;

  int get roomId => _room.id;

  //set changeCurrentRoomId(int value) => _room = value;

  //int get currentRoomId => _roomId;

  void changeRoom(int roomId) {
    _room = _rooms.firstWhere((room) => room.id == roomId);
    notifyListeners();
  }

  Future<void> createTeam(String name, String description) => _post(
      '/teams/rooms/${_room.id}/parentteam/$_parentTeamId',
      json.encode({
        'name': name,
        'description': description,
      }),
      (responseData) => null);

  // Future<void> getRoom([int roomId]) =>
  //     _get('/rooms/${roomId?? _roomId}', (responseData) {
  //       (responseData as Map<String,dynamic>)
  //     });

  Future<void> createRoom(String name, String description) => _post(
      KCreateRoom,
      json.encode({"name": name, "description": description}),
      (responseData) => null);

  ///get all user team in current room
  Future<void> getUserTeams([int roomId]) =>
      _get('/users/rooms/${roomId ?? _room.id}/teams', (responseData) {
        (responseData as List<Map<String, dynamic>>)
            .forEach((element) => _roomTeams.add(Team.fromJson(element)));
      });

  /// get all current user rooms
  Future<void> getUserRooms() => _get(KGetUserRoomsEndpoint,
          //save user rooms in _rooms
          (rooms) {
        (rooms as List)
            .forEach((element) => _rooms.add(Room.formJson(element)));
      });

  ///generic get method
  Future<void> _get(
      String endpoint, Function(dynamic responseData) onSuccess) async {
    final url = server + endpoint;

    final response = await http
        .get(Uri.parse(url), headers: header)
        .timeout(KTimeOutDuration);

    print(response.body);
    print(response.headers);
    print(response.statusCode);
    print('${response.request}');

    if (response.statusCode == 200) {
      onSuccess(json.decode(response.body));
      return;
    } else
      throw ServerException(json.decode(response.body));
  }

  ///generic post method
  Future<void> _post(String endpoint, String body,
      Function(String responseData) onSuccess) async {
    final url = server + endpoint;

    final response = await http
        .post(Uri.parse(url), headers: header, body: body)
        .timeout(KTimeOutDuration);

    print(response.body);
    print(response.headers);
    print(response.statusCode);
    print('${response.request}');

    //final responseData = json.decode(response.body);
    print('body: ${response.body}');

    if (response.statusCode == 200) {
      onSuccess(response.body);
      return;
    } else
      throw ServerException(response.body);
  }
}
