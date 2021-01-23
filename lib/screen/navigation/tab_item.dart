import 'package:flutter/material.dart';
import 'package:project/screen/main_screen/home_screen.dart';
import '../room_screen.dart';

enum TabItem { home, statistics, chats, profile }

const Map<TabItem, String> tabName = {
  TabItem.home: 'Home',
  TabItem.statistics: 'Statistics',
  TabItem.chats: 'chats',
  TabItem.profile: 'profile'
};

final Map<TabItem, Widget > tabWidget = {
  TabItem.home: HomeScreen(),

};

//assign all route names here
class Routes{
  static const home = '/';
  static const auth = '/auth';
  static const team = '/team';
}
