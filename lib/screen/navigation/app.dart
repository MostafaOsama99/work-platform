import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/constants.dart';
import 'package:project/demoData.dart';
import 'package:project/provider/navbar.dart';
import 'package:project/screen/main_screen/chats_screen.dart';
import 'package:project/screen/room_screen.dart';
import 'package:provider/provider.dart';

import '../auth/auth_screen.dart';
import '../../screen/team_screen.dart';
import '../../screen/main_screen/statistics_screen.dart';
import 'tab_item.dart';

import 'package:convex_bottom_bar/convex_bottom_bar.dart' as bottom;

/*
* working fine but each tab loses the state
* */
const double KIconSize = 20.0;
const double KActiveIconSize = 32.0;

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
              initialRoute: Routes.home, //Routes.home,
              onGenerateRoute: (routeSettings) {
                WidgetBuilder builder;

                /// here we define all named routes for each tap

                switch (routeSettings.name) {
                  case Routes.home:
                    builder = (_) => RoomScreen();
                    break;
                  case Routes.auth:
                    builder = (_) => ChatsScreen();
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
              onGenerateRoute: (routeSettings) => MaterialPageRoute(
                  builder: (context) => ChatsScreen()), // AuthScreen()),
            ),
          ),
        ]),
        bottomNavigationBar: Consumer<NavBar>(
          builder: (BuildContext context, NavBar navBar, Widget child) {
            return AnimatedBuilder(
              builder: (BuildContext context, Widget child) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: navBar.navBarHeight,
                  child: child,
                );
              },
              animation: navBar.scrollController ?? TextEditingController(),
              child: bottom.ConvexAppBar(
                style: bottom.TabStyle.reactCircle,
                height: 44,
                top: navBar.navBarTopValue,
                curveSize: 47,
                //cornerRadius: 15,
                backgroundColor: COLOR_SCAFFOLD,
                activeColor: Color.fromRGBO(34, 28, 38, 1),
                color: Colors.grey,
                initialActiveIndex: 0,
                onTap: (int index) => _selectTab(TabItem.values[index]),
                items: [
                  bottom.TabItem(
                      icon: Icon(Icons.home_filled,
                          color: Colors.white60, size: KIconSize),
                      activeIcon: Icon(Icons.home_filled,
                          color: COLOR_ACCENT, size: KActiveIconSize + 2),
                      title: 'Home'),
                  bottom.TabItem(
                      icon: Icon(Icons.assessment_outlined,
                          color: Colors.white60, size: KIconSize),
                      activeIcon: Icon(Icons.assessment,
                          color: COLOR_ACCENT, size: KActiveIconSize),
                      title: 'Statistics'),
                  bottom.TabItem(
                      icon: Icon(Icons.chat_outlined,
                          color: Colors.white60, size: KIconSize),
                      activeIcon: Icon(Icons.chat,
                          color: COLOR_ACCENT, size: KActiveIconSize - 2),
                      title: 'Chat'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
