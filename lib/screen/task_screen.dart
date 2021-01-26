import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project/constants.dart';

import '../model/task.dart';

class TaskScreen extends StatelessWidget {
  final Task task;

  const TaskScreen(this.task);

  @override
  Widget build(BuildContext context) {
    /// [taskAccentColor] holding color used in task icon, checkboxes for checkpoints
    Color taskAccentColor;
    String taskIcon;

    if (task.dependentTaskId != null) {
      taskAccentColor = Colors.purple;
      taskIcon = 'assets/icons/subtask-dependent.png';
    } else if (task.parentCheckpoint != null) {
      taskAccentColor = Colors.amber;
      taskIcon = 'assets/icons/subtask.png';
    } else {
      taskAccentColor = Colors.greenAccent.shade400;
      taskIcon = 'assets/icons/task.png';
    }

    final notificationHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            // forceElevated: true,
            collapsedHeight: 50,
            toolbarHeight: 49.9999,
            expandedHeight: 180,
            //leadingWidth: 20.0,
            actions: [
              IconButton(
                  icon: Transform.rotate(
                      angle: (22 / 7) / 4,
                      child: Icon(
                        Icons.attach_file,
                        color: Colors.white,
                        //size: 20,
                      )),
                  onPressed: null)
            ],

            flexibleSpace: BuildFlexibleSpace(task: task),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  height: 100,
                  color: Colors.grey,
                  child: Center(child: Text('$index')),
                );
              },
              childCount: 10,
            ),
          )
        ],
      ),
    );
  }
}

class BuildFlexibleSpace extends StatefulWidget {
  final Widget child;
  final Task task;

  const BuildFlexibleSpace({
    Key key,
    this.child,
    @required this.task,
  }) : super(key: key);

  @override
  _BuildFlexibleSpaceState createState() {
    return new _BuildFlexibleSpaceState();
  }
}

class _BuildFlexibleSpaceState extends State<BuildFlexibleSpace> {
  ScrollPosition _position;
  bool _visible;

  Color taskAccentColor;
  String taskIcon;

  @override
  void initState() {
    if (widget.task.dependentTaskId != null) {
      taskAccentColor = Colors.purple;
      taskIcon = 'assets/icons/subtask-dependent.png';
    } else if (widget.task.parentCheckpoint != null) {
      taskAccentColor = Colors.amber;
      taskIcon = 'assets/icons/subtask.png';
    } else {
      taskAccentColor = Colors.greenAccent.shade400;
      taskIcon = 'assets/icons/task.png';
    }
    super.initState();
  }

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings settings =
        context.inheritFromWidgetOfExactType(FlexibleSpaceBarSettings);

    final deltaExtent = settings.maxExtent - settings.minExtent;
    final t =
        (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
            .clamp(0.0, 1.0) as double;
    final fadeStart = max(0.0, 1.0 - kToolbarHeight / deltaExtent);
    print('t: $t');
    print('fade: $fadeStart');

    print(sbWidth);
    //  print('maxExtent: ${settings.maxExtent}');
    // print('minExtent: ${settings.minExtent}');
    // print('opacity: ${settings.toolbarOpacity}');
    print('current extent: ${settings.currentExtent}');
    var x = (settings.currentExtent - settings.minExtent);
    setState(() {
      sbWidth = (settings.maxExtent - settings.currentExtent) / 3;
      topPadding = x * 10 / deltaExtent; //open %
    });
  }

  var sbWidth = 0.0;
  var topPadding = 0.0;

  @override
  Widget build(BuildContext context) {
    final notificationHeight = MediaQuery.of(context).padding.top;

    return FlexibleSpaceBar(
      // collapseMode: CollapseMode.pin,
      centerTitle: false,
      titlePadding: const EdgeInsets.all(0),
      stretchModes: [StretchMode.zoomBackground],
      collapseMode: CollapseMode.pin,
      background: Container(
        padding: EdgeInsets.only(top: notificationHeight),
        //height: 150 - notificationHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 44,
              child: Padding(
                padding: const EdgeInsets.only(left: 55, top: 10),
                child: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context)
                              .scaffoldBackgroundColor, //Colors.black38, //COLOR_BACKGROUND,
                        ),
                        width: 35,
                        height: 35,
                        child: Image.asset('assets/icons/project.png',
                            color: Colors.white)),
                    SizedBox(width: 8),
                    Text(widget.task.projectName ?? 'not assigned to project!',
                        style: TextStyle(
                            fontSize: 15,
                            color: widget.task.projectName == null
                                ? Colors.grey
                                : null,
                            fontStyle: widget.task.projectName == null
                                ? FontStyle.italic
                                : null

                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.calendar_today_rounded, size: 18),
                    Spacer(),
                    RichText(
                        text:
                            TextSpan(style: TextStyle(fontSize: 15), children: [
                      TextSpan(
                          text: 'from: ', style: TextStyle(color: Colors.grey)),
                      //TextSpan(text: '${widget.task.datePlannedStart.day} ${formatDate(widget.task.datePlannedStart)}')
                    ])),
                    Expanded(
                        flex: 15,
                        child: BuildDateTime(
                            selectedDate: widget.task.datePlannedStart)),
                    Spacer(flex: 2),
                    RichText(
                        text:
                            TextSpan(style: TextStyle(fontSize: 15), children: [
                      TextSpan(
                          text: 'duo: ', style: TextStyle(color: Colors.grey)),
                      //TextSpan(text: formatDate(widget.task.datePlannedStart))
                    ])),
                    Expanded(
                        flex: 15,
                        child: BuildDateTime(
                            selectedDate: widget.task.datePlannedEnd)),
                    Spacer(flex: 2),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.calendar_today_rounded, size: 18),
                Spacer(),
                RichText(
                    text: TextSpan(style: TextStyle(fontSize: 15), children: [
                  TextSpan(
                      text: 'from: ', style: TextStyle(color: Colors.grey)),
                  //TextSpan(text: '${widget.task.datePlannedStart.day} ${formatDate(widget.task.datePlannedStart)}')
                ])),
                Expanded(
                    flex: 15,
                    child: BuildDateTime(
                        selectedDate: widget.task.datePlannedStart)),
                Spacer(flex: 2),
                RichText(
                    text: TextSpan(style: TextStyle(fontSize: 15), children: [
                  TextSpan(text: 'duo: ', style: TextStyle(color: Colors.grey)),
                  //TextSpan(text: formatDate(widget.task.datePlannedStart))
                ])),
                Expanded(
                    flex: 15,
                    child: BuildDateTime(
                        selectedDate: widget.task.datePlannedEnd)),
                Spacer(flex: 2),
              ],
            ),
            //
            // Text(
            //   widget.task.name,
            //   style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold),
            // ),
            // Text('${widget.task.datePlannedStart}'),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 8 + sbWidth),
            Container(
              width: 35 - topPadding / 1.5,
              height: 35 - topPadding / 1.5,
              padding: EdgeInsets.all(6.5 - topPadding / 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context)
                    .scaffoldBackgroundColor, //Colors.black38, //COLOR_BACKGROUND,
              ),
              child: Image.asset(taskIcon, color: taskAccentColor),
            ),
            SizedBox(width: 6),
            Text(
              widget.task.name,
              style: TextStyle(
                  fontSize: 16 - topPadding / 2, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
