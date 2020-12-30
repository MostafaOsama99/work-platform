import 'package:flutter/material.dart';
import '../auth/auth_screen.dart';
import 'package:project/screen/main_screen/chats_screen.dart';
import 'package:project/screen/main_screen/home_screen.dart';
import 'package:project/screen/main_screen/statistics_screen.dart';
import 'bottom_navigation.dart';
import 'tab_item.dart';
import 'tab_navigator.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  var _currentTab = TabItem.home;
  final _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.statistics: GlobalKey<NavigatorState>(),
    TabItem.chats: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.home) {
            // select 'main' tab
            _selectTab(TabItem.home);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          Offstage(
            offstage: _currentTab != TabItem.home,
            child: Navigator(
              key: GlobalKey<NavigatorState>(),
              initialRoute: Routes.home,
              onGenerateRoute: (routeSettings) {
                WidgetBuilder builder ;
                switch (routeSettings.name)
                {
                  case Routes.home: builder = (_)=> HomeScreen();
                  break;
                  case Routes.auth: builder = (_)=> AuthScreen();
                  break;
                }
                return MaterialPageRoute(builder: builder,settings: routeSettings);
                  },
            ),
          ),

          Offstage(
            offstage: _currentTab != TabItem.statistics,
            child: Navigator(
              key: GlobalKey<NavigatorState>(),
              onGenerateRoute: (routeSettings) =>
                  MaterialPageRoute(builder: (context) => StatisticsScreen()),
            ),
          ),

          Offstage(
            offstage: _currentTab != TabItem.chats,
            child: Navigator(
              key: GlobalKey<NavigatorState>(),
              //initialRoute: '/home',
              onGenerateRoute: (routeSettings) =>
                  MaterialPageRoute(builder: (context) => ChatsScreen()),
            ),
          ),

        ]),


        bottomNavigationBar: BottomNavigationBar(
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

          currentIndex: _currentTab.index,
          selectedItemColor: Colors.amber[800],
          onTap: (index) => _selectTab(
            TabItem.values[index],
          ),
        ),
      ),
    );
  }

}
