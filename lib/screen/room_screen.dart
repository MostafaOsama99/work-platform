import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_expansion_title.dart' as custom;
import '../widgets/task/project_card_widget.dart';

const TS_TITLE =
    TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 1.2);
final InputDecoration TEXT_FIELD_DECORATION_2 = InputDecoration(
  fillColor: Colors.blueGrey.shade800,
  filled: true,
  contentPadding: const EdgeInsets.all(16),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: const Color.fromRGBO(39, 142, 165, 1)),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
  ),
);

class RoomScreen extends StatefulWidget {
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  var names = [
    'Ahmed Mohamed',
    'Mostafa Osama',
    'Mohamed Hesham',
    'Yousef Essam',
    'Mahmoud Yousef',
    'Beshoy Wagdy',
    'Habiba Sayed'
  ];

  bool switchProjects = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            children: [
              Spacer(
                flex: 5,
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: Colors.blueGrey.shade800,
                  hint: Padding(
                    padding: EdgeInsets.only(left: 12, right: 4),
                    child: Text(
                      'Room Name',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  items: <String>['A', 'B', 'C', 'D'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
              Spacer(
                flex: 1,
              ),
              IconButton(
                icon: Icon(
                  switchProjects ? Icons.copy : Icons.padding,
                  color: Colors.white,
                ),
                onPressed: () => setState(
                  () => switchProjects = !switchProjects,
                ),
              ),
            ],
          ),
        ),
        body: switchProjects ? roomWidget(context) : projectWidget(names));
  }
}

Widget roomWidget(context) {
  return ListView(
    children: [
      Padding(
        padding: EdgeInsets.only(top: 20),
        child: Center(
          child: Text(
            "Announcements",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
      Padding(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
        child: custom.ExpansionTile(
          headerBackgroundColor: Theme.of(context).appBarTheme.color,
          iconColor: Theme.of(context).accentIconTheme.color,
          title: Text(
            'Team 1',
            style: TS_TITLE,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 12, top: 5),
              child: Row(
                children: [
                  Text(
                    'Team 1',
                    style: TS_TITLE,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    DateFormat('d MMM, yyyy').format(DateTime.now()).toString(),
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, top: 3),
                    child: Text(
                      "11%",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget projectWidget(names) {
  return ListView(
    children: [
      Padding(
        padding: EdgeInsets.only(top: 20),
        child: Center(
          child: Text(
            "Projects",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: SizedBox(
            height: 130,
            width: 200,
            child: ProjectCard(
              teamNames: names,
              projectName: "GP Discussion",
              mangerName: "Ahmed",
              date: DateTime.now(),
            )),
      )
    ],
  );
}
