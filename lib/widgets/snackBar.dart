import 'package:flutter/material.dart';

Widget snackBar(String title, Color backgroundColor) {
  return SnackBar(
    content: SizedBox(
        height: 18,
        child: Center(
            child: Text(title, style: const TextStyle(color: Colors.white)))),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    padding: EdgeInsets.zero,
    behavior: SnackBarBehavior.floating,
    backgroundColor: backgroundColor,
  );
}
