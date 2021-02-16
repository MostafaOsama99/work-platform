import 'package:flutter/material.dart';
import 'package:project/demoData.dart';
import 'package:project/screen/edit_team_screen.dart';
import 'package:project/screen/join_or_create_team.dart';
import '../widgets/task/task_card.dart';
import '../widgets/home/dropDownMenu.dart';
import '../model/task.dart';
import '../constants.dart';

//testt
//test

const COLOR_BACKGROUND = Color.fromRGBO(37, 36, 42, 1);

class HomePage extends StatefulWidget {
  static const HEIGHT_ANNOUNCE = 75.0;

  final List<List> teams;

  const HomePage({this.teams = const []});

  @override
  _HomePageState createState() => _HomePageState();

  static const textStyle = TextStyle(color: Colors.white);
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    //TODO: subtract bottomNavigationBar height
    final bodyHeight = height - MediaQuery.of(context).padding.top - KAppBarHeight;

    return Scaffold(
      // backgroundColor: COLOR_BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KAppBarHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(20)),
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
                    changeTeam(context,MediaQuery.of(context).size.height,widget.teams);
                  })
            ],
            title: OutlineButton(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              highlightedBorderColor: Colors.teal.shade300,
              // highlightColor: Colors.white,
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 2)),
              onPressed: () {
                //TODO: push replacement not working to remove the current dialog tap
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditTeamScreen()));
              },
              child: Text(
                'Team Name',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: bodyHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Container(
            //   height: 75,
            //   color: Colors.white30,
            //   child: Center(
            //       child: Text(
            //     'Announcements ...',
            //     style: TextStyle(color: Colors.white, fontSize: 20),
            //   )),
            // ),
            Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 22, top: 16, bottom: 8),
                      child: Text(
                        'Tasks',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 450,

                      //TODO: make list dynamic
                      child: Tasks(demoTasks),
                    ),
                  ],
                )),
           // Flexible(child: Container()),
          ],
        ),
      ),
    );
  }



  ///built for each team in the list

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

