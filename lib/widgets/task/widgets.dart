import 'package:flutter/material.dart';

Widget addTeamsButton(
    {String hintText,
      Function onPressed}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: 38,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white)
      ),
      child: Center(child: Text(hintText,style: TextStyle(fontSize: 20,color: Colors.white),)),
    ),
  );
}