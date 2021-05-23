import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project/provider/UserData.dart';
import 'package:project/provider/data_constants.dart';
import 'package:project/provider/room_provider.dart';
import 'package:project/screen/auth/auth_screen.dart';
import 'package:project/screen/navigation/app.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  final email, password, language;

  SplashScreen({this.email, this.password, this.language});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  checkCredentials() async {
    print(widget.email);
    print(widget.password);

    if (widget.email != null) {
      final user = Provider.of<UserData>(context, listen: false);
      user.setPassword = widget.password;
      user.setMail = widget.email;

      final roomProvider = Provider.of<RoomProvider>(context, listen: false);

      try {
        await user.signIn();
        print('getting current user ...');
        await user.getCurrentUser();

        print('getting user rooms ...');
        await roomProvider.getUserRooms();

        //roomProvider.changeRoom(roomProvider.rooms.first.id);
        //  initial loading
        //await roomProvider.getUserTeams(reload: true);

        return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => App()));
      } catch (e) {
        print('splash screen exception: $e');
        showSnackBar(e, context);
        //TODO: handle exceptions to user
      }
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => AuthScreen()));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) => checkCredentials());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       alignment: Alignment(-5, 15),
          //       image: AssetImage('assets/Splash.png'),
          //       fit: BoxFit.fill),
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/workera_logo.png",
                width: 60,
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45, right: 45, top: 30),
                child: LinearProgressIndicator(
                  color: Colors.deepOrange,
                  backgroundColor: Colors.orange[300].withOpacity(0.4),
                ),
              ),
            ],
          ),
        ));
  }
}
