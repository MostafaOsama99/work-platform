import 'package:flutter/material.dart';
import 'package:project/constants.dart';
import 'package:project/provider/room_provider.dart';
import 'package:project/screen/auth/auth_screen.dart';
import 'package:project/screen/auth/login.dart';
import 'package:project/screen/profile_screen.dart';
import 'package:project/screen/room_settings.dart';
import 'package:project/splash_screen/splash_screen.dart';
import 'package:signalr_client/hub_connection.dart';
import 'package:signalr_client/hub_connection_builder.dart';
import 'provider/UserData.dart';
import 'provider/navbar.dart';
import 'package:project/screen/chat_screen.dart';
import 'package:project/screen/main_screen/activity_screen.dart';
import 'package:project/screen/main_screen/attachment%20screen.dart';
import 'package:provider/provider.dart';

import 'provider/team_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/navigation/app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  //preferences.getString('email'),
  // preferences.getString('password')
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: NavBar()),
        ChangeNotifierProvider.value(value: UserData()),
        ChangeNotifierProvider.value(value: RoomProvider()),
        ChangeNotifierProvider.value(value: TeamProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(37, 36, 42, 1),
        primarySwatch: Colors.grey,
        accentColor: Color.fromRGBO(13, 56, 120, 1),
        accentColorBrightness: Brightness.light,
        buttonTheme: ButtonTheme.of(context).copyWith(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        //textTheme: TextTheme(),
        primarySwatch: Colors.blue,
        //Colors.grey,
        primaryColor: const Color.fromARGB(31, 66, 135, 1),
        //Colors.black
        backgroundColor: const Color.fromRGBO(19, 76, 161, 1),
        accentColor: const Color.fromRGBO(13, 56, 130, 1),
        //Colors.white,
        accentIconTheme: IconThemeData(
          color:
              Color.fromRGBO(13, 56, 130, 1), //Color.fromRGBO(33, 230, 193, 1),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
        ),
        dividerColor: Colors.grey.withOpacity(0.3),
        buttonTheme: ButtonTheme.of(context).copyWith(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        splashColor: Colors.blueGrey[700],
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          color: Color.fromRGBO(13, 56, 130, 1),
          elevation: 2,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color.fromRGBO(13, 56, 130, 1),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'pt_sans',
        scaffoldBackgroundColor: const Color.fromRGBO(17, 20, 25, 1), //Color.fromRGBO(7, 30, 61, 1), //const Color(0x071E3D)
      ),
      themeMode: ThemeMode.dark,
      home: SplashScreen(),
      routes: {
        RoomSettings.route: (_) => RoomSettings(),
      },
    );
  }
}
