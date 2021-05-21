import 'package:flutter/material.dart';
import 'package:project/demoData.dart';
import 'package:project/screen/profile_screen.dart';
import 'package:project/widgets/notification_widgets.dart';

import '../constants.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(KAppBarRound),
              bottomRight: Radius.circular(KAppBarRound)),
          child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Profile();
                      }));
                    },
                    child: Text("Notification", style: TextStyle(color: Colors.white))),
              ],
            ),
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: notifications.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => notifications[index],
        separatorBuilder: (__, _) => Divider(indent: 25, endIndent: 25),
      ),
    );
  }
}

List<EventButton> buttons = [
  EventButton(
    onTap: () {

    },
    text: 'allow',
    key: UniqueKey(),
  ),
  EventButton(
    onTap: () {},
    text: 'deny',
    key: UniqueKey(),
  )
];

List<NotificationWidget> notifications = [
  NotificationWidget(
      text: longDescription,
      date: DateTime.now().subtract(Duration(minutes: 5)),
      buttons: buttons),
  NotificationWidget(
      text: longDescription,
      date: DateTime.now().subtract(Duration(minutes: 70)),
      buttons: buttons),
  NotificationWidget(
    text: longDescription,
    date: DateTime.now().subtract(Duration(days: 5)),
  ),
  NotificationWidget(
      text: 'this is an example of a short description',
      date: DateTime.now().subtract(Duration(days: 17)),
      buttons: buttons),
  NotificationWidget(
    text: 'youssef announced message: l;kl l l;k   hejwhiun ',
    date: DateTime.now().subtract(Duration(days: 40)),
  ),
  NotificationWidget(
      text: 'go to sleep',
      date: DateTime.now().subtract(Duration(days: 366)),
      buttons: buttons),
];