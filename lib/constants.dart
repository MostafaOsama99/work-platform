import 'package:flutter/material.dart';

// maximum height for TextFormField error text height
//   usually between 0-1
const ERROR_TEXT_STYLE = 0.4;
const COLOR_BACKGROUND = Color.fromRGBO(27, 32, 41, 1);
const COLOR_ACCENT = Color.fromRGBO(13, 56, 120, 1);
const COLOR_SCAFFOLD = Color.fromRGBO(17, 20, 25, 1);
const PADDING_VERTICAL = 12.0;

const HEIGHT_APPBAR = 50.0;

// default TextFormField decoration
// ignore: non_constant_identifier_names
final TEXT_FIELD_DECORATION = InputDecoration(
  filled: true,
  errorStyle: TextStyle(height: 0),
  fillColor: Colors.white,

  ///use it in case => theme brightness: Brightness.dark,
  //hintStyle: TextStyle(color: Colors.grey),
  contentPadding: const EdgeInsets.only(left: 20, bottom: 0, top: 0),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2),
    borderRadius: BorderRadius.circular(25),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(25),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.5),
    borderRadius: BorderRadius.circular(25),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(25),
  ),
  // disabledBorder: OutlineInputBorder(
  //   borderSide: BorderSide(color: Colors.white),
  //   borderRadius: BorderRadius.circular(25.7),
  // ),
);

// ignore: non_constant_identifier_names
final InputDecoration TEXT_FIELD_DECORATION_2 = InputDecoration(
  fillColor: COLOR_BACKGROUND,
  //Colors.blueGrey.shade800,
  filled: true,
  contentPadding: const EdgeInsets.all(16),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.transparent),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.transparent),
  ),
);


bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}
