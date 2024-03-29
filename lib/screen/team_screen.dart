import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/provider/UserData.dart';
import 'package:project/provider/team_provider.dart';
import 'package:project/widgets/NothingHere.dart';
import 'package:project/widgets/custom_tabView.dart';

import 'package:provider/provider.dart';

import '../demoData.dart';
import '../provider/navbar.dart';
import '../model/models.dart';
import '../widgets/task/task_card.dart' show TaskCard;
import '../constants.dart';
import 'create_task_screen.dart';
import 'team_settings.dart';

/// tabs titles for team screen that shows filters for Leader
/// Team: tasks assigned for team (not assigned to any member)
/// My Tasks: tasks assigned for the leader
/// Others: tasks assigned for members
const List<String> leaderTabs = [
  'All',
  'Team',
  'My Tasks',
  'Others',
  'Finished'
];

/// tabs titles for team screen that shows filters for Members
/// My Tasks: represents tasks created by the current member
const List<String> memberTabs = ['All', 'My Tasks', 'Finished'];

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

  List<List<Task>> filterTaskTabs;
  bool _reload;

  bool _isInit = false;
  bool _isLeader;
  bool _isLoading = false;
  TeamProvider teamProvider;
  UserData userProvider;

  @override
  Widget build(BuildContext context) {
    Future<void> _loadTasks() async {
      if (!_isLoading) {
        setState(() {
          _isLoading = true;
        });
        await teamProvider.getTeamTasks(_reload);
        setState(() {
          _isLoading = false;
          _reload = false;
        });
      }
    }

    if (!_isInit) {
      userProvider = Provider.of<UserData>(context, listen: false);
      teamProvider = Provider.of<TeamProvider>(context);
      _reload = teamProvider.tasks.isEmpty;
      _isLeader = teamProvider.isLeader(userProvider.userName);
      _isInit = true;
    }

    if (_reload || filterTaskTabs == null) {
      //   **** Leader ****
      if (_isLeader)
        filterTaskTabs = [
          teamProvider.tasks,
          teamProvider.tasks.where((task) => task.members.isEmpty).toList(),
          teamProvider.tasks
              .where((task) =>
                  task.members.contains(User(userName: userProvider.userName)))
              .toList(),
          teamProvider.tasks
              .where((task) =>
                  !task.members.contains(User(userName: userProvider.userName)))
              .toList(),
          teamProvider.tasks.where((task) => task.progress == 100).toList(),
        ];
      //   **** Member ****
      else
        filterTaskTabs = [
          teamProvider.tasks,
          teamProvider.tasks
              .where(
                  (task) => task.taskCreator.userName == userProvider.userName)
              .toList(),
          teamProvider.tasks.where((task) => task.progress == 100).toList(),
        ];
    }

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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TeamSettings()));
                },
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          CustomTabView(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(3), bottom: Radius.circular(12)),
                color: COLOR_ACCENT),
            tabs: [
              for (final tab in (_isLeader ? leaderTabs : memberTabs))
                Tab(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(3),
                            bottom: Radius.circular(12)),
                        border: Border.all(color: COLOR_ACCENT, width: 1)),
                    child: Text(tab),
                  ),
                ),
            ],
            listView: (tabIndex) {
              return RefreshIndicator(
                onRefresh: () async {
                  //if it's not loading, then reload
                  if (!_isLoading) {
                    _reload = true;
                    _loadTasks();
                    setState(() {});
                  }
                },
                child: Column(
                  children: [
                    FutureBuilder(
                        // future: _isLeader? teamProvider.getTeamTasks(_reload) : teamProvider.getUserTasks(_reload),
                        //future: _loadTasks(),
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (_isLoading)
                        return Expanded(
                            child: Center(child: CircularProgressIndicator()));
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

                      return Expanded(
                        child: filterTaskTabs[tabIndex].isNotEmpty
                            ? ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                controller: _scrollController,
                                itemCount: filterTaskTabs[tabIndex].length,
                                itemBuilder: (_, i) => TaskCard(
                                  key: UniqueKey(),
                                  taskId: filterTaskTabs[tabIndex][i].id,
                                ),
                              )
                            : Stack(children: [NothingHere(), ListView()]),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: _isLeader
          ? FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => CreateTask(
                teamMembers: usersLong,
              )));
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      )
          : null,
    );
  }
}
