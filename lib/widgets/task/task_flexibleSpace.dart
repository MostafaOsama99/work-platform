import 'package:flutter/material.dart';
import 'package:project/model/task.dart';

import '../../constants.dart';
import '../../widgets/task/task_card.dart';

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
  Color taskAccentColor;
  String taskIcon;

  @override
  void initState() {
    if (widget.task.dependentTask != null) {
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

    // final t =
    // (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
    //     .clamp(0.0, 1.0) as double;
    // final fadeStart = max(0.0, 1.0 - kToolbarHeight / deltaExtent);
    // print('t: $t');
    // print('fade: $fadeStart');

    //print(sbWidth);
    //  print('maxExtent: ${settings.maxExtent}');
    // print('minExtent: ${settings.minExtent}');
    // print('opacity: ${settings.toolbarOpacity}');
    //print('current extent: ${settings.currentExtent}');

    final deltaExtent = settings.maxExtent - settings.minExtent;
    var openedSpace = (settings.currentExtent - settings.minExtent);
    setState(() {
      titleIconPadding =
          (settings.maxExtent - settings.currentExtent) * 45 / deltaExtent;
      opacity = (settings.currentExtent - settings.minExtent) / deltaExtent;
      topPadding = openedSpace * 10 / deltaExtent; //open %
    });
  }

  var titleIconPadding = 0.0;
  var opacity = 0.0;
  var topPadding = 0.0;

  @override
  Widget build(BuildContext context) {
    final notificationHeight = MediaQuery.of(context).padding.top;

    return FlexibleSpaceBar(
      // collapseMode: CollapseMode.pin,
      centerTitle: false,
      titlePadding: const EdgeInsets.all(0),
      stretchModes: [StretchMode.zoomBackground],
      //collapseMode: CollapseMode.pin,
      background: Opacity(
        opacity: opacity,
        child: Container(
          padding:
              EdgeInsets.only(top: notificationHeight, right: 16, left: 16),
          //height: 150 - notificationHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 37, top: 0),
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
                      Text(
                          widget.task.projectName ?? 'not assigned to project!',
                          style: TextStyle(
                              fontSize: 15,
                              color: widget.task.projectName == null
                                  ? Colors.grey
                                  : null,
                              fontStyle: widget.task.projectName == null
                                  ? FontStyle.italic
                                  : null)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.calendar_today_rounded, size: KIconSize),
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

              ///dependent task line
              if (widget.task.dependentTask != null)
                SizedBox(
                  height: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.pause_circle_outline_rounded,
                        size: KIconSize,
                        color: KIconColor,
                      ),
                      Spacer(),
                      Text('after: ', style: TextStyle(fontSize: 15)),
                      Expanded(
                          flex: 15,
                          child: BuildDateTime(
                              selectedDate: widget.task.datePlannedEnd)),
                      Spacer(),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context)
                                .scaffoldBackgroundColor, //Colors.black38, //COLOR_BACKGROUND,
                          ),
                          padding: const EdgeInsets.all(4.5),
                          child: Image.asset('assets/icons/task.png',
                              color: Colors.purple)),
                      SizedBox(width: 8),
                      Expanded(
                          flex: 25,
                          child: FittedBox(
                              child: Text(
                            widget.task.dependentTask.name,
                            style: TextStyle(fontSize: 15),
                          ))),
                    ],
                  ),
                ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 8 + titleIconPadding),
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
            Spacer(),
            Opacity(
              opacity: opacity <= 0.5 ? opacity/2 : opacity,
              child: buildUserAvatar(widget.task.taskCreator),
            )
          ],
        ),
      ),
    );
  }
}
