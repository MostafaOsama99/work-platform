import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project/provider/UserData.dart';
import 'package:project/provider/data_constants.dart';
import 'package:project/provider/room_provider.dart';
import 'package:project/screen/auth/auth_screen.dart';
import 'package:project/screen/navigation/app.dart';
import 'package:provider/provider.dart';
import 'package:signalr_client/http_connection_options.dart';
import 'package:signalr_client/hub_connection.dart';
import 'package:signalr_client/hub_connection_builder.dart';

import '../constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  HubConnection hubConnection;

  //eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJoZXNoYW1AdGVzdC5jb20iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImVjZDI3YzU2LTZmOWUtNDA4ZC1hZDczLTVmZWYxNDczYzMxMSIsImV4cCI6MTYyMjk3MzgzNiwiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NDQzMzYvIiwiYXVkIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NDQzMzYvIn0.TLqh_WFdkO-x4Tq4B5zM4xYfknFcSXHcZhgjvc2QbuQ
  //eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJtb3N0YWZhQHRlc3QuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiIzM2EwZDUzNi0xZmVlLTRlZjMtOWFiMS01ZTJmY2VmOWI5MGMiLCJleHAiOjE2MjI5NzM4ODIsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjQ0MzM2LyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjQ0MzM2LyJ9.lhI1XrYQNQ3SzjLI9qRBglAzERnEtLkmCSEMYZtFoyQ
  void initSignalR() {
    print('init Signal R');
    hubConnection = HubConnectionBuilder().withUrl(serverNotification).build();
    hubConnection.onclose((error) => print('Connection closed'));
    hubConnection.on('ReceiveMessage', (List args) {
      print("ReceiveMessage: log \n\n\n");
      print("ReceiveMessage:user ${args[0]}");
      print("ReceiveMessage:message ${args[1]}");
    });
  }

  checkCredentials() async {
    final user = Provider.of<UserData>(context, listen: false);
    bool _isLogged = await user.autoLogin();

    if (_isLogged) {
      final roomProvider = Provider.of<RoomProvider>(context, listen: false);

      try {
        print('getting user rooms ...');
        await roomProvider.getUserRooms();
        if (roomProvider.rooms.length > 0) {
          roomProvider.changeRoom(roomProvider.rooms.first.id);
          await roomProvider.getUserTeams(reload: true);
        }
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
    initSignalR();
    hubConnection.start().then((value) => print('*** SIGNAL R INITIALIZED ***'));
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
