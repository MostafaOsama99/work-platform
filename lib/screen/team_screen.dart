import 'package:flutter/material.dart';

import '../model/task.dart';
import '../widgets/task/task_card.dart';

import '../constants.dart';
import '../demoData.dart';
import 'edit_team_screen.dart';

class TeamScreen extends StatefulWidget {
  final teamName;
  final List<Task> tasks ;

  TeamScreen({this.teamName,this.tasks});

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {

  @override
  void initState() {

    print(widget.tasks);
    // TODO: implement initState
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(HEIGHT_APPBAR),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          child: AppBar(
            leading: IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            title: Text(widget.teamName),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                splashRadius: 21,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditTeamScreen()));
                },
              )
            ],
          ),
        ),
      ),
      body: ListView.builder(
          // scrollDirection: Axis.horizontal,
          itemCount: widget.tasks.length,
          itemBuilder: (context, i) => TaskCard(widget.tasks[i])),
    );
  }
}
