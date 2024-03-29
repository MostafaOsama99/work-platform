import 'package:flutter/material.dart';

import 'package:project/model/taskType.dart';
import 'package:project/provider/team_provider.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../screen/task_screen.dart';
import '../../constants.dart';
import '../../model/models.dart' as model;
import '../circular_checkBox.dart';

class TaskCard extends StatelessWidget {
  final int taskId;

  TaskCard({Key key, @required this.taskId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    model.Task task = Provider.of<TeamProvider>(context).findById(taskId);
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      width: size.width - 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // border: Border.all(color: Theme.of(context).appBarTheme.color, width: 1),
        color: COLOR_BACKGROUND,
        //    color: Colors.white10
      ),
      child: InkWell(
        key: UniqueKey(),
        splashColor: Colors.red,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => TaskScreen(taskId: task.id)));
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).scaffoldBackgroundColor, //Colors.black38, //COLOR_BACKGROUND,
                    ),
                    child: Image.asset(taskTypes[task.type].icon, color: taskTypes[task.type].accentColor),
                  ),
                  SizedBox(width: 8),
                  SizedBox(
                    width: size.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task.name,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              fontSize: 17,
                            )),
                        SizedBox(height: 4),

                        Row(
                          children: task.parentCheckpoint != null
                              ? [
                            Icon(Icons.adjust, color: taskTypes[task.type].accentColor, size: 18),
                            SizedBox(width: 4),
                            Expanded(child: Text(task.parentCheckpoint.name, overflow: TextOverflow.fade, softWrap: false))
                          ]
                              : task.taskCreator != null
                              ? [buildUserAvatar(task.taskCreator.name), Text(task.taskCreator.name, overflow: TextOverflow.fade)]
                              : [],
                        ),
                        // if(task.projectName != null)
                        // RichText(
                        //   text: TextSpan(
                        //     children: <TextSpan>[
                        //       TextSpan(
                        //           text: '  project: ',
                        //           style: TextStyle(
                        //               color: Colors.grey,
                        //               fontStyle: FontStyle.italic,
                        //               fontSize: 16)),
                        //       TextSpan(
                        //           text: task.projectName,
                        //           style: TextStyle(
                        //               color: Colors.white, fontSize: 15)),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        formatDate(task.datePlannedStart),
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Icon(Icons.calendar_today_rounded, size: 20, color: KIconColor),
                          ),
                          Text(formatDate(task.datePlannedEnd), style: TextStyle(color: Colors.grey, fontSize: 14)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: StepProgressIndicator(
                  totalSteps: 100,
                  currentStep: task.progress,
                  size: 13,
                  roundedEdges: const Radius.circular(30),
                  padding: 0,
                  selectedColor: Colors.white,
                  gradientColor: LinearGradient(
                      colors: [Theme.of(context).appBarTheme.color, Colors.greenAccent[700]], stops: [0.2, 0.9], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  unselectedColor: Colors.black38, // COLOR_BACKGROUND // Color.fromRGBO(31, 66, 156, 1), //Colors.deepPurple.shade600,
                ),
              ),
            ),

            //  SizedBox(height: 6),

            ///checkpoints
            if (task.checkPoints != null)
              ...task.checkPoints.map((cp) => CheckPoint(
                key: UniqueKey(),
                    checkPoint: cp,
                    taskAccentColor: taskTypes[task.type].accentColor,
                  )),

            Padding(
              padding: const EdgeInsets.only(bottom: 4, top: 4),
              child: Row(
                children:
                // task.parentCheckpoint != null
                //     ? [
                //         Icon(Icons.adjust, color: Colors.amber),
                //         SizedBox(width: 4),
                //         Text(
                //           task.pa  rentCheckpoint.name,
                //         ,
                //         ),
                //         Spacer(),
                //         ...task.members.map((m) => _buildUserAvatar(m)),
                //       ]
                //     :
                [
                  // _buildUserAvatar(task.taskCreator),
                  // Text(task.taskCreator,
                  //     ),
                  if (task.projectName != null)
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: '  project: ', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 15)),
                          TextSpan(text: task.projectName, style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),

                  Spacer(),
                  if (task.members != null) ...task.members.map((u) => buildUserAvatar(u.name)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Padding buildUserAvatar(String userName) {
  return Padding(
    padding: const EdgeInsets.only(right: 4),
    child: CircleAvatar(
      radius: 13,
      backgroundColor: COLOR_SCAFFOLD,
      child: Text(
        "${userName[0]}${userName[(userName.indexOf(' ') + 1)]}",
        style: TextStyle(
          fontSize: 12,
        ),
      ),
    ),
  );
}

class CheckPoint extends StatelessWidget {
  final model.CheckPoint checkPoint;
  final Color taskAccentColor;

  const CheckPoint({Key key, this.checkPoint, this.taskAccentColor})
      : super(key: key);

  static const TS_DONE = TextStyle(
    fontSize: 15,
    color: Colors.grey,
    fontStyle: FontStyle.italic,
    decoration: TextDecoration.lineThrough,
    decorationStyle: TextDecorationStyle.solid,
  );

  // ignore: non_constant_identifier_names
  static final TS_WORKING = TextStyle(fontSize: 15);

  @override
  Widget build(BuildContext context) {
    bool _isFinished = checkPoint.isFinished;
    return SizedBox(
      height: 32,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              checkPoint.name ?? 'unknown',
              style: _isFinished ? CheckPoint.TS_DONE : CheckPoint.TS_WORKING,
            ),
            // Spacer(),
            _isFinished
                ? CircularCheck(activeColor: taskAccentColor.withOpacity(0.8))
                : checkPoint.percentage > 0
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '${checkPoint.percentage}%',
                          style: TextStyle(
                              color: Colors.white70,
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    : SizedBox()
          ],
        ),
      ),
    );
  }
}
