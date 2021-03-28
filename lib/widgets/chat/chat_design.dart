import 'package:flutter/material.dart';

import '../../constants.dart';
class messageBuble extends StatelessWidget {
  messageBuble({this.sender, this.text,this.IsMe});

  final String sender;
  final String text;
  final bool IsMe;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: IsMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
              child: Padding(
                padding: EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 12),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),

              decoration: BoxDecoration(
                color: IsMe ? COLOR_BACKGROUND : COLOR_ACCENT,
                borderRadius:IsMe?  BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)): BorderRadius.only( bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30), topRight: Radius.circular(30)),

              )),
        ],
      ),
    );
  }}
class Messages {
  final bool isMe;
  final String text;
  final String senderName;
  Messages({this.isMe=false,this.text,this.senderName});
}
