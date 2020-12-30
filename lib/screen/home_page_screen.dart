import 'package:flutter/material.dart';
import 'package:project/screen/edit_team_screen.dart';
import '../widgets/task/task_card.dart';

import '../model/task.dart';
import '../constants.dart';

const COLOR_BACKGROUND = Color.fromRGBO(37, 36, 42, 1);

class HomePage extends StatefulWidget {
  static const HEIGHT_ANNOUNCE = 75.0;

  final List<List> teams ;
  const HomePage({this.teams = const []}) ;

  @override
  _HomePageState createState() => _HomePageState();

  static const textStyle = TextStyle(color: Colors.white);
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;

    //TODO: subtract bottomNavigationBar height
    final bodyHeight = height -
        MediaQuery.of(context).padding.top -
        HEIGHT_APPBAR;

    return Scaffold(
      // backgroundColor: COLOR_BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(HEIGHT_APPBAR),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            splashRadius: 24,
            iconSize: 20,
            icon: CircleAvatar(
              // backgroundColor: Colors.amber,
              child: Text(
                'UN',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.arrow_drop_down,
                  // color: Colors.amber,
                ),
                splashRadius: 20,
                onPressed: () {
                  _changeTeam(context, height);
                })
          ],
          title:
          OutlineButton(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            highlightedBorderColor: Colors.teal.shade300,
           // highlightColor: Colors.white,
            color: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(width: 2)),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => EditTeamScreen()));
            },
            child: Text(
              'Team Name',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: bodyHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 75,
              color: Colors.white30,
              child: Center(
                  child: Text(
                    'Announcements ...',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
            Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22, top: 16, bottom: 8),
                      child: Text(
                        'Tasks',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 300,

                      //TODO: make list dynamic
                      child: Tasks([
                        Task(
                            progress: 70,
                            description: 'description',
                            name: 'Task name',
                            deadline: DateTime.now()),
                        Task(
                            progress: 30,
                            description: 'description',
                            name: 'Task name',
                            deadline: DateTime.now())
                      ]),
                    ),
                  ],
                )),
            Flexible(child: Container()),
          ],
        ),
      ),
    );
  }

  _changeTeam(context, height) {
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
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25)),
                      child: ListView(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        shrinkWrap: true,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...widget.teams
                              .map((e) => _teamTile(
                                  teamName: e[0], roomName: e[1], leaderName: e[2]))
                              .toList(),
                          SizedBox(
                            height: 40,
                            child: FlatButton(
                              onPressed: () {  },
                              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                     Text(
                                      'Join or create team',
                                      style: HomePage.textStyle,
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
            end: Offset(0,(HEIGHT_APPBAR *1.4) / height ),
          )),
          child: child,
        );
      },
    );
  }



  ///built for each team in the list 
  Widget _teamTile(
      {@required String teamName, @required roomName, @required leaderName}) {
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
                        Text(teamName,
                            style:
                                TextStyle(color: Colors.white, )),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            roomName,
                            style:
                                TextStyle(color: Colors.white70),
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Text(leaderName, style: HomePage.textStyle)
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
}

class Tasks extends StatelessWidget {
  final List<Task> tasks;

  const Tasks(this.tasks);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // scrollDirection: Axis.horizontal,
        itemCount: tasks.length,
        itemBuilder: (context, i) => TaskCard(tasks[i]));
  }
}





_changeTeamModal(BuildContext context, List<List> teams) {
  return showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      backgroundColor: Color.fromRGBO(8, 77, 99, 1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                title: Text(
                  'Join or create team',
                  style: HomePage.textStyle,
                ),
                trailing: Icon(Icons.add_circle, color: Colors.blue),
              ),
              // ListView.builder(
              //     itemCount: teams.length,
              //     itemBuilder: (context, i) => _teamTile(
              //         teamName: teams[i][0],
              //         roomName: teams[i][1],
              //         leaderName: teams[i][2])),
            ],
          ),
        );
      });
}