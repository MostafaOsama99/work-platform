import 'package:flutter/material.dart';

import '../constants.dart';

class NothingHere extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/icons/task_empty.png', color: COLOR_BACKGROUND),
        Center(child: Text('No tasks here !', style: const TextStyle(color: Colors.white30, fontSize: 16)))
      ],
    );
  }
}
