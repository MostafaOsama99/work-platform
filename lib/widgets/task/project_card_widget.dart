import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardWidget extends StatelessWidget {
  final teamNames;
  final String projectName, mangerName;
  final date;

  CardWidget({this.teamNames, this.projectName, this.mangerName, this.date});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: Colors.indigo[900],
      clipBehavior: Clip.antiAlias,
      // instead of ClipRRect
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),

      child: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Spacer(
                  flex: 1,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: _userIcon(projectName)),
                Spacer(
                  flex: 6,
                ),
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.yellow,
                  child: Text(
                    "Pr",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Spacer(
                  flex: 2,
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(
                      flex: 2,
                    ),
                    Text(
                      projectName,
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Text(DateFormat('EEEE, d MMM, yyyy')
                        .format(date)
                        .toString()),
                    Spacer(
                      flex: 2,
                    ),
                    Text(mangerName),
                    Spacer(
                      flex: 3,
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                teamNames.length > 2
                    ? Column(
                        children: [
                          SizedBox(
                            width: 50,
                            height: 60,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: 2,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 3),
                                    child: _userTileName("${teamNames[i]}"),
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: InkWell(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.grey,
                                child: Text(
                                  "+${teamNames.length - 2}",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 50,
                        width: 70,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: 2,
                            itemBuilder: (context, i) {
                              return _userTileName("${teamNames[i]}");
                            }),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _userIcon(String name) {
  var lastLitter = name.indexOf(' ') + 1;
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(3) //                 <--- border radius here
                  ),
              color: Color.fromRGBO(13, 56, 120, 1),
              border: Border.all(color: Colors.grey)),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              name[0] + name[lastLitter],
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _userTileName(String name) {
  var lastLitter = name.indexOf(' ') + 1;
  return CircleAvatar(
    radius: 14,
    child: Text(name[0] + name[lastLitter], style: TextStyle(fontSize: 12)),
    backgroundColor: Colors.yellow,
  );
}
