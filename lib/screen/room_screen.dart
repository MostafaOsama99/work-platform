import 'package:flutter/material.dart';

import 'package:project/constants.dart';
import 'package:project/model/models.dart';
import 'package:project/provider/navbar.dart';
import 'package:project/provider/room_provider.dart';
import 'package:project/provider/team_provider.dart';
import 'package:project/screen/team_screen.dart';
import 'package:project/splash_screen/splash_screen.dart';
import 'package:project/widgets/project_card_widget.dart';
import 'package:provider/provider.dart';

import 'package:project/demoData.dart';
import 'package:project/widgets/home/dropDownMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/auth_screen.dart';

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

  /*TODO:
  - fix change room lag
  - fix scroll & refresh gesture lag
  - reload user rooms when refresh
  * */

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(KAppBarRound),
              bottomRight: Radius.circular(KAppBarRound)),
          child: AppBar(
            centerTitle: true,
            title: InkWell(
                onTap: () {
                  changeRoom(context, MediaQuery.of(context).size.height, roomProvider.rooms);
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
                    switchProjects
                        ? 'assets/icons/projects.png'
                        : 'assets/icons/team-2.png',
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      setState(() => switchProjects = !switchProjects),
                ),
              )
            ],
          ),
        ),
      ),
      body: switchProjects ? projectWidget(names, context) : Teams(),
    );
  }
}

class Teams extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context);
    final teamProvider = Provider.of<TeamProvider>(context);

    Widget teamCard(Team team) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
          focusColor: Colors.green.withOpacity(0.5),
          onTap: () {
            teamProvider.changeTeam = team;
            //teamProvider.createTask();
            //teamProvider.fetchMembers();
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => TeamScreen())).then((value) {
              // Provider.of<NavBar>(context, listen: false).showNavBar();
              // Provider.of<NavBar>(context, listen: false).removeController();
            });
          },
          tileColor: Colors.blue.shade800.withOpacity(0.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: COLOR_ACCENT)),
          title: Text(
            team.name,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          subtitle: Text(
            team.description,
            style: TextStyle(color: Colors.white, fontSize: 15),
            maxLines: 3,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(Icons.double_arrow_rounded),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16, left: 16),
          child: Row(
            children: [
              Text(
                "Teams",
                style: TextStyle(fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        InkWell(
          onTap: ()async{
            SharedPreferences preferences = await SharedPreferences.getInstance();
            preferences.clear();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SplashScreen()));
          },
          child: Text("Sign Out"),

        ),
        RefreshIndicator(
          onRefresh: () => roomProvider.getUserTeams(reload: true),
          child: FutureBuilder(
            future: roomProvider.getUserTeams(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Expanded(
                    child: Center(child: CircularProgressIndicator()));
              else if (snapshot.error != null)
                return Expanded(
                    child: Center(
                        child: Text(
                  'cannot reach the server !',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                )));

              return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: roomProvider.roomTeams.length,
                  itemBuilder: (context, i) {
                    return teamCard(roomProvider.roomTeams[i]);
                  });
            },
          ),
        )
      ],
    );
  }
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
