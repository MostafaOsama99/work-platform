import 'package:flutter/material.dart';

Widget addTeamsButton(
    {String hintText,
      Function onPressed}) {
  return RaisedButton(
    onPressed: onPressed,
    color: const Color.fromRGBO(39, 142, 165, 1),
    child: Text(hintText,style: TextStyle(fontSize: 16,color: Colors.white),),
  );
}