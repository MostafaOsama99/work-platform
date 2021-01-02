import 'package:flutter/material.dart';

import 'home_screen.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Statistics Screen',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          RaisedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Second(),
              ),
            );
          })
        ],
      ),
    );
  }
}
