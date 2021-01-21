import 'package:flutter/material.dart';

import 'package:circular_check_box/circular_check_box.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../constants.dart';
import '../../model/task.dart' as model;

String formatDate(DateTime date) {
  const month = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  String formatDate;
  formatDate = '${date.day} ${month[date.month - 1]}';

  if (DateTime.now().year != date.year)
    formatDate = formatDate + ', ${date.year.toString().substring(2)}';

  return formatDate;
}

class TaskCard extends StatelessWidget {
  final model.Task task;

  const TaskCard(this.task);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      width: size.width - 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        //border: Border.all(color: Theme.of(context).appBarTheme.color, width: 1),
        color: COLOR_BACKGROUND,
        //    color: Colors.white10
      ),
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
                    color: Theme.of(context)
                        .scaffoldBackgroundColor, //Colors.black38, //COLOR_BACKGROUND,
                  ),
                  child: Image.asset(taskIcon, color: taskAccentColor),
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: size.width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.name,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      SizedBox(height: 4),


                        Row(children:
                        task.parentCheckpoint != null
                            ? [
                          Icon(Icons.adjust, color: Colors.amber,size: 18,),
                          SizedBox(width: 4),
                          Text(
                            task.parentCheckpoint.name,
                            style: TextStyle(color: Colors.white),
                          ),
                        ]
                            :
                        [
                          _buildUserAvatar(task.taskCreator),
                          Text(task.taskCreator,
                              style: TextStyle(color: Colors.white)),
                        ]

                          ,),
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
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Icon(
                            Icons.calendar_today_rounded,
                            size: 21,
                            color:
                                Colors.white, //Theme.of(context).accentColor,
                          ),
                        ),
                        Text(
                          formatDate(task.datePlannedEnd),
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: StepProgressIndicator(
              totalSteps: 100,
              currentStep: task.progress.toInt(),
              size: 13,
              roundedEdges: const Radius.circular(30),
              padding: 0,
              selectedColor: Theme.of(context).appBarTheme.color,
              // const Color.fromRGBO(45, 142, 175, 1),
              // Colors.green,
              unselectedColor: Colors
                  .black38, // COLOR_BACKGROUND // Color.fromRGBO(31, 66, 156, 1), //Colors.deepPurple.shade600,
            ),
          ),

          //  SizedBox(height: 6),

          ///checkpoints
          if (task.checkPoints != null)
            ...task.checkPoints.map((cp) => CheckPoint(
                  key: Key(cp.id),
                  checkPoint: cp,
              taskAccentColor: taskAccentColor,
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
              //           task.parentCheckpoint.name,
              //           style: TextStyle(color: Colors.white),
              //         ),
              //         Spacer(),
              //         ...task.members.map((m) => _buildUserAvatar(m)),
              //       ]
              //     :
              [
                      // _buildUserAvatar(task.taskCreator),
                      // Text(task.taskCreator,
                      //     style: TextStyle(color: Colors.white)),
                if(task.projectName != null)
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '  project: ',
                            style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                                fontSize: 16)),
                        TextSpan(
                            text: task.projectName,
                            style: TextStyle(
                                color: Colors.white, fontSize: 15)),
                      ],
                    ),
                  ),

                      Spacer(),
                      ...task.members.map((m) => _buildUserAvatar(m)),
                    ],
            ),
          )
        ],
      ),
    );
  }

  Padding _buildUserAvatar(String userName) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: CircleAvatar(
        radius: 13,
        backgroundColor: const Color.fromRGBO(17, 20, 25, 1),
        child: Text(
          "${userName[0]}${userName[(userName.indexOf(' ') + 1)]}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class CheckPoint extends StatefulWidget {
  final model.CheckPoint checkPoint;
  final Color taskAccentColor;

  const CheckPoint({Key key, this.checkPoint, this.taskAccentColor}) : super(key: key);

  static const TS_DONE = TextStyle(
    fontSize: 15,
    color: Colors.grey,
    fontStyle: FontStyle.italic,
    decoration: TextDecoration.lineThrough,
    decorationStyle: TextDecorationStyle.solid,
  );

  // ignore: non_constant_identifier_names
  static final TS_WORKING = TextStyle(fontSize: 15, color: Colors.white);

  @override
  _CheckPointState createState() => _CheckPointState();
}

class _CheckPointState extends State<CheckPoint> {
  bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.checkPoint.value;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.checkPoint.name,
              style: _value ? CheckPoint.TS_DONE : CheckPoint.TS_WORKING,
            ),
            widget.checkPoint.percentage <= 0
                ? CircularCheckBox(
                    value: _value,
                    checkColor: Colors.white,
                    //Theme.of(context).accentIconTheme.color,
                    activeColor: widget.taskAccentColor.withOpacity(0.8),
                    inactiveColor: Theme.of(context).appBarTheme.color,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    onChanged: (value) => setState(() => _value = value))
                : Text(
                    '${widget.checkPoint.percentage}%',
                    style: TextStyle(
                        color: Colors.white70, fontStyle: FontStyle.italic),
                  )
          ],
        ),
      ),
    );
  }
}
