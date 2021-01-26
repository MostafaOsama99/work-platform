import 'package:flutter/material.dart';

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
            expandedHeight: 200,
            //leadingWidth: 20.0,

            flexibleSpace: BuildFlexibleSpace(task: task),
            // title: Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Container(
            //       width: 35,
            //       height: 35,
            //       padding: const EdgeInsets.all(8),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: Theme.of(context)
            //             .scaffoldBackgroundColor, //Colors.black38, //COLOR_BACKGROUND,
            //       ),
            //       child: Image.asset(taskIcon, color: taskAccentColor),
            //     ),
            //     SizedBox(width: 4),
            //     Text(
            //       task.name,
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 18,
            //           fontWeight: FontWeight.bold),
            //     ),
            //     Spacer(),
            //     IconButton(
            //         icon: Transform.rotate(
            //             angle: (22 / 7) / 4, child: Icon(Icons.attach_file, color: Colors.white,)),
            //         onPressed: null)
            //   ],
            // ),
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
    bool visible =
        settings == null || settings.currentExtent <= settings.minExtent;

    // print(settings.minExtent);
    // print('maxExtent: ${settings.maxExtent}');
    // print('opacity: ${settings.toolbarOpacity}');
    print('current extent: ${settings.currentExtent}');
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final notificationHeight = MediaQuery.of(context).padding.top;

    return FlexibleSpaceBar(
      // collapseMode: CollapseMode.pin,
      centerTitle: false,
      titlePadding: const EdgeInsets.all(0),
      background: Container(
        padding: EdgeInsets.only(top: notificationHeight),
        height: 200 - notificationHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.task.name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text('${widget.task.datePlannedStart}'),
          ],
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(top: 0),
        child: Container(
          height: 35,
          padding: const EdgeInsets.all(4),
          color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 27,
                height: 27,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context)
                      .scaffoldBackgroundColor, //Colors.black38, //COLOR_BACKGROUND,
                ),
                child: Image.asset(taskIcon, color: taskAccentColor),
              ),
              SizedBox(width: 4),
              Text(
                widget.task.name,
                style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              IconButton(
                  icon: Transform.rotate(
                      angle: (22 / 7) / 4,
                      child: Icon(
                        Icons.attach_file,
                        color: Colors.white,
                        size: 20,
                      )),
                  onPressed: null)
            ],
          ),
        ),
      ),
    );
  }
}
