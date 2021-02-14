import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class HelloConvexAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      style: TabStyle.react,
      items: [
        TabItem(icon: Icons.list),
        TabItem(icon: Icons.calendar_today),
        TabItem(icon: Icons.assessment),
      ],
      initialActiveIndex: 1 /*optional*/,
      onTap: (int i) => print('click index=$i'),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'tab_item.dart';
//
// class BottomNavigation extends StatelessWidget {
//   BottomNavigation({@required this.currentTab, @required this.onSelectTab});
//   final TabItem currentTab;
//   final ValueChanged<TabItem> onSelectTab;
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.stacked_bar_chart),
//           label: 'statistics',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.chat),
//           label: 'Chats',
//         ),
//       ],
//       onTap: (index) => onSelectTab(
//         TabItem.values[index],
//       ),
//     );
//   }
//
//
//   // Color _colorTabMatching(TabItem item) {
//   //   return currentTab == item ? tabWidget[item] : Colors.grey;
//   // }
// }
