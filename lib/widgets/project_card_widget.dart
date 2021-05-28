import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/constants.dart';
import 'package:project/model/project.dart';

import '../screen/project_screen.dart';

class ProjectCard extends StatelessWidget {
  // final List<String> teamNames;
  final String projectName, mangerName, description;
  final endDate, startDate;
  final List<Teams> teams;

  ProjectCard({this.projectName, this.mangerName, this.endDate, this.startDate, this.description, this.teams});

  @override
  Widget build(BuildContext context) {
    List<Widget> teamsList;
    if (teams.length > 2) {
      teamsList = List.generate(2, (index) => _userTileName(teams[index].teamName));
      teamsList.add(_userTileName('${teams.length - 2}'));
    } else
      teamsList = List.generate(teams.length, (index) => _userTileName(teams[index].teamName));

    return Card(
        color: COLOR_BACKGROUND,
        clipBehavior: Clip.antiAlias,
        // instead of ClipRRect
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
        child: InkWell(
          splashColor: Colors.white12,
          highlightColor: COLOR_ACCENT.withOpacity(0.4),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProjectScreen(
                        startDate: startDate,
                        endDate: endDate,
                        description: description,
                        attachments: "",
                        mangerName: mangerName,
                        projectName: projectName,
                        teams: teams,
                      ))),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(
                children: [
                  //Spacer(flex: 1),
                  _userIcon(projectName),
                  Spacer(flex: 6),
                  _buildUserAvatar(mangerName),
                  //Spacer(flex: 2)
                ],
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 4, left: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          projectName,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      Text(
                        DateFormat('EEEE, d MMM, yyyy').format(endDate).toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        mangerName,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(flex: 3,child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: teamsList)),
            ]),
          ),
        ));
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
              borderRadius: BorderRadius.all(Radius.circular(3) //                 <--- border radius here
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
  return Container(
    //height: 25,
    margin: const EdgeInsets.symmetric(vertical: 2),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
        color: COLOR_SCAFFOLD,
        // boxShadow: [BoxShadow(offset: Offset(0,1))],
        borderRadius: BorderRadius.circular(60)),
    child: Text(
      name,
      softWrap: false,
      overflow: TextOverflow.fade,
      style: TextStyle(fontSize: 13),
    ),
  );
}

Padding _buildUserAvatar(String name) {
  var lastLitter = name.indexOf(' ') + 1;
  return Padding(
    padding: const EdgeInsets.only(right: 4),
    child: CircleAvatar(
      radius: 12.5,
      backgroundColor: Colors.black,
      child: Text(
        name[0] + name[lastLitter],
        style: TextStyle(fontSize: 12, color: Colors.white),
      ),
    ),
  );
}
