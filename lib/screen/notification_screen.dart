
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                Text("Notification", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.separated(

          itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 10),
            child: NotificationWidget(context),
          ),
          separatorBuilder: (__, _) => Divider(indent: 25, endIndent: 25),
        ),
      ),
    );
  }
}


