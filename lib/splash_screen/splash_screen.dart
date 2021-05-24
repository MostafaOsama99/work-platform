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

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  checkCredentials() async {
    final user = Provider.of<UserData>(context, listen: false);
    bool _isLogged = await user.autoLogin();

    if (_isLogged) {
      final roomProvider = Provider.of<RoomProvider>(context, listen: false);

      try {
        print('getting user rooms ...');
        await roomProvider.getUserRooms();
        return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => App()));
      } catch (e) {
        print('splash screen exception: $e');
        //showSnackBar(e, context);
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
