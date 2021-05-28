import 'package:flutter/cupertino.dart';
import 'package:project/model/models.dart';

class Room {
   String name, description;
  final DateTime createdAt;
  final User creator;
  final int id;

  Room({@required this.name, @required this.description, @required this.createdAt, @required this.creator, @required this.id});

  factory Room.formJson(Map<String, dynamic> json) {
    return Room(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      createdAt: DateTime.parse(json["createdAt"]),
      creator: null,
    );
  }
}
