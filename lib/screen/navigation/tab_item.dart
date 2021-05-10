import 'package:flutter/material.dart';
import '../room_screen.dart';

//order is important
enum TabItem { home, statistics, notifications, chats }

const Map<TabItem, String> tabName = {
  TabItem.home: 'Home',
  TabItem.statistics: 'Statistics',
  TabItem.notifications: 'notifications',
  TabItem.chats: 'chats',
};

final Map<TabItem, Widget> tabWidget = {
  //TabItem.home: HomeScreen(),
};

//assign all route names here
class Routes{
  static const home = '/';
  static const auth = '/auth';
  static const team = '/team';
}
