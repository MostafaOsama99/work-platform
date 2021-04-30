import 'package:flutter/material.dart';
import 'package:project/constants.dart';
import 'package:project/model/room.dart';
import 'package:project/provider/room_provider.dart';
import 'package:project/screen/join_or_create_team.dart';
import 'package:provider/provider.dart';

changeRoom(context, height, List<Room> rooms) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    transitionDuration: Duration(milliseconds: 450),
    barrierLabel: MaterialLocalizations.of(context).dialogLabel,
    barrierColor: Colors.black.withOpacity(0.4),
    pageBuilder: (context, _, __) {
      return Column(
        //so important to use column !!
        children: [
          Padding(
            //width
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            //so important to use Card !!
            child: Card(
              color: Theme.of(context).backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),
              child: Theme(
                data: Theme.of(context),
                child: LimitedBox(
                  maxHeight: height * 0.35,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25)),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      shrinkWrap: true,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...rooms
                            .map((room) => _roomTile(
                                roomName: room.name,
                                //TODO: change room id to room creator
                                creator: room.id.toString(),
                                onPressed: () {
                                  Provider.of<RoomProvider>(context,
                                          listen: false)
                                      .changeRoom(room.id);
                                  Navigator.of(context).pop();
                                }))
                            .toList(),
                        SizedBox(
                          height: 40,
                          child: TextButton(
                            onPressed: () => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CreateRoomScreen())),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'create room - Join team',
                                  style: TextStyle(color: Colors.white),
                                ),
                                //
                                Icon(Icons.add_circle, color: Colors.blue),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        ).drive(Tween<Offset>(
          begin: Offset(0, -1),
          end: Offset(0, (KAppBarHeight * 1.4) / height),
        )),
        child: child,
      );
    },
  );
}

Widget _roomTile(
    {@required roomName, @required creator, @required VoidCallback onPressed}) {
  return ClipRRect(
    //  borderRadius: BorderRadius.circular(15),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: TextButton(
              onPressed: onPressed,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(roomName, style: TextStyle(color: Colors.white)),
                  Spacer(),
                  Text(creator)
                ],
              ),
            ),
          ),
          Divider(thickness: 1, indent: 16, endIndent: 16),
        ],
      ),
    ),
  );
}
