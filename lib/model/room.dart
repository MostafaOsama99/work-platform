import 'package:project/model/task.dart';

class Room {
  final String name, description;
  final DateTime createdAt;
  final User creator;
  final int id;

  const Room(
      this.name, this.description, this.createdAt, this.creator, this.id);
}
