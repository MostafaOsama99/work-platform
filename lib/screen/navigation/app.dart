import 'package:flutter/material.dart';

import '../auth/auth_screen.dart';
import '../../screen/home_page_screen.dart';
import '../../screen/team_screen.dart';
import '../../screen/main_screen/chats_screen.dart';
import '../../screen/main_screen/statistics_screen.dart';
import 'tab_item.dart';

/*
* working fine but each tab loses the state
* */

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  var _currentTab = TabItem.home;

  //to save each tapView state
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
        //TODO: change home route here
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
        /*
        * the main view here is a stack with children Offstage for each tapView
          * Offstage holding a child and when the value is true it shows up the child
        * */
        body: Stack(children: <Widget>[
          Offstage(
            offstage: _currentTab != TabItem.home,
            child: Navigator(
              key: _navigatorKeys[TabItem.home],
              initialRoute:  Routes.team, //Routes.home,
              onGenerateRoute: (routeSettings) {
                WidgetBuilder builder;

                /// here we define all named routes for each tap

                switch (routeSettings.name) {
                  case Routes.home:
                    builder = (_) => HomePage();
                    break;
                  case Routes.auth:
                    builder = (_) => AuthScreen();
                    break;
                  case Routes.team:
                    builder = (_) => TeamScreen('teamName');
                    break;

                }
                return MaterialPageRoute(
                    builder: builder, settings: routeSettings);
              },
            ),
          ),
          Offstage(
            offstage: _currentTab != TabItem.statistics,
            child: Navigator(
              key: _navigatorKeys[TabItem.statistics],
              onGenerateRoute: (routeSettings) =>
                  MaterialPageRoute(builder: (context) => StatisticsScreen()),
            ),
          ),
          Offstage(
            offstage: _currentTab != TabItem.chats,
            child: Navigator(
              key: _navigatorKeys[TabItem.chats],
              //initialRoute: '/home',
              onGenerateRoute: (routeSettings) =>
                  MaterialPageRoute(builder: (context) => ChatsScreen()),
            ),
          ),
        ]),

        bottomNavigationBar: SizedBox(
          height: 56,

          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20 ), topRight: Radius.circular(20)),
            child: BottomNavigationBar(
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
        ),
      ),
    );
  }
}
