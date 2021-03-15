import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project/model/task.dart';
import 'package:project/model/taskType.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../constants.dart';
import '../../demoData.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  Task _activeTask;
  int _teamId;

  GlobalKey<CounterState> _timerKey = GlobalKey();

  @override
  void initState() {
    //TODO: check for online working task
    // _teamId = -1;
    // _activeTask = Task(name: null, id: '--1', datePlannedEnd: null);
    super.initState();
  }

  toggleTaskTime({bool isWorking, Task task, int teamId}) {
    setState(() {
      if (isWorking) {
        _teamId = teamId;
        _activeTask = task;
        _timerKey.currentState.startTimer();
      } else {
        //TODO: show ending dialog
        _activeTask = null;
        _teamId = null;
        _timerKey.currentState.stopTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 8, top: MediaQuery.of(context).padding.top + 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                color: COLOR_BACKGROUND.withOpacity(0.5) //COLOR_ACCENT.withOpacity(0.8),
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
                          child: Text('Daily Progress',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                      if (_activeTask != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 28,
                              width: 28,
                              child: RaisedButton(
                                  padding: const EdgeInsets.all(0),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Counter(_timerKey, (workTime) => null),
                ),
                // SizedBox(height: 8),
              ],
            ),
          ),
          Expanded(
              child: DefaultTabController(
            length: teams.length,
            child: Column(
              children: [
                // if (_activeTask != null)
                //   Card(
                //     elevation: 2,
                //     margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                //     color: COLOR_BACKGROUND,
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(15),
                //       child: Padding(
                //         padding: const EdgeInsets.all(8),
                //         child: Row(
                //           children: [
                //             Container(
                //               width: 35,
                //               height: 35,
                //               padding: const EdgeInsets.all(6),
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(8),
                //                 color: Theme.of(context).scaffoldBackgroundColor, //Colors.black38, //COLOR_BACKGROUND,
                //               ),
                //               child: Image.asset(taskTypes[_activeTask.type].icon,
                //                   color: taskTypes[_activeTask.type].accentColor),
                //             ),
                //             SizedBox(width: 10),
                //             Text(_activeTask.name, style: const TextStyle(fontSize: 16)),
                //             Spacer(),
                //             SizedBox(
                //               height: 35,
                //               width: 35,
                //               child: RaisedButton(
                //                   padding: const EdgeInsets.all(0),
                //                   child: Icon(Icons.pause, color: Colors.white),
                //                   splashColor: Colors.deepOrange,
                //                   textColor: Colors.deepOrange,
                //                   color: Colors.deepOrange[800],
                //                   highlightElevation: 2,
                //                   //autofocus: false,
                //                   //clipBehavior: Clip.antiAlias,
                //
                //                   shape: RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.circular(8),
                //                     side: BorderSide(color: Colors.deepOrange[800].withOpacity(0.5)),
                //                   ),
                //                   onPressed: () {
                //                     toggleTime(isWorking: false);
                //                   }),
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
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
                          indicatorPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                          indicator: BoxDecoration(borderRadius: BorderRadius.circular(50), color: COLOR_ACCENT),
                          indicatorSize: TabBarIndicatorSize.label,
                          tabs: [
                            for (final team in teams)
                              Tab(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(color: COLOR_ACCENT, width: 1)),
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
                      for (final Team _team in teams)
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [COLOR_SCAFFOLD, Colors.transparent, Colors.transparent, Colors.blue],
                              stops: [0.0, 0.04, 0.96, 1.0],
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.dstOut,
                          child: ListView.builder(
                              padding: const EdgeInsets.only(left: 4, right: 4, top: 2),
                              key: UniqueKey(),
                              itemCount: _team.tasks.length,
                              itemBuilder: (_, index) => WorkTile(
                                    key: UniqueKey(),
                                    task: _team.tasks[index],
                                    isWorking: _activeTask == null
                                        ? false
                                        : (_activeTask.id == _team.tasks[index].id && _teamId == _team.id),
                                    onPressed: (bool value, Task task) {
                                      toggleTaskTime(isWorking: value, task: task, teamId: _team.id);
                                    },
                                  )),
                        )
                    ],
                  ),
                ),
              ],
            ),
          )),
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
    bool _isExceed = task.datePlannedEnd.isAfter(DateTime.now());

    int _spent;
    if (task.datePlannedEnd.isAfter(DateTime.now())) {
      _isExceed = true;
      _spent = 100;
    } else
      _spent = (task.datePlannedStart.difference(task.datePlannedEnd).inDays /
              task.datePlannedStart.difference(DateTime.now()).inDays *
              100)
          .toInt();

    LinearGradient _timeGradient;

    if (_spent <= task.progress)
      _timeGradient = LinearGradient(colors: [COLOR_ACCENT, Colors.blueAccent], stops: [0.2, 0.8]);
    else if (_spent > task.progress && _spent <= task.progress * 1.5 && _spent <= 90) // 50-75%
      _timeGradient = LinearGradient(colors: [COLOR_ACCENT, Colors.amberAccent], stops: [0.2, 0.8]);
    else
      _timeGradient = LinearGradient(colors: [Colors.redAccent, Colors.redAccent.shade700], stops: [0.2, 0.8]);

    return Card(
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
                          padding: const EdgeInsets.all(0),
                          child: isWorking
                              ? Icon(Icons.pause, color: Colors.white)
                              : Icon(Icons.play_arrow_sharp, color: Colors.white70),
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
                              colors: [Theme.of(context).appBarTheme.color, Colors.greenAccent[700]],
                              stops: [0.2, 0.9],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
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
    );
  }
}

class Counter extends StatefulWidget {
  final Function(DateTime workTime) onStop;

  Counter(Key key, this.onStop) : super(key: key);

  @override
  createState() => CounterState();
}

class CounterState extends State<Counter> {
  ///for previous work hours sessions
  Duration _oldDuration;

  ///for total work hours (shown on screen)
  Duration _duration;

  DateTime _startTime;
  Timer _timer;
  bool _showColon = true;

  ///toggle the colon to be hidden and shown
  _toggleColon() => setState(() => _showColon = !_showColon);

  ///updates duration to be shown on screen
  ///
  _updateDuration() => setState(() => _duration = _oldDuration + DateTime.now().difference(_startTime));

  ///starts the counter, toggle the colon each 1 second, call updateTime() each 60 seconds
  startTimer() {
    int _seconds = 0;
    _startTime = DateTime.now();
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
  stopTimer() {
    _updateDuration();
    //save this session
    _oldDuration = _duration;
    _startTime = null;
    _timer.cancel();
    setState(() {
      _showColon = true;
    });
  }

  @override
  void initState() {
    // TODO: get previous work hours
    _oldDuration = Duration(seconds: 1175);
    _duration = _oldDuration;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        RichText(
            text: TextSpan(style: const TextStyle(fontFamily: 'digital', fontSize: 24), children: [
          TextSpan(text: (_duration.inHours % 60).toString().padLeft(2, '0')),
          TextSpan(text: ':', style: TextStyle(color: _showColon ? Colors.white : COLOR_SCAFFOLD)),
          TextSpan(text: (_duration.inMinutes % 60).toString().padLeft(2, '0')),
        ])),
        CircularStepProgressIndicator(
          totalSteps: KTargetWorkHours * 12,
          //increment each 5 minutes (60/5=12)
          currentStep: _duration.inMinutes ~/ 5,
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
