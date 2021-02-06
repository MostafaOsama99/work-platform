import 'package:flutter/material.dart';
import 'package:project/model/task.dart';
import 'package:project/screen/activity_screen.dart';

import '../../constants.dart';
import '../../widgets/task/task_card.dart';
import '../dateField_widget.dart';

class BuildFlexibleSpace extends StatefulWidget {
  final Widget child;
  final Task task;
  final bool isEdit;

  const BuildFlexibleSpace({
    Key key,
    this.child,
    @required this.task,
    this.isEdit = false,
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
    final FlexibleSpaceBarSettings settings = context.inheritFromWidgetOfExactType(FlexibleSpaceBarSettings);

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
      titleIconPadding = (settings.maxExtent - settings.currentExtent) * 43 / deltaExtent;
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
        opacity: opacity <= 0.5 ? opacity / 2 : opacity,
        child: Container(
          padding: EdgeInsets.only(top: notificationHeight, right: 16, left: 16),
          //height: 150 - notificationHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 45,
                child: Padding(
                  padding: const EdgeInsets.only(left: 37, top: 0),
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).scaffoldBackgroundColor, //Colors.black38, //COLOR_BACKGROUND,
                          ),
                          width: 32,
                          height: 32,
                          child: Image.asset('assets/icons/project.png', color: Colors.white)),
                      SizedBox(width: 8),
                      Text(widget.task.projectName ?? 'not assigned to project!',
                          style: TextStyle(
                              fontSize: 15,
                              color: widget.task.projectName == null ? Colors.grey : null,
                              fontStyle: widget.task.projectName == null ? FontStyle.italic : null)),
                    ],
                  ),
                ),
              ),

              //TODO: handle case: if user selects new [task.datePlannedStart] and this exceeds [task.datePlannedEnd],
              //TODO: [task.datePlannedEnd] should be empty(red text), if user didn't update [task.datePlannedEnd] deny date changes update
              SizedBox(
                height: 27,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 3),
                    Icon(Icons.calendar_today_rounded, size: KIconSize),
                    Spacer(),
                    Text('from: ', style: TextStyle(color: Colors.grey, fontSize: 15)),
                    DateField(
                        initialDate: widget.task.datePlannedStart,
                        firstDate:
                            (widget.task.dependentTask != null ? widget.task.dependentTask.datePlannedEnd : null),
                        isEditing: widget.isEdit),
                    Spacer(flex: 3),
                    Text('duo: ', style: TextStyle(fontSize: 15, color: Colors.grey)),
                    DateField(
                      initialDate: widget.task.datePlannedEnd,
                      isEditing: widget.isEdit,
                      firstDate: widget.task.datePlannedStart,
                    ),
                    Spacer(flex: 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(bottom: 5 - topPadding / 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 6 + titleIconPadding),
            Container(
              width: 34 - topPadding / 1.3,
              height: 34 - topPadding / 1.2,
              padding: EdgeInsets.all(5 - topPadding / 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).scaffoldBackgroundColor, //Colors.black38, //COLOR_BACKGROUND,
              ),
              child: Image.asset(taskIcon, color: taskAccentColor),
            ),
            SizedBox(width: 6),
            Text(
              widget.task.name,
              style: TextStyle(fontSize: 16 - topPadding / 2, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Opacity(
              opacity: opacity <= 0.5 ? opacity / 2 : opacity,
              child: SizedBox(
                height: 22,
                width: 22,
                child: IconButton(
                    icon: Icon(Icons.chat),
                    color: COLOR_SCAFFOLD,
                    iconSize: 20,
                    splashRadius: 13,
                    padding: const EdgeInsets.all(0),
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (BuildContext context) => ActivityScreen()))),
              ),
            ),
            SizedBox(width: 8),
            Opacity(
              opacity: opacity <= 0.5 ? opacity / 2 : opacity,
              child: buildUserAvatar(widget.task.taskCreator.name),
            ),
          ],
        ),
      ),
    );
  }
}
