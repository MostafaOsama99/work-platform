import 'package:circular_check_box/circular_check_box.dart';
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
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${task.name}',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Icon(
                  Icons.alarm,
                  color: Theme.of(context).accentColor,
                ),
              ),
              //${DateFormat('d/M/yy',task.deadline.toString())}
              Text(
                '${task.deadline.day}/${task.deadline.month}/${task.deadline.year.toString().substring(2)}',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              )
            ],
          ),
          // CheckPoint(
          //   title: "task 1",
          //   value: true,
          // ),

          if (task.checkPoints != null)
            ...task.checkPoints.entries
                .map((e) => CheckPoint(title: e.key, value: e.value))
                .toList(),
          //List.generate(task.checkPoints.length, (index) => CheckPoint(title: task.checkPoints.,value: value))
          //task.checkPoints.map((key, value) => CheckPoint(title: title,value: value))
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

  static const TS_DONE = TextStyle(
    fontSize: 16,
    color: Colors.grey,
    fontStyle: FontStyle.italic,
    decoration: TextDecoration.lineThrough,
    decorationStyle: TextDecorationStyle.solid,
  );

  // ignore: non_constant_identifier_names
  static final TS_WORKING =
      TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8));

  const CheckPoint({Key key, @required this.title, this.value = false})
      : super(key: key);

  @override
  _CheckPointState createState() => _CheckPointState();
}

class _CheckPointState extends State<CheckPoint> {
  bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        highlightColor: Colors.black26,
        onTap: () => setState(() => _value = !_value),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: _value ? CheckPoint.TS_DONE : CheckPoint.TS_WORKING,
              ),
              CircularCheckBox(
                  value: _value,
                  checkColor: Theme.of(context).accentIconTheme.color,
                  inactiveColor: Colors.black45,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  onChanged:(value)=> setState(() => _value = value)),
            ],
          ),
        ),
      ),
    );
  }
}
