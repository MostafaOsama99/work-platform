import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screen/navigation/tab_navigator.dart';

class HomeScreen extends StatelessWidget {
  final routes;

  const HomeScreen({Key key, this.routes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            body: Center(child: Column(
              children: [
                Text('testing. . .',
                  style: TextStyle(fontSize: 30, color: Colors.white),),
                SizedBox(height: 20),
                RaisedButton(onPressed: () {
                    Navigator.of(context).pushNamed(TabNavigatorRoutes.auth);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => Second(),
                  //   ),
                  // );
                })
              ],
            ),),
          );
  }
}

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Text('second screen . . .',
        style: TextStyle(fontSize: 30, color: Colors.white),),
    ));
  }
}
