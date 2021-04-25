import 'package:flutter/material.dart';

import '../constants.dart';

///alert the user to end the current session to start a new session
class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String text;

  const CustomAlertDialog({this.text, this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: COLOR_SCAFFOLD,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            child: Text(text,
                softWrap: true,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  height: 1.4,
                  color: Colors.white,
                  fontSize: 16.5,
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlineButton(
                  padding: EdgeInsets.zero,
                  highlightedBorderColor: Colors.red,
                  child: Transform.rotate(
                      angle: 3.14 / 4,
                      child: Icon(Icons.add, color: Colors.red)),
                  onPressed: () => Navigator.of(context).pop()),
              OutlineButton(
                  padding: EdgeInsets.zero,
                  highlightedBorderColor: Colors.green,
                  child: Icon(Icons.done, color: Colors.green),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  }),
            ],
          )
        ],
      ),
    );
  }
}
