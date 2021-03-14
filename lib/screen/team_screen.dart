import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/demoData.dart';
import 'create_task_screen.dart';

import '../model/task.dart';
import '../widgets/task/task_card.dart' show TaskCard;

import '../constants.dart';
import 'edit_team_screen.dart';

class TeamScreen extends StatefulWidget {
  final teamName;
  final List<Task> tasks;

  TeamScreen({this.teamName, this.tasks});

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  ScrollController _scrollController;
  var _isVisible;

  hideButton() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (_isVisible == true) {
        // only set when the previous state is false, Less widget rebuilds
        setState(() => _isVisible = false);
      }
    } else {
      if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (_isVisible == false) {
          // only set when the previous state is false, Less widget rebuilds
          setState(() => _isVisible = true);
        }
      }
    }
  }

  @override
  initState() {
    _isVisible = true;
    _scrollController = ScrollController();
    _scrollController.addListener(hideButton);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(hideButton);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KAppBarHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditTeamScreen()));
                },
              )
            ],
          ),
        ),
      ),
      body: ListView.builder(
          controller: _scrollController,
          // scrollDirection: Axis.horizontal,
          itemCount: widget.tasks.length,
          itemBuilder: (context, i) => TaskCard(widget.tasks[i])),
      floatingActionButton: Visibility(
        visible: _isVisible,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => CreateTask(
                      teamMembers: usersLong,
                    )));
          },
          tooltip: 'Add Task',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
