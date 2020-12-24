import 'package:flutter/material.dart';
import 'package:project/screen/auth_screen.dart';
import 'file:///D:/GP/project/lib/screen/main_screen/home_screen.dart';
import 'package:project/screen/main_screen.dart';
import 'tab_item.dart';

//why class not enum ?
//register named routes here !
class TabNavigatorRoutes {
  static const String root = '/';
  static const String auth = '/auth';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;


  Map<String, Widget> _routeBuilders(BuildContext context) {
    return {
      TabNavigatorRoutes.root: HomeScreen(),
      TabNavigatorRoutes.auth: Second(),
    };
  }

  @override
  Widget build(BuildContext context) {

    final routeBuilders = _routeBuilders(context);

    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) =>  routeBuilders[routeSettings.name],
        );
      },
    );
  }
}
