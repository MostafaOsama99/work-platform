import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/screen/auth_screen.dart';
import 'package:project/screen/main_screen/chats_screen.dart';
import 'package:project/screen/main_screen/home_screen.dart';

class App3 extends StatefulWidget {
  @override
  _App3State createState() => _App3State();
}

class _App3State extends State<App3> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return AuthScreen();
            break;
          case 1:
            return HomeScreen();
            break;
          case 2:
            return ChatsScreen();
            break;
          default:
            return null;
        }
      },
    );
  }
}
