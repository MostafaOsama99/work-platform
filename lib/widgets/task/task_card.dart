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
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width - 32,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          StepProgressIndicator(
            totalSteps: 100,
            currentStep: task.progress.toInt(),
            size: 13,
            roundedEdges: const Radius.circular(30),
            padding: 0,
            selectedColor: Colors.green,
            unselectedColor: Colors.deepPurple.shade600,
          ),
        ],
      ),
    );
  }
}
