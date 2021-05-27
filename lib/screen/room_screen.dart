import 'package:flutter/material.dart';

import 'package:project/constants.dart';
import 'package:project/model/models.dart';
import 'package:project/provider/UserData.dart';
import 'package:project/provider/data_constants.dart';
import 'package:project/provider/navbar.dart';
import 'package:project/provider/room_provider.dart';
import 'package:project/provider/team_provider.dart';
import 'package:project/screen/join_or_create_team.dart';
import 'package:project/screen/team_screen.dart';
import 'package:project/splash_screen/splash_screen.dart';
import 'package:project/widgets/project_card_widget.dart';
import 'package:provider/provider.dart';

import 'package:project/demoData.dart';
import 'package:project/widgets/home/dropDownMenu.dart';
import 'auth/auth_screen.dart';

class RoomScreen extends StatefulWidget {
  final List<List> teams;

  RoomScreen({this.teams = const []});

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  var names = ['Ahmed Mohamed', 'Mostafa Osama', 'Mohamed Hesham', 'Yousef Essam', 'Mahmoud Yousef', 'Beshoy Wagdy', 'Habiba Sayed'];

  bool switchProjects = false;

  /*TODO:
  - fix change room lag
  - fix scroll & refresh gesture lag
  - reload user rooms when refresh
  4865b5b1-88e8-4d7a-bc4a-f72dd4a4635a
  * */
  RoomProvider roomProvider;

  bool _isInit = false;

  @override
  Widget build(BuildContext context) {
    //initialize provider
    if (!_isInit) {
      roomProvider = Provider.of<RoomProvider>(context);
      _isInit = true;
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(KAppBarRound), bottomRight: Radius.circular(KAppBarRound)),
          child: AppBar(
            centerTitle: true,
            //TODO: change logout function
            //need drawer ?
            leading: IconButton(
              onPressed: () async {
                final user = Provider.of<UserData>(context, listen: false);
                await user.clearUserData();
                roomProvider.clear();
                Navigator.of((ModalRoute.of(context).settings.arguments))
                    .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SplashScreen()), (Route<dynamic> route) => false);
              },
              icon: Icon(Icons.logout),
              splashRadius: 20,
            ),
            title: InkWell(
                onTap: () {
                  changeRoom(context, MediaQuery.of(context).size.height, roomProvider.rooms);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("Room", style: TextStyle(color: Colors.white)), Icon(Icons.arrow_drop_down, color: Colors.grey[600])],
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
      body: roomProvider.roomId == null
          ? RefreshIndicator(
              onRefresh: () async {
                await handleRequest(() => roomProvider.getUserRooms(), context);
                if (roomProvider.rooms.isNotEmpty) {
                  roomProvider.changeRoom(roomProvider.rooms.first.id);
                }
              },
              child: Column(
                //brand new user
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Welcome \n\nlet\'s create your first room for your organization, company, work group freelance ...\nor join your team by invitation code',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CreateRoomScreen())),
                    autofocus: true,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Icon(Icons.read_more_outlined, color: Colors.white, size: 25),
                      decoration: BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                ],
              ),
            )
          : switchProjects
              ? projectWidget(names, context)
              : Teams(),
    );
  }
}

class Teams extends StatefulWidget {
  @override
  _TeamsState createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  bool _reload = false;

  bool _isInit = false;
  RoomProvider roomProvider;

  @override
  Widget build(BuildContext context) {
    if (!_isInit) {
      roomProvider = Provider.of<RoomProvider>(context);
      _isInit = true;
    }

    Widget teamCard(Team team) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
          focusColor: Colors.green.withOpacity(0.5),
          onTap: () {
            Provider.of<TeamProvider>(context, listen: false).changeTeam = team;
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

    return RefreshIndicator(
      onRefresh: () async {
        setState(() => _reload = true);
      },
      child: Column(
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
          FutureBuilder(
            future: roomProvider.getUserTeams(reload: _reload),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Expanded(child: Center(child: CircularProgressIndicator()));
              else if (snapshot.error != null) {
                print(snapshot.error);
                return Expanded(
                    child: Center(
                        child: Text(
                  'cannot reach the server !',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                )));
              }
              _reload = false;
              return Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: roomProvider.roomTeams.length,
                    itemBuilder: (context, i) {
                      return teamCard(roomProvider.roomTeams[i]);
                    }),
              );
            },
          )
        ],
      ),
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
