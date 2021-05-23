import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:project/model/models.dart';
import 'package:http/http.dart' as http;

import '/constants.dart';
import '/model/http_exception.dart';
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

  int get roomId => _room.id;

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
  getUserTeams({bool reload = false, int roomId}) {
    if (!reload && roomId == null) {
      print('Exit');
      return null;
    }

    print('getting teams');
    return get('/users/rooms/${roomId ?? _room.id}/teams', (responseData) {
      _roomTeams = [];
      (responseData as List<dynamic>)
          .forEach((element) => _roomTeams.add(Team.fromJson(element)));
    });
  }

  /// get all current user rooms
  Future<void> getUserRooms() => get(KGetUserRoomsEndpoint,
          //save user rooms in _rooms
          (rooms) {
        (rooms as List).forEach((element) => _rooms.add(Room.formJson(element)));
      });
}
