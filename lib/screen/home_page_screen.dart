import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/widgets/task/task_card.dart';

import '../model/task.dart';

const COLOR_BACKGROUND = Color.fromRGBO(37, 36, 42, 1);

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const HEIGHT_APPBAR = 45.0;
    const HEIGHT_ANNOUNCE = 75.0;
    //TODO: subtract bottomNavigationBar height
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        HEIGHT_APPBAR;

    return Scaffold(
      // backgroundColor: COLOR_BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(HEIGHT_APPBAR),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(
                'UN',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.expand_more_outlined,
                  color: Colors.amber,
                ),
                onPressed: null)
          ],
          title: Center(
            child: Text(
              'Team Name',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: bodyHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 75,
              color: Colors.white30,
              child: Center(
                  child: Text(
                'Announcements ...',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
            ),
            Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22, top: 16, bottom: 8),
                      child: Text(
                        'Tasks',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 350,
                      child: Tasks([
                        Task(
                            progress: 70,
                            description: 'description',
                            name: 'Task name',
                            deadline: DateTime.now()),
                        Task(
                            progress: 30,
                            description: 'description',
                            name: 'Task name',
                            deadline: DateTime.now())
                      ]),
                    ),
                  ],
                )),
            Flexible(child: Container()),
          ],
        ),
      ),
    );
  }
}

class Tasks extends StatelessWidget {
  final List<Task> tasks;

  const Tasks(this.tasks);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
       // scrollDirection: Axis.horizontal,
        itemCount: tasks.length,
        itemBuilder: (context, i) => TaskCard(tasks[i]));
  }
}
