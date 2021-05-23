import 'package:flutter/material.dart';
import 'package:project/model/message.dart';
import 'package:project/widgets/chat/message_bubble.dart';

import '../constants.dart';
import '../demoData.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(KAppBarRound),
              bottomRight: Radius.circular(KAppBarRound)),
          child: AppBar(
            centerTitle: true,
            title: Text("Chat"),
            elevation: 10,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: messagesList.length,
                itemBuilder: (context, i) {
                  return MessageBubble(
                      message: messagesList[i],
                      previousIsSameUser: i > 0
                          ? (messagesList[i - 1].isMe == messagesList[i].isMe)
                          : false);
                }),
          ),
          LimitedBox(
            maxHeight: 125,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8, bottom: 6, top: 5),
              child: TextField(
                textInputAction: TextInputAction.newline,
                autofocus: false,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  //suffixIconConstraints: BoxConstraints(maxHeight: 30),

                  suffixIcon: Padding(
                    padding:
                        const EdgeInsets.only(right: 15, bottom: 12, top: 12),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset('assets/icons/send_icon.png', color: Colors.grey[600], height: 28.5),
                        Image.asset('assets/icons/send_icon.png', color: COLOR_ACCENT, height: 27),
                      ],
                    ),
                  ),
                  hintText: "Message ..",
                  contentPadding:
                      EdgeInsets.only(left: 15, right: 15, bottom: 8, top: 8),
                  isDense: true,
                  filled: true,
                  fillColor: COLOR_BACKGROUND,
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15)),
                  ),
                ),
              ),
            ),
          ),
          // Container(
          // margin: EdgeInsets.only(left: 20),
          //   padding: const EdgeInsets.all(8),
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: COLOR_ACCENT
          //   ),
          //   child: Image.asset('assets/send_icon.png', color: COLOR_BACKGROUND, height: 30,),
          // ),
        ],
      ),
    );
  }
}
