import 'package:flutter/material.dart';
import 'package:project/widgets/custom_paint/parent_checkpoint.dart';
import 'package:project/widgets/task/description_widget.dart';
import 'package:project/widgets/task/task_flexibleSpace.dart';

import '../model/task.dart';


class TaskScreen extends StatelessWidget {
  final Task task;

  const TaskScreen(this.task);

  @override
  Widget build(BuildContext context) {
    /// [taskAccentColor] holding color used in task icon, checkboxes for checkpoints
    Color taskAccentColor;
    String taskIcon;

    if (task.dependentTask != null) {
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
            expandedHeight: task.dependentTask != null ? 180 : 150,
            actions: [
              IconButton(
                  icon: Transform.rotate(
                      angle: 3.14 / 4,
                      child: Icon(
                        Icons.attach_file,
                        color: Colors.white,
                      )),
                  onPressed: null)
            ],

            flexibleSpace: BuildFlexibleSpace(task: task),
          ),

          if(task.parentCheckpoint != null)
          SliverList(
            delegate: SliverChildListDelegate([

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomPaint(
                  size: Size(MediaQuery.of(context).size.width,200), //You can Replace this with your desired WIDTH and HEIGHT
                  painter: RPSCustomPainter(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.adjust, color: Colors.amber,),
                          SizedBox(width: 8),
                          Text(task.parentCheckpoint.name)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Text('description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text(task.parentCheckpoint.description),
                      ),
                    ],
                  ),
                ),
              ),


                // Container(
                //   height:180,
                //   margin: const EdgeInsets.all(8),
                //   padding: const EdgeInsets.only(right: 8, bottom: 8),
                //   decoration: BoxDecoration(
                //     border: Border(left: BorderSide(color: Colors.amber), bottom: BorderSide(color: Colors.amber),
                //             //top:BorderSide(color: Colors.amber), right: BorderSide(color: Colors.amber, width: 1)
                //     ),
                //     //borderRadius: BorderRadius.circular(25),
                //
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.stretch,
                //     children: [
                //       Row(
                //         children: [
                //           Icon(Icons.adjust, color: Colors.amber,),
                //           SizedBox(width: 8),
                //           Text(task.parentCheckpoint.name)
                //         ],
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                //         child: Text('description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(left:8.0),
                //         child: Text(task.parentCheckpoint.description),
                //       ),
                //     ],
                //   ),
                // ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: DescriptionWidget(task.description, MediaQuery.of(context).size.width),
              ),
              ]),
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
