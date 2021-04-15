import 'package:flutter/material.dart';
void dialogException(BuildContext context,messageHead, message) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$messageHead"),
          content: Text("$message"),
          actions: [
            FlatButton(
              child: Text("okey"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      });
}

void successOperation(BuildContext context, messageHead, message) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$messageHead"),
          content: Text("$message"),
          actions: [
            FlatButton(
                child: Text("okey"),
                onPressed: () {
                  Navigator.pop(context);
                }
            ),
          ],
        );
      });
}