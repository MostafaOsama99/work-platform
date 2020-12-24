import 'package:flutter/material.dart';
import 'package:project/model/task.dart';

class TaskWidget extends StatelessWidget {
  final Task task;

  const TaskWidget( this.task);

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



        ],
      ),
    );
  }
}