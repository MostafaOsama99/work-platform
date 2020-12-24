import 'package:flutter/foundation.dart';

//! this model may have a provider

class Task{
  //TODO:check if id is string or double
  final String name, id, description;
  final DateTime created, deadline ;
  double progress;

  Task({this.created, this.deadline, @required this.name, this.id,@required this.description});
}