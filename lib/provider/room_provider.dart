import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '/constants.dart';
import '/model/room.dart';
import '/model/http_exception.dart';
import 'data_constants.dart';

class RoomProvider extends ChangeNotifier {
  List<Room> _rooms;

  //String name, String description
  Future<void> createRoom() async {
    const url = server + KCreateRoom;

    final response = await http.post(Uri.parse(url),
        headers: header,
        body: json.encode({
          // 'id':1,
          "name": "room3",
          "description": "string",
        }));

    print('status code: ${response.statusCode}');
    print('${response.headers}');
    print('${response.contentLength}');
    print('${response.body}');
    print('${response.reasonPhrase}');
    print('${response.request}');
    final responseData = json.decode(response.body);
    print(responseData);
  }

  Future<void> getUserRooms() async {
    const url = server + KGetUserRoomsEndpoint;

    final response = await http.get(Uri.parse(url), headers: header);

    print('status code: ${response.statusCode}');
    print('${response.headers}');
    print('${response.body}');
    print('${response.reasonPhrase}');
    print('${response.request}');
    final responseData = json.decode(response.body);
    print(responseData);
  }
}
