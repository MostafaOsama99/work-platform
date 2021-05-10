import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:provider/provider.dart';

import '../demoData.dart';
import '../provider/navbar.dart';
import '../model/models.dart';
import '../widgets/task/task_card.dart' show TaskCard;
import '../constants.dart';
import 'create_task_screen.dart';
import 'edit_team_screen.dart';

class TeamScreen extends StatefulWidget {
  final teamName;
  final List<Task> tasks;

  TeamScreen({this.teamName, this.tasks});

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> with TickerProviderStateMixin {
  ScrollController _scrollController;
  NavBar _navBarProvider;

  hideButton() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse)
      _animationController.reverse();
    else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) _animationController.forward();
  }

  Animation _animation;
  AnimationController _animationController;

  @override
  initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(hideButton);

    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
        reverseDuration: Duration(milliseconds: 175));
    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOutCirc);
    _animationController.value = 1;

    Future.delayed(Duration.zero).then((value) {
      _navBarProvider = Provider.of<NavBar>(context, listen: false);
      _navBarProvider.scrollController = _scrollController;
    });
    super.initState();
  }

  @override
  void dispose() {
    // Future.delayed(Duration.zero)
    //     .then(
    //         (value) => Provider.of<NavBar>(context, listen: false).showNavBar())
    //     .then((value) {
    //   //_navBarProvider.removeController();
    // });
    _scrollController.removeListener(hideButton);
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KAppBarHeight),
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
          controller: _scrollController,
          // scrollDirection: Axis.horizontal,
          itemCount: widget.tasks.length,
          itemBuilder: (context, i) => TaskCard(widget.tasks[i])),
      floatingActionButton: ScaleTransition(
        scale: _animation,
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
