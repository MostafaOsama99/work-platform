import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/constants.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:project/demoData.dart';
import 'package:project/provider/navbar.dart';
import 'package:project/screen/team_screen.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:project/widgets/dateField_widget.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_expansion_title.dart' as custom;

class ProjectScreen extends StatefulWidget {
  final startDate, endDate;
  final String description, mangerName, projectName;
  final attachments;
  final task;
  final teams;

  ProjectScreen(
      {this.startDate,
      this.endDate,
      this.description,
      this.attachments,
      this.task,
      this.mangerName,
      this.projectName,
      this.teams});

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  bool _expandDes = false;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color.fromRGBO(37, 36, 42, 1),
            accentColor: Color.fromRGBO(37, 36, 42, 1),
            colorScheme: ColorScheme.dark(),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            dialogBackgroundColor: Color.fromRGBO(37, 36, 42, 1),
          ),
          child: child,
        );
      },
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != startDate)
      setState(() {
        startDate = picked;
        print(startDate);
      });
  }

  _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color.fromRGBO(37, 36, 42, 1),
            accentColor: Color.fromRGBO(37, 36, 42, 1),
            colorScheme: ColorScheme.dark(),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            dialogBackgroundColor: Color.fromRGBO(37, 36, 42, 1),
          ),
          child: child,
        );
      },
      context: context,
      initialDate: endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != endDate)
      setState(() {
        endDate = picked;
        print(endDate);
      });
  }

  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _descriptionController.text = '''${widget.description}
    ''';
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 27,
        title: Text(
          "${widget.projectName}",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              children: [
                Text(
                  "${widget.mangerName}",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  width: 7,
                ),
                _userTileName("${widget.mangerName}")
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
        child: ListView(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5, bottom: 5),
                  child: Icon(
                    Icons.calendar_today_outlined,
                    size: 22,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Text(
                  "Date",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Spacer(
                  flex: 1,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text("from:   ",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15)),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 22),
                            child: DateField(initialDate: DateTime.now()))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("due:   ",
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                        DateField(
                          initialDate: DateTime.now(),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Description',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
            TextField(
              readOnly: true,
              autofocus: false,
              controller: _descriptionController,
              maxLines: _expandDes ? null : 4,
              onTap: () => setState(() => _expandDes = !_expandDes),
              style: TextStyle(color: Colors.white),
              decoration: TEXT_FIELD_DECORATION_2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 10),
              child: Text(
                "Teams",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 500,
              child: ListView.builder(
                  itemCount: widget.teams.length,
                  itemBuilder: (context, i) {
                    return teamCard(context, widget.teams[i].teamName,
                        widget.teams[i].tasks);
                  }),
            )
          ],
        ),
      ),
    );
  }
}

//TODO:Mohammed Hesham
Widget teamCard(context, String teamName, tasks) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: custom.ExpansionTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TeamScreen(
            teamName: teamName,
            tasks: tasks,
          );
        })).then((value) =>

            ///*** IMPORTANT ***
            ///make sure to remove scrollController that added by the called screen
            ///note: this method [removeController] re-shows the NavBar again
            Provider.of<NavBar>(context, listen: false).removeController());
      },
      iconColor: Colors.white,
      backgroundColor: COLOR_BACKGROUND,
      headerBackgroundColor: Theme.of(context).appBarTheme.color,
      title: Text(teamName, style: TS_TITLE),
      children: [
        ListView.separated(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          //disable scroll
          itemCount: tasks.length,
          itemBuilder: (context, i) {
            return subTaskWidget(tasks[i].name, tasks[i].datePlannedEnd,
                tasks[i].progress, context);
          },
          separatorBuilder: (BuildContext context, int index) =>
              Divider(indent: 15, endIndent: 15),
        )
      ],
    ),
  );
}

Widget subTaskWidget(String teamName, date, int percentage, context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image.asset(
        'assets/icons/task.png',
        height: 21,
        color: Colors.amber,
      ),
      SizedBox(width: 6),
      Padding(
        padding: const EdgeInsets.only(top: 1),
        child: SizedBox(
          height: 28,
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            teamName,
            overflow: TextOverflow.clip,
            style: TS_TITLE,
          ),
        ),
      ),
      Spacer(),
      Text(
        DateFormat('d MMM   ').format(date).toString(),
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
      Padding(
        padding: EdgeInsets.only(left: 5, top: 3),
        child: Text(
          "${percentage.toInt()}%",
          style: TextStyle(
              fontSize: 13, color: Colors.amber, fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}

Widget _userTileName(String name) {
  var lastLitter = name.indexOf(' ') + 1;
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 1, right: 1, bottom: 2),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CircleAvatar(
            radius: 14,
            child: Text(name[0] + name[lastLitter],
                style: TextStyle(fontSize: 13)),
            backgroundColor: Colors.yellow,
          ),
        ),
      ),
    ],
  );
}

Widget dateTime({selectedDate, double padding}) {
  return DateTimePicker(
    type: DateTimePickerType.dateTimeSeparate,
    dateMask: "EEEE, d MMM, yyyy",
    initialValue: DateTime.now().toString(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    dateLabelText: 'Date',
    timeLabelText: "Hour",
    selectableDayPredicate: (date) {
      // Disable weekend days to select from the calendar
      if (date.weekday == 6 || date.weekday == 7) {
        return false;
      }

      return true;
    },
    onChanged: (val) => print(val),
    validator: (val) {
      print(val);
      return null;
    },
    onSaved: (val) => print(val),
  );
}
