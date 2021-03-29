import 'package:flutter/material.dart';
import 'package:project/demoData.dart';

import '../../constants.dart';
import '../chat_screen.dart';

const KTapTS = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
 List <String> lastMessages =['bye',"see you later", 'hello','okey'];
class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(45),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(KAppBarRound), bottomRight: Radius.circular(KAppBarRound)),
              child: Container(
                color: COLOR_SCAFFOLD,
                //padding: const EdgeInsets.only(top: 15),
                child: TabBar(
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: COLOR_ACCENT,
                  // indicator: BoxDecoration(
                  //   borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight:Radius.circular(15),),
                  //   color: COLOR_ACCENT
                  //     ),
                  tabs: [
                    Tab(
                      key: UniqueKey(),
                      child: Text('Teams', style: KTapTS),
                    ),
                    Tab(
                      key: UniqueKey(),
                      child: Text('Individual', softWrap: false, style: KTapTS),
                    ),
                    Tab(
                      key: UniqueKey(),
                      child: Text('Tasks', style: KTapTS),
                    )
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              ListView.separated(
                  itemBuilder: (_, index) => InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {

                        return ChatScreen();
                      }));
                    },
                    child: ChatTile(
                          chatName: teams[index].name,
                          lastMessage: lastMessages[index],
                          announce: 3,
                          issue: 4,
                        ),
                  ),
                  separatorBuilder: (_, index) => Divider(endIndent: 20, indent: 20, height: 10),
                  itemCount: teams.length),
              ListView.separated(
                  itemBuilder: (_, index) => InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {

                        return ChatScreen();
                      }));
                    },
                    child: ChatTile(
                      chatName: "Mohamed (Hr)",
                      lastMessage: lastMessages[index],
                      announce: 3,
                      issue: 4,
                    ),
                  ),
                  separatorBuilder: (_, index) => Divider(endIndent: 20, indent: 20, height: 10),
                  itemCount: 1),
              ListView.separated(
                  itemBuilder: (_, index) => InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {

                        return ChatScreen();
                      }));
                    },
                    child: ChatTile(
                      chatName: "Assign tasks",
                      lastMessage: lastMessages[index],
                      announce: 3,
                      issue: 4,
                    ),
                  ),
                  separatorBuilder: (_, index) => Divider(endIndent: 20, indent: 20, height: 10),
                  itemCount: 1),
            ],
          ),
        ),
      ),
    );
  }
}

class TeamsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ChatTile extends StatelessWidget {
  final String chatName;
  final int announce, issue;
  final  lastMessage;
  final DateTime timeStamp;

  const ChatTile(
      {Key key,
      @required this.chatName,
      this.announce = 0,
      this.issue = 0,
      this.lastMessage ,
      this.timeStamp})
      : super(key: key);

  String internalFormatDate() {
    if (timeStamp == null) return '';
    var duration = DateTime.now().difference(timeStamp);
    if (duration < const Duration(days: 1))
      return 'today';
    else if (duration < const Duration(days: 2))
      return 'yesterday';
    else
      return formatDate(timeStamp);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
                height: 50,
                width: 50,
                child: CircleAvatar(
                  backgroundColor: COLOR_BACKGROUND,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(
                      'assets/icons/team-2.png',
                      color: Colors.grey.shade600,
                    ),
                  ),
                )),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                            child: Text(
                          chatName,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 17),
                        )),
                        Row(
                          children: [
                            if (announce > 0)
                              Container(
                                decoration:
                                    BoxDecoration(color: COLOR_BACKGROUND, borderRadius: BorderRadius.circular(15)),
                                padding: const EdgeInsets.all(2),
                                height: 27,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: Text('$announce',
                                          style: const TextStyle(color: Colors.white70, fontSize: 14)),
                                    ),
                                    Image.asset('assets/icons/announce.png')
                                  ],
                                ),
                              ),
                            SizedBox(width: 4),
                            if (issue > 0)
                              Container(
                                padding: const EdgeInsets.all(2),
                                height: 27,
                                decoration:
                                    BoxDecoration(color: COLOR_BACKGROUND, borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child:
                                          Text('$issue', style: const TextStyle(color: Colors.white70, fontSize: 14)),
                                    ),
                                    Image.asset('assets/icons/issue.png')
                                  ],
                                ),
                              )
                          ],
                        )
                      ]),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          child: Text(
                        lastMessage,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: const TextStyle(color: Colors.white54, fontSize: 15),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(left: 6, right: 2),
                        child: Text(internalFormatDate(), style: const TextStyle(color: Colors.white54, fontSize: 13)),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
