import 'package:flutter/material.dart';
import 'package:project/constants.dart';
import 'package:project/provider/UserData.dart';
import 'package:project/provider/room_provider.dart';
import 'package:project/screen/room_settings.dart';
import 'package:project/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'menu_tile.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context, listen: false);

    void logout() async {
      //TODO: show confirmation dialog
      await user.clearUserData();
      Provider.of<RoomProvider>(context, listen: false).clear();
      Navigator.of((ModalRoute.of(context).settings.arguments as GlobalKey<ScaffoldState>).currentContext)
          .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SplashScreen()), (Route<dynamic> route) => false);
    }

    var lastLitter = user.name.indexOf(' ') + 1;
    return Drawer(
      child: SafeArea(
        //to avoid notifications bar
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            SizedBox(
              height: 75,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CircleAvatar(
                      radius: 40,
                      child: Text(user.name[0] + user.name[lastLitter], style: TextStyle(fontSize: 18)),
                      backgroundColor: Colors.black,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: 8),
                      Center(child: Text(user.name, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold))),
                      Text(user.jobTitle, style: TextStyle(fontSize: 16, color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            MenuTile(
              icon: Icons.settings,
              title: 'Room Settings',
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => RoomSettings()));
              },
            ),
            MenuTile(icon: Icons.logout, title: 'logout', onTap: logout),

            // Expanded(
            //   child: Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Padding(
            //       padding: const EdgeInsets.only(bottom:8.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: <Widget>[
            //           SocialMediaIcon(icon: 'Images/drawer/facebook.png',onTap: (){
            //
            //            _launchURL('https://www.facebook.com/Mersalfoundation');
            //           },),
            //           SocialMediaIcon(icon: 'Images/drawer/insta.png',onTap: (){
            //             _launchURL('https://www.instagram.com/mersalcharity');
            //           },),
            //           SocialMediaIcon(icon: 'Images/drawer/youtube.png',
            //           onTap: (){
            //             _launchURL('https://www.youtube.com/channel/UC30Ek5Wl1us6LD6BLkegsHQ');
            //           },
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class SocialMediaIcon extends StatelessWidget {
  final String icon;
  final Function onTap;

  const SocialMediaIcon({this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      iconSize: 30,
      onPressed: () => onTap(),
      icon: Image.asset(
        icon,
        width: 30,
        height: 30,
      ),
      // child: Image.asset(icon, width: 30, height: 30),
    );
  }
}

//here where you make navigating
navigate(final BuildContext context, final String route) {
  Navigator.of(context).pop();
  Navigator.pushNamed(context, route);
  // stack overflow not working
//        bool isNewRouteSameAsCurrent = true;
//        Navigator.popUntil(context, (currentRoute) {
//          if (currentRoute.settings.name == route) {
//            isNewRouteSameAsCurrent = true;
//          }
//          return true;
//        });
//
//        if (!isNewRouteSameAsCurrent) {
//          Navigator.pushNamed(context, route);
//        }
}
