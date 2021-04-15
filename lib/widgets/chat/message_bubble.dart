import 'package:flutter/material.dart';

import '../../model/message.dart';
import '../../constants.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool previousIsSameUser;

  const MessageBubble({Key key, this.message, this.previousIsSameUser = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (message.isMe) Spacer(flex: 2),
          Flexible(
            flex: 11,
            child: Container(
                padding: const EdgeInsets.all(8),
                margin: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    bottom: 3,
                    top: previousIsSameUser ? 0 : 7),
                child: Wrap(
                  alignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    Text('${message.message}  ',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 1)),
                    Text(
                      message.time,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 12,
                          color: message.isMe
                              ? Colors.grey.shade700
                              : Color.fromRGBO(106, 131, 187, 1)),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: message.isMe
                      ? Color.fromRGBO(40, 40, 50, 1)
                      : COLOR_ACCENT,
                  borderRadius: message.isMe
                      ? BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(5),
                          topRight:
                              Radius.circular(previousIsSameUser ? 15 : 5))
                      : BorderRadius.only(
                          topLeft: Radius.circular(previousIsSameUser ? 15 : 5),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                )),
          ),
          if (!message.isMe) Spacer(flex: 2)
        ]);
  }
}
