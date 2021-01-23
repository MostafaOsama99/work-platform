import 'package:flutter/material.dart';

import '../model/task.dart';
import '../widgets/task/task_card.dart';

import '../constants.dart';
import '../demoData.dart';
import 'edit_team_screen.dart';

class TeamScreen extends StatelessWidget {
  final teamName;
  final List<Task> tasks = demoTasks;

  TeamScreen(this.teamName);

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
            title: Text(teamName),
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
          itemCount: tasks.length,
          itemBuilder: (context, i) => TaskCard(tasks[i])),
    );
  }
}
