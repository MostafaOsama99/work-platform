import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/constants.dart';
import 'package:project/model/project.dart';

import '../screen/project_screen.dart';

class ProjectCard extends StatelessWidget {
  final teamNames;
  final String projectName, mangerName,description;
  final endDate,startDate;
  final List<Teams> teams;
  ProjectCard({this.teamNames, this.projectName, this.mangerName, this.endDate,this.startDate,this.description,this.teams});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: COLOR_BACKGROUND,
      clipBehavior: Clip.antiAlias,
      // instead of ClipRRect
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),

      child: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: InkWell(
          onTap: ()=> Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProjectScreen(
                    startDate: startDate,
                    endDate: endDate,
                    description: description,
                    attachments:"",
                    mangerName: mangerName,
                     projectName: projectName,
                    teams:teams,
                  ))),
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
                      SizedBox(
                         width: MediaQuery.of(context).size.width*0.4,
                        child: Chip(
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          label: Text(
                            projectName,softWrap: false,overflow: TextOverflow.fade,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),

                      Text(DateFormat('EEEE, d MMM, yyyy')
                          .format(endDate)
                          .toString(),style: TextStyle(color: Colors.white),),
                      Spacer(
                        flex: 2,
                      ),
                      Text(mangerName,style: TextStyle(color: Colors.white),),
                      Spacer(
                        flex: 4,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Column(
                  children: [
                    teamNames.length > 2
                        ? Column(
                      children: [
                        SizedBox(
                          width: 70,
                          height: 63,
                          child: ListView.builder(
                              scrollDirection:
                              Axis.vertical,
                              itemCount: 2,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 3),
                                  child: _userTileName(
                                      "${teamNames[i]}"),
                                );
                              }),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(bottom: 5),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 26,
                              width: 73,
                              margin: EdgeInsets.only(top: 0, left: 0, right: 0),
                              decoration: new BoxDecoration(
                                color: Colors.yellow,
                                border: Border.all(color: Colors.black, width: 0.0),
                                borderRadius: new BorderRadius.all(Radius.elliptical(90, 50)),
                              ),
                              child: Center(child: Text("+${teamNames.length - 2}")),
                            ),
                          ),
                        ),
                      ],
                    )
                        : SizedBox(
                      height: 50,
                      width: 68,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 2,
                          itemBuilder: (context, i) {
                            return _userTileName(
                                "${teamNames[i]}");
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
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
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Container(
      height: 26,
      width: 100,
      margin: EdgeInsets.only(top: 0, left: 0, right: 0,bottom: 0),
      decoration: new BoxDecoration(
        color: Colors.yellow,
        border: Border.all(color: Colors.black, width: 0.0),
        borderRadius: new BorderRadius.all(Radius.elliptical(90, 50)),
      ),
      child: Center(child: Text(name[0] + name[lastLitter])),
    ),
  );
}
