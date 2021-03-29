import 'package:flutter/material.dart';
import 'package:project/screen/chat_screen.dart';
import 'package:project/screen/main_screen/activity_screen.dart';
import 'package:project/screen/main_screen/attachment%20screen.dart';

import 'screen/navigation/app.dart';

void main() {
  runApp(MyApp());
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
          color: Color.fromRGBO(13, 56, 130, 1), //Color.fromRGBO(33, 230, 193, 1),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
        ),
        dividerColor: Colors.grey.withOpacity(0.3),
        buttonTheme: ButtonTheme.of(context).copyWith(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
        scaffoldBackgroundColor:
            const Color.fromRGBO(17, 20, 25, 1), //Color.fromRGBO(7, 30, 61, 1), //const Color(0x071E3D)
      ),
      themeMode: ThemeMode.dark,
      home: App(),
    );
  }
}
