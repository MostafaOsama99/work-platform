import 'package:flutter/material.dart';

import 'package:project/screen/home_page_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(37, 36, 42, 1),
        primarySwatch: Colors.grey,
        accentColor: Color.fromRGBO(40, 49, 230, 1),
        accentColorBrightness: Brightness.light,
        buttonTheme: ButtonTheme.of(context).copyWith(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue, //Colors.grey,
        primaryColor: const Color(0x1F4287), //Colors.black
        backgroundColor: const Color.fromRGBO(19, 76, 161,1),
        accentColor: const Color.fromRGBO(39, 142, 165, 1),//Colors.white,
        accentIconTheme: IconThemeData(color: Color.fromRGBO(33, 230, 193, 1)),
        dividerColor: Colors.grey.withOpacity(0.3),
        buttonTheme: ButtonTheme.of(context).copyWith(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        splashColor: const Color.fromRGBO(39, 142, 165, 0.5),
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          color: Color.fromRGBO(13, 56, 120, 1),
          elevation: 2,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'pt_sans',
        scaffoldBackgroundColor: const Color.fromRGBO(27, 32, 41, 1) //Color.fromRGBO(7, 30, 61, 1), //const Color(0x071E3D)
       ),
       themeMode: ThemeMode.dark,
      home: HomePage(),

    );
  }
}

// class Expansiontile extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//             'Expansion Tile'
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 30.0),
//         child: Column(
//           children: <Widget>[
//             SizedBox(height:20.0),
//             ExpansionTile(
//               title: Text(
//                 "Title",
//                 style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//               children: <Widget>[
//                 ExpansionTile(
//                   title: Text(
//                     'Sub title',
//                   ),
//                   children: <Widget>[
//                     ListTile(
//                       title: Text('data'),
//                     )
//                   ],
//                 ),
//                 ListTile(
//                   title: Text(
//                       'data'
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }