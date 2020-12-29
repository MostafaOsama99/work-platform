import 'package:flutter/material.dart';

void loadDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10.0,
          content: Row(
            children: <Widget>[
              Text("loading"),
              SizedBox(
                width: 20.0,
              ),
              CircularProgressIndicator(),
            ],
          ),
        );
      });
}
