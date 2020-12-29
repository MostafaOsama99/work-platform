import 'package:flutter/material.dart';
import 'package:project/screen/auth/auth_screen.dart';
import 'package:project/screen/home_page_screen.dart';
import 'package:project/screen/main_screen/join_or_create_team.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(37, 36, 42, 1),
        primarySwatch: Colors.grey,
        accentColor: Color.fromRGBO(40, 49, 230, 1),
        accentColorBrightness: Brightness.light,
        buttonTheme: ButtonTheme.of(context).copyWith(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue, //Colors.grey,
        primaryColor: const Color(0x1F4287), //Colors.black
        backgroundColor: const Color(0x071E3D),
        accentColor: const Color.fromRGBO(39, 142, 165, 1),//Colors.white,
        accentIconTheme: IconThemeData(color: Colors.black),
        dividerColor: Colors.black12,
        buttonTheme: ButtonTheme.of(context).copyWith(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'pt_sans',
        scaffoldBackgroundColor: const Color.fromRGBO(27, 32, 41, 1) //Color.fromRGBO(7, 30, 61, 1), //const Color(0x071E3D)
       ),
       themeMode: ThemeMode.dark,
      home: AuthScreen(),

    );
  }
}

class Expansiontile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            'Expansion Tile'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: <Widget>[
            SizedBox(height:20.0),
            ExpansionTile(
              title: Text(
                "Title",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              children: <Widget>[
                ExpansionTile(
                  title: Text(
                    'Sub title',
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text('data'),
                    )
                  ],
                ),
                ListTile(
                  title: Text(
                      'data'
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}