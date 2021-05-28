import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project/provider/data_constants.dart';
import 'package:project/provider/room_provider.dart';
import 'package:project/provider/team_provider.dart';
import 'package:provider/provider.dart';

import '../../model/models.dart';
import '../../model/taskType.dart';
import '../../constants.dart';
import '../../dialogs/end_task_dialog.dart';
import '../../dialogs/custom_alert_dialog.dart';

import 'package:step_progress_indicator/step_progress_indicator.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> with TickerProviderStateMixin {
  Task _activeTask;
  int _teamId;

  bool _isLoading = false;

  ///to control the timer
  GlobalKey<CounterState> _timerKey = GlobalKey();

  TeamProvider teamProvider;
  RoomProvider roomProvider;

  bool _isInit = false;
  bool _loadTasks = true;
  bool _isLoadingTasks = true;

  ///[isWorking] is if you hit play task or stop task
  toggleTaskTime({bool isWorking, Task task, int teamId}) async {
    if (isWorking) {
      if (_activeTask != null) {
        //if you press play task and there's a working task already
        bool response = await showDialog(
            context: context,
            builder: (_) => CustomAlertDialog(
                  title: 'End current session!',
                  text: 'Are you sure you want to end ${_activeTask.name} ?',
                ));
        if (response == null)
          return;
        else
          await toggleTaskTime(isWorking: false);
      }
      //start a new session
      setState(() => _isLoading = true);
      await roomProvider.openSession(Session(task: task, roomId: roomProvider.roomId, sessionId: null, startTime: DateTime.now()));
      setState(() {
        _isLoading = false;
        _teamId = teamId;
        _activeTask = task;
      });
      _timerKey.currentState.startTimer();
    }

    ///stop current session
    else {
      setState(() => _isLoading = true);
      //TODO: add extra duration here
      setState(() {
        _isLoading = false;
        _teamId = null;
        _activeTask = null;
      });
      await _timerKey.currentState.stopTimer();
      await showDialog(context: context, barrierDismissible: false, builder: (_) => EndTaskDialog());
      await updateTask();
    }
  }

  Future<void> initializeCounter() async {
    await handleRequest(() => roomProvider.getPreviousSessions(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day), DateTime.now()), context);
    //await handleRequest(roomProvider.currentSession, context);
    DateTime startTime = roomProvider.session?.startTime;
    if (startTime != null) {
      //if there's an opened one, get it's task
      setState(() {
        _activeTask = roomProvider.session.task;
        _teamId = roomProvider.session.teamId;
      });
      _timerKey.currentState.startTimer(startTime);
      _timerKey.currentState._updateDuration();
    }
  }

  updateTask() async {
    await roomProvider.updateSessionTask(roomProvider.session.task);
    await roomProvider.closeSession();
    setState(() => _loadTasks = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInit) {
      teamProvider = Provider.of<TeamProvider>(context, listen: false);
      roomProvider = Provider.of<RoomProvider>(context, listen: false);
      _isLoading = true;
      initializeCounter().then((value) {
        setState(() => _isLoading = false);
      });
      _isInit = true;
    }
//_isLoading = false;
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 8, top: MediaQuery.of(context).padding.top + 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(60), bottomRight: Radius.circular(60), topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
              color: Color.fromRGBO(24, 29, 35, 1), //COLOR_ACCENT.withOpacity(0.8),
            ),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: COLOR_SCAFFOLD,
                          ),
                          child: Text('Daily Progress', softWrap: false, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19))),
                      if (_activeTask != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 28,
                              width: 28,
                              child: RaisedButton(
                                  padding: EdgeInsets.zero,
                                  child: Icon(Icons.pause, color: Colors.white),
                                  splashColor: Colors.deepOrange,
                                  textColor: Colors.deepOrange,
                                  color: Colors.deepOrange[800],
                                  highlightElevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(color: Colors.deepOrange[800].withOpacity(0.5)),
                                  ),
                                  onPressed: () => toggleTaskTime(isWorking: false)),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                                child: Text(
                              _activeTask.name,
                              style: const TextStyle(fontSize: 16),
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            )),
                          ],
                        ),
                    ],
                  ),
                ),

                ///*** counter clock ///***
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Counter(_timerKey, _isLoading),
                ),
                // SizedBox(height: 8),
              ],
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: roomProvider.roomTeams.length,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                      ),
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [COLOR_SCAFFOLD, Colors.transparent, Colors.transparent, Colors.blue],
                            stops: [0.0, 0.03, 0.97, 1.0],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.dstOut,
                        child: SizedBox(
                          height: 38,
                          child: TabBar(
                            isScrollable: true,
                            labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                            indicator: BoxDecoration(borderRadius: BorderRadius.circular(50), color: COLOR_ACCENT),
                            indicatorSize: TabBarIndicatorSize.label,
                            tabs: [
                              for (final team in roomProvider.roomTeams)
                                Tab(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), border: Border.all(color: COLOR_ACCENT, width: 1)),
                                    child: Text(team.name),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        for (final Team tm in roomProvider.roomTeams)
                          ChangeNotifierProvider.value(
                            value: TeamProvider(tm),
                            child: Consumer<TeamProvider>(
                              builder: (BuildContext context, _team, Widget child) {
                                //setState(() => _isLoadingTasks = true);
                                if (_loadTasks)
                                  _team.getTasks(_loadTasks).then((value) => setState(() {
                                        print('loading tasks');
                                        _isLoadingTasks = false;
                                        _loadTasks = false;
                                      }));
                                return _isLoadingTasks
                                    ? Center(child: SizedBox(height: 20, child: CircularProgressIndicator()))
                                    : ShaderMask(
                                        shaderCallback: (Rect bounds) {
                                          return LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [COLOR_SCAFFOLD, Colors.transparent, Colors.transparent, Colors.blue],
                                            stops: [0.0, 0.04, 0.96, 1.0],
                                          ).createShader(bounds);
                                        },
                                        blendMode: BlendMode.dstOut,
                                        child: _team.tasks.isNotEmpty
                                            ? ListView.builder(
                                                padding: const EdgeInsets.only(left: 4, right: 4, top: 2),
                                                key: UniqueKey(),
                                                itemCount: _team.tasks.length,
                                                itemBuilder: (_, index) => WorkTile(
                                                      key: UniqueKey(),
                                                      task: _team.tasks[index],
                                                      isWorking: _activeTask == null ? false : (_activeTask.id == _team.tasks[index].id && _teamId == _team.team.id),
                                                      onPressed: (bool value, Task task) {
                                                        toggleTaskTime(isWorking: value, task: task, teamId: _team.team.id);
                                                      },
                                                    ))
                                            : Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/icons/task_empty.png',
                                                    color: COLOR_BACKGROUND,
                                                  ),
                                                  Text(
                                                    'No tasks here !',
                                                    style: const TextStyle(color: Colors.white30, fontSize: 16),
                                                  )
                                                ],
                                              ),
                                      );
                              },
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkTile extends StatelessWidget {
  final Task task;
  final bool isWorking;
  final Function(bool value, Task task) onPressed;

  const WorkTile({Key key, @required this.task, this.isWorking = false, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isExceed = task.datePlannedEnd.isBefore(DateTime.now());

    int _spent;
    if (_isExceed) {
      _spent = 100;
    } else
      _spent = (task.datePlannedStart.difference(DateTime.now()).inDays / task.datePlannedStart.difference(task.datePlannedEnd).inDays * 100).toInt();

    LinearGradient _timeGradient;

    print('spent: $_spent');

    if (_spent <= task.progress)
      _timeGradient = LinearGradient(colors: [COLOR_ACCENT, Colors.blueAccent], stops: [0.2, 0.8]);
    else if (_spent > task.progress && _spent <= task.progress * 1.5 && _spent <= 90) // 50-75%
      _timeGradient = LinearGradient(colors: [COLOR_ACCENT, Colors.amberAccent], stops: [0.2, 0.8]);
    else
      _timeGradient = LinearGradient(colors: [Colors.redAccent, Colors.redAccent.shade700], stops: [0.2, 0.8]);

    return InkWell(
      //onTap: => Navigator.of(context).push(MaterialPageRoute(builder: (_)=> )),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: COLOR_BACKGROUND,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).scaffoldBackgroundColor, //Colors.black38, //COLOR_BACKGROUND,
                        ),
                        child: Image.asset(taskTypes[task.type].icon, color: taskTypes[task.type].accentColor),
                      ),
                      SizedBox(width: 10),
                      Text(task.name, style: const TextStyle(fontSize: 16)),
                      Spacer(),
                      if (_isExceed)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Image.asset('assets/icons/warning.png', height: 25, color: Colors.red),
                        ),
                      SizedBox(
                        height: 35,
                        width: 35,
                        child: RaisedButton(
                            padding: EdgeInsets.zero,
                            child: isWorking ? Icon(Icons.pause, color: Colors.white) : Icon(Icons.play_arrow_sharp, color: Colors.white70),
                            splashColor: Colors.deepOrange,
                            textColor: Colors.deepOrange,
                            color: isWorking ? Colors.deepOrange[800] : COLOR_BACKGROUND,
                            highlightElevation: 2,
                            //autofocus: false,
                            //clipBehavior: Clip.antiAlias,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.deepOrange[800].withOpacity(0.5)),
                            ),
                            onPressed: () => onPressed(!isWorking, task)),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Image.asset('assets/icons/sandClock-2.png', height: 18, color: Colors.white70),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: StepProgressIndicator(
                            totalSteps: 100,
                            currentStep: _spent,
                            size: 12,
                            roundedEdges: const Radius.circular(30),
                            unselectedColor: Colors.black38,
                            selectedColor: Colors.white,
                            gradientColor: _timeGradient,
                            padding: 0,
                          ),
                        ),
                      ),
                      SizedBox(width: 40),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Image.asset('assets/icons/percent.png', height: 18, color: Colors.white70),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: StepProgressIndicator(
                            totalSteps: 100,
                            currentStep: task.progress,
                            size: 12,
                            roundedEdges: const Radius.circular(30),
                            selectedColor: Colors.white,
                            unselectedColor: Colors.black38,
                            gradientColor: LinearGradient(
                                colors: [Theme.of(context).appBarTheme.color, Colors.greenAccent[700]], stops: [0.2, 0.9], begin: Alignment.topLeft, end: Alignment.bottomRight),
                            padding: 0,
                          ),
                        ),
                      ),
                      SizedBox(width: 40),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  final bool _isLoading;

  Counter(Key key, [this._isLoading = false]) : super(key: key);

  @override
  createState() => CounterState();
}

class CounterState extends State<Counter> {
  ///for total work hours (shown on screen)
  Duration _duration;

  DateTime _startTime;
  Timer _timer;
  bool _showColon = true;

  ///toggle the colon to be hidden and shown
  _toggleColon() => setState(() => _showColon = !_showColon);

  ///updates duration to be shown on screen
  ///
  _updateDuration() => setState(() => _duration = DateTime.now().difference(_startTime));

  ///starts the counter, toggle the colon each 1 second, call updateTime() each 60 seconds
  ///[startTime] if there's already an open session
  startTimer([DateTime startTime]) {
    print('startTime called');
    int _seconds = 0;
    _startTime = startTime ?? DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _toggleColon();
      _seconds++;
      if (_seconds == 60) {
        _updateDuration();
        _seconds = 0;
      }
    });
  }

  ///save previous duration in [_duration]
  ///make sure that time is closed and colon is shown
  stopTimer() async {
    _updateDuration();
    DateTime _endTime = DateTime.now();
    //set session end time
    Provider.of<RoomProvider>(context, listen: false).session.endTime = _endTime;
    _timer.cancel();
    setState(() {
      _showColon = true;
    });
    _startTime = null;
  }

  RoomProvider roomProvider;

  @override
  void initState() {
    _duration = Duration.zero;
    Future.delayed(Duration.zero).then((value) {
      roomProvider = Provider.of<RoomProvider>(context, listen: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        widget._isLoading
            ? CircularProgressIndicator()
            : RichText(
                text: TextSpan(style: const TextStyle(fontFamily: 'digital', fontSize: 24), children: [
                TextSpan(text: ((roomProvider.previousSessionsDuration + _duration).inHours % 60).toString().padLeft(2, '0')),
                TextSpan(text: ':', style: TextStyle(color: _showColon ? Colors.white : COLOR_SCAFFOLD)),
                TextSpan(text: ((roomProvider.previousSessionsDuration + _duration).inMinutes % 60).toString().padLeft(2, '0')),
              ])),
        CircularStepProgressIndicator(
          totalSteps: KTargetWorkHours * 12,
          //increment each 5 minutes (60/5=12)
          currentStep: (roomProvider?.previousSessionsDuration ?? Duration.zero + _duration).inMinutes ~/ 5,
          // ~/ => int
          stepSize: 3,
          selectedStepSize: 8,
          gradientColor: RadialGradient(colors: [COLOR_BACKGROUND, Color.fromRGBO(13, 76, 180, 1)]),
          selectedColor: Color.fromRGBO(13, 76, 180, 1),
          unselectedColor: Colors.white12,
          padding: 0,
          width: 100,
          height: 100,
          roundedCap: (_, __) => true,
        ),
      ],
    );
  }
}
