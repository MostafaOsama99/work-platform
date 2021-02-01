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
        padding: EdgeInsets.only(top: 3, left: 10, right: 10),
        child: GestureDetector(

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
                  _buildUserAvatar(mangerName),
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
                        flex: 8,
                      ),
                      SizedBox(
                         width: MediaQuery.of(context).size.width*0.4,
                        child:
                          Text(
                            projectName,softWrap: false,overflow: TextOverflow.fade,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),

                      ),
                      Spacer(flex: 7,),
                      Text(DateFormat('EEEE, d MMM, yyyy')
                          .format(endDate)
                          .toString(),style: TextStyle(color: Colors.white),),
                      Spacer(
                        flex: 5,
                      ),
                      Text(mangerName,style: TextStyle(color: Colors.white),),
                      Spacer(
                        flex: 8,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Column(
                  children: [
                    teamNames.length > 2
                        ? Column(
                      children: [
                        SizedBox(
                          width: 90,
                          height: 65,
                          child: ListView.builder(
                              scrollDirection:
                              Axis.vertical,
                              itemCount: 2,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 3),
                                  child: _userTileName(
                                      "teamNames"),
                                );
                              }),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(top:7),
                          child: InkWell(
                            onTap: () {}, child: SizedBox(
                                   height: 26,
                              width: 90,
                              child: Chip(padding: EdgeInsets.all(0),
                                backgroundColor: COLOR_SCAFFOLD,
                                label: Center(child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text("       +${teamNames.length - 2}              "),
                                )),
                              ),)
                          ),
                        ),
                      ],
                    )

      //   Container(
      //   height: 25,
      //   width: 90,
      //   margin: EdgeInsets.only(top: 0, left: 0, right: 0),
      //   decoration: new BoxDecoration(
      //     color: COLOR_SCAFFOLD,
      //     border: Border.all(color: Colors.black, width: 0.0),
      //     borderRadius: new BorderRadius.all(Radius.elliptical(90, 50)),
      //   ),
      //   child: Center(child: Text("+${teamNames.length - 2}")),
      // ),
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
  return SizedBox(
    height: 33,
    child: Chip(
      backgroundColor: COLOR_SCAFFOLD,
      label: Text(name),
    ),
  );
}
Padding _buildUserAvatar(String name) {
  var lastLitter = name.indexOf(' ') + 1;
  return Padding(
    padding: const EdgeInsets.only(right: 4),
    child: CircleAvatar(
      radius: 15,
      backgroundColor: Colors.red[400],
      child: Text(
        name[0] + name[lastLitter],
        style: TextStyle(
          fontSize: 12,color: Colors.white
        ),
      ),
    ),
  );
}