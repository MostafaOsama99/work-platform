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
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                padding: EdgeInsets.only(top: notificationHeight),
                height: 200 - notificationHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      task.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text('${task.datePlannedStart}'),
                  ],
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context)
                          .scaffoldBackgroundColor, //Colors.black38, //COLOR_BACKGROUND,
                    ),
                    child: Image.asset(taskIcon, color: taskAccentColor),
                  ),
                  SizedBox(width: 4),
                  Text(
                    task.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Transform.rotate(
                          angle: (22 / 7) / 4, child: Icon(Icons.attach_file, color: Colors.white,)),
                      onPressed: null)
                ],
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context)
                        .scaffoldBackgroundColor, //Colors.black38, //COLOR_BACKGROUND,
                  ),
                  child: Image.asset(taskIcon, color: taskAccentColor),
                ),
                SizedBox(width: 4),
                Text(
                  task.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                    icon: Transform.rotate(
                        angle: (22 / 7) / 4, child: Icon(Icons.attach_file, color: Colors.white,)),
                    onPressed: null)
              ],
            ),
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
