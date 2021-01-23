import 'dart:ui';
import 'package:project/widgets/task/project_card_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';
import 'package:project/widgets/task/custom_expansion_title_without_changes.dart'
    as custom1;

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

  var isSwitched = 0;

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
              SizedBox(
                height: 35,
                child: ToggleSwitch(
                  minWidth: 65,
                  cornerRadius: 20.0,
                  activeBgColor:
                      (isSwitched == 0) ? Colors.cyan[700] : Colors.grey,
                  activeFgColor: Colors.white,
                  inactiveBgColor:
                      (isSwitched == 0) ? Colors.grey : Colors.cyan[700],
                  inactiveFgColor: Colors.white,
                  labels: ['room', 'projects'],
                  fontSize: 12,
                  onToggle: (index) {
                    setState(() {
                      isSwitched = index;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        body: (isSwitched == 0) ? roomWidget(context) : projectWidget(names));
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
        child: custom1.ExpansionTile(
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
            child: CardWidget(
              teamNames: names,
              projectName: "GP Discussion",
              mangerName: "Ahmed",
              date: DateTime.now(),
            )),
      )
    ],
  );
}
