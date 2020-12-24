import 'package:flutter/material.dart';
import 'tab_item.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({@required this.currentTab, @required this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.stacked_bar_chart),
          label: 'statistics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chats',
        ),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }


  // Color _colorTabMatching(TabItem item) {
  //   return currentTab == item ? tabWidget[item] : Colors.grey;
  // }
}
