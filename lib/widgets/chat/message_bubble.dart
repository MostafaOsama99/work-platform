import 'package:flutter/material.dart';

import '../../constants.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (isMe) Spacer(flex: 2),
            Flexible(
              flex: 11,
              child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 12, left: 12, right: 12, bottom: 12),
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? COLOR_BACKGROUND : COLOR_ACCENT,
                    borderRadius: isMe
                        ? BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15))
                        : BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                  )),
            ),
            if (!isMe) Spacer(flex: 2)
          ]),
    );
  }
}

class Messages {
  final bool isMe;
  final String text;
  final String senderName;

  Messages({this.isMe = false, this.text, this.senderName});
}
