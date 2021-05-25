import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/provider/team_provider.dart';

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
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse)
      _animationController.reverse();
    else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) _animationController.forward();
  }

  Animation _animation;
  AnimationController _animationController;

  @override
  initState() {
    // _scrollController = ScrollController();
    // _scrollController.addListener(hideButton);
    //
    // _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200), reverseDuration: Duration(milliseconds: 175));
    // _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn, reverseCurve: Curves.easeOutCirc);
    // _animationController.value = 1;
    //
    //   _navBarProvider = Provider.of<NavBar>(context, listen: false);
    //   _navBarProvider.scrollController = _scrollController;
    Future.delayed(Duration.zero).then((value) {});
    super.initState();
  }

  @override
  void dispose() {
    // _scrollController.removeListener(hideButton);
    // _animationController.dispose();
    // _scrollController.dispose();
    super.dispose();
  }

  bool _reload = true;

  @override
  Widget build(BuildContext context) {
    final teamProvider = Provider.of<TeamProvider>(context, listen: false);

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
            title: Text(
              teamProvider.team.name,
              style: TextStyle(fontSize: 18),
            ),
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
      body: RefreshIndicator(
        onRefresh: () async => setState(() => _reload = true),
        child: FutureBuilder(
          future: teamProvider.getTasks(_reload),
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

            // _scrollController.addListener(hideButton);
            //
            // _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200), reverseDuration: Duration(milliseconds: 175));
            // _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn, reverseCurve: Curves.easeOutCirc);
            // _animationController.value = 1;

            // _navBarProvider = Provider.of<NavBar>(context, listen: false);
            // _navBarProvider.scrollController = _scrollController;

            _reload = false;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              controller: _scrollController,
              itemCount: teamProvider.tasks.length,
              itemBuilder: (_, i) => TaskCard(
                key: UniqueKey(),
                taskId: teamProvider.tasks[i].id,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => CreateTask(
                    teamMembers: usersLong,
                  )));
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
