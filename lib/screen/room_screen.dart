import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/constants.dart';
import 'package:project/widgets/project_card_widget.dart';
import '../widgets/custom_expansion_title.dart' as custom;
import 'package:project/screen/project_screen.dart';
import 'join_or_create_team.dart';
import 'package:project/demoData.dart';
import 'package:project/widgets/home/dropDownMenu.dart';

class RoomScreen extends StatefulWidget {
  final List<List> teams;

  RoomScreen({this.teams = const []});

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  var names = [
    'Ahmed Mohamed',
    'Mostafa Osama',
    'Mohamed Hesham',
    'Yousef Essam',
    'Mahmoud Yousef',
    'Beshoy Wagdy',
    'Habiba Sayed'
  ];

  bool switchProjects = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: ClipRRect(
          borderRadius:
              BorderRadius.only(bottomLeft: Radius.circular(KAppBarRound), bottomRight: Radius.circular(KAppBarRound)),
          child: AppBar(
            centerTitle: true,
            title: InkWell(
                onTap: () {
                  changeTeam(context, MediaQuery.of(context).size.height, widget.teams);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Room", style: TextStyle(color: Colors.white)),
                    Icon(Icons.arrow_drop_down, color: Colors.grey[600])
                  ],
                )),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: IconButton(
                  splashRadius: 20,
                  iconSize: 19,
                  icon: Image.asset(
                    switchProjects ? 'assets/icons/projects.png' : 'assets/icons/team-2.png',
                    color: Colors.white,
                  ),
                  onPressed: () => setState(() => switchProjects = !switchProjects),
                ),
              )
            ],
          ),
        ),
      ),
      body: switchProjects ? projectWidget(names, context) : roomWidget(context),
    );
  }
}

Widget roomWidget(context) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(top: 16, left: 16),
        child: Row(
          children: [
            Text(
              "Teams",
              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: myTeams.length,
            itemBuilder: (context, i) {
              return teamCard(context, myTeams[i].teamName, myTeams[i].tasks);
            }),
      )
    ],
  );
}

Widget projectWidget(names, context) {
  return ListView(
    children: [
      Padding(
        padding: EdgeInsets.only(top: 16, left: 16),
        child: Text(
          "Projects",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: LimitedBox(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: 200,
            child: ListView.builder(
                itemCount: project.length,
                itemBuilder: (context, i) {
                  return SizedBox(
                    height: 130,
                    width: 200,
                    child: ProjectCard(
                      endDate: project[i].endDate,
                      projectName: project[i].projectName,
                      mangerName: project[i].mangerName,
                      // teamNames: project[i].teams[i].teamName,
                      startDate: project[i].startDate,
                      description: project[i].description,
                      teams: project[i].teams,
                    ),
                  );
                })),
      )
    ],
  );
}
