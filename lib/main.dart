import 'package:flutter/material.dart';
import 'file:///D:/GP/project/lib/screen/auth/auth_screen.dart';


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
        primarySwatch: Colors.grey,
        primaryColor: Colors.black,
        backgroundColor: const Color(0xFF212121),
        accentColor: Colors.white,
        accentIconTheme: IconThemeData(color: Colors.black),
        dividerColor: Colors.black12,
        buttonTheme: ButtonTheme.of(context).copyWith(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
       ),
       themeMode: ThemeMode.dark,
      home: AuthScreen(),

    );
  }
}
