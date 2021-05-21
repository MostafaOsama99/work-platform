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
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  // Navigator.of(context).pushReplacement(MaterialPageRoute(
  // builder: (BuildContext context) => BottomNavigation()))
  void initState() {
    print(widget.email);
    print(widget.password);

    super.initState();
    if (widget.email != null) {
      Timer(Duration(seconds: 2), () async {
        final user = Provider.of<UserData>(context, listen: false);
        user.setPassword = widget.password;
        user.setMail = widget.email;
        await handleRequest(user.signIn, scaffoldKey.currentContext);
        print('getting current user ...');
        await handleRequest(user.getCurrentUser, scaffoldKey.currentContext);
        //
        print('getting user rooms ...');
        await handleRequest(
            Provider.of<RoomProvider>(context, listen: false).getUserRooms,
            scaffoldKey.currentContext);
        //
        Provider.of<RoomProvider>(context, listen: false).changeRoom(
            Provider.of<RoomProvider>(context, listen: false).rooms.first.id);

        //  initial loading
        Provider.of<RoomProvider>(context, listen: false)
            .getUserTeams(reload: true);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => App()));
      });
    } else {
      Timer(Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => AuthScreen()));
      });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
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
             Image.asset("assets/icons/workera_logo.png",width: 60,height: 60 ,),
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
