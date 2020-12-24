import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screen/main_screen/home_screen.dart';

class App2 extends StatefulWidget {
  @override
  _App2State createState() => _App2State();
}

class _App2State extends State<App2> {
  final pagesRouteFactories = {
    "/": () => MaterialPageRoute(
          builder: (context) => Center(
            child: HomeScreen(),
          ),
        ),
    "takeOff": () => MaterialPageRoute(
          builder: (context) => Center(
            child: Text("Take Off"),
          ),
        ),
    "landing": () => MaterialPageRoute(
          builder: (context) => Center(
            child: Text("Landing"),
          ),
        ),
    "settings": () => MaterialPageRoute(
          builder: (context) => Center(
            child: Text("Settings"),
          ),
        ),
  };

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: _buildBody(),
          bottomNavigationBar: _buildBottomNavigationBar(context),
        ));

  Widget _buildBody() => MaterialApp(
      onGenerateRoute: (route) => pagesRouteFactories[route.name]());

  Widget _buildBottomNavigationBar(context) => BottomNavigationBar(
          items: [
            _buildBottomNavigationBarItem("Home", Icons.home),
            _buildBottomNavigationBarItem("Take Off", Icons.flight_takeoff),
            _buildBottomNavigationBarItem("Landing", Icons.flight_land),
            _buildBottomNavigationBarItem("Settings", Icons.settings)
          ],
          onTap: (routeName) => setState(
                () => Navigator.of(context)
                    .pushNamed(pagesRouteFactories.keys.toList()[routeName]),
              ));

  _buildBottomNavigationBarItem(name, icon) => BottomNavigationBarItem(
      icon: Icon(icon), label: name, backgroundColor: Colors.black45);
}


