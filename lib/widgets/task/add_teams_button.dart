import 'package:flutter/material.dart';

import '../../constants.dart';

Widget addTeamsButton(
    {String hintText,
      Function onPressed}) {
  return RaisedButton(
    onPressed: onPressed,
    color:  COLOR_ACCENT,
    child: Text(hintText,style: TextStyle(fontSize: 16,color: Colors.white),),
  );
}