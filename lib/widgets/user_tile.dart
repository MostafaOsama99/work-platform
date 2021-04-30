  import 'package:flutter/material.dart';
import 'package:project/model/models.dart';

import '../constants.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile(this.user,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ///split name words ex: 'first second third' => ['first', 'second', 'third'] to  get first name & last name
    var name = user.name.split(' ');

    //TODO: add border if the tile for the current user- take the border color from outside the class (task Accent Color)

    return GestureDetector(
      onLongPress: () {
        //TODO: show popup menu
        //https://stackoverflow.com/questions/54300081/flutter-popupmenu-on-long-press
        //or use 3 dot drop down menu
        //https://stackoverflow.com/questions/58144948/easiest-way-to-add-3-dot-pop-up-menu-appbar-in-flutter
      },
      child: Container(
        height: 52,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.only(left: 6, right: 14,top: 2, bottom: 2),
        decoration: BoxDecoration(
          color: COLOR_BACKGROUND,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 22,
              child: Text(name[0][0] +  name[1][0], style: TextStyle(fontSize: 16)),
              backgroundColor: COLOR_ACCENT,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name[0] + ' ' + name[1], style: TextStyle(fontSize: 15)),
                     Row(
                       mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(' ${user.userName}', style: TextStyle(fontSize: 12.5, color: Colors.grey)),
                        Spacer(),
                        Text(user.jobTitle, style: TextStyle(fontSize: 13.5)),
                      ],
                      )],
                ),
              ),
            ),
            //SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
