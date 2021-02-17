import 'package:flutter/material.dart';
import 'package:project/constants.dart';
import 'package:project/screen/join_or_create_team.dart';

changeTeam(context, height, teams) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    transitionDuration: Duration(milliseconds: 500),
    barrierLabel: MaterialLocalizations.of(context).dialogLabel,
    barrierColor: Colors.black.withOpacity(0.4),
    pageBuilder: (context, _, __) {
      return Column(
        //so important to use column !!
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
                    child: ListView(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      shrinkWrap: true,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...teams
                            .map((e) => _teamTile(
                                // teamName: e[0],
                                roomName: e[0],
                                leaderName: e[1]))
                            .toList(),
                        SizedBox(
                          height: 40,
                          child: FlatButton(
                            onPressed: () => Navigator.of(context)
                                .push(MaterialPageRoute(builder: (BuildContext context) => CreateRoomScreen())),
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
          curve: Curves.easeOut,
        ).drive(Tween<Offset>(
          begin: Offset(0, -1),
          end: Offset(0, (KAppBarHeight * 1.4) / height),
        )),
        child: child,
      );
    },
  );
}

Widget _teamTile({@required roomName, @required leaderName}) {
  return ClipRRect(
    //  borderRadius: BorderRadius.circular(15),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: FlatButton(
              onPressed: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(roomName,
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          '-----',
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Text(
                    leaderName,
                  )
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
        ],
      ),
    ),
  );
}
