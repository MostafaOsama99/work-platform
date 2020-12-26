import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/model/task.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width - 32,
      //height: 140,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${task.name}',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Spacer(),
              //${DateFormat('d/M/yy',task.deadline.toString())}
              Text(
                '${task.deadline.day}/${task.deadline.month}/${task.deadline.year.toString().substring(2)}',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              )
            ],
          ),

          //task.checkPoints.map((key, value) =>)
          //CheckPoint(title: 'this is a check point', value: false),
          StepProgressIndicator(
            totalSteps: 100,
            currentStep: task.progress.toInt(),
            size: 13,
            roundedEdges: const Radius.circular(30),
            padding: 0,
            selectedColor: const Color.fromRGBO(45, 142, 175, 1),
            // Colors.green,
            unselectedColor:
                Color.fromRGBO(31, 66, 156, 1), //Colors.deepPurple.shade600,
          ),
        ],
      ),
    );
  }
}

class CheckPoint extends StatefulWidget {
  final title, value;

  const CheckPoint({Key key, @required this.title,this.value = false})
      : super(key: key);

  @override
  _CheckPointState createState() => _CheckPointState();
}

class _CheckPointState extends State<CheckPoint> {
  bool _value ;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 30,
      child: CheckboxListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        dense: true,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
              decoration: _value ? TextDecoration.lineThrough : null,
              decorationStyle:  TextDecorationStyle.solid,
          ),
        ),
        controlAffinity: ListTileControlAffinity.platform,
        onChanged: (bool value) {
          setState(() {
            _value = value;
          });
        },
        value: _value,
      ),
    );
  }
}
