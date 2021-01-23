import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../widgets/custom_expansion_title.dart' as custom;

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

class ProjectScreen extends StatefulWidget {
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  bool _expandDes = false;

  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _descriptionController.text =
        '''this an example of a long description to test the three line in description text form field 
    this an example of a long description to test the three line in description text form field 
    this an example of a long description to test the three line in description text form field 
    this an example of a long description to test the three line in description text form field 
    ''';
    // TODO: implement initState
    super.initState();
  }

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            _userIcon("Mohamed"),
            Padding(
              padding: EdgeInsets.only(left: 7),
              child: Text("Name"),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              children: [
                Text(
                  "Manger",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  width: 7,
                ),
                _userTileName("Manger")
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
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
                        SizedBox(
                            height: 20,
                            width: 180,
                            child: dateTime(
                                selectedDate: selectedDate, padding: 10)),
                      ],
                    ),
                    Row(
                      children: [
                        Text("due:   ",
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                        SizedBox(
                            width: 180,
                            child: dateTime(
                                selectedDate: selectedDate, padding: 0)),
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
            FlatButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "attachment",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.attachment_outlined,
                      color: Colors.white,
                      size: 15,
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: custom.ExpansionTile(
                headerBackgroundColor: Theme.of(context).appBarTheme.color,
                iconColor: Theme.of(context).accentIconTheme.color,
                title: Text(
                  'Team 1',
                  style: TS_TITLE,
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
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
                          DateFormat('d MMM, yyyy')
                              .format(DateTime.now())
                              .toString(),
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
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
  return DateTimeField(
    style: TextStyle(fontSize: 15, color: Colors.white),
    decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: padding),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText:
            DateFormat('EEEE, d MMM, yyyy').format(selectedDate).toString(),
        hintStyle: TextStyle(color: Colors.white)),
    format: DateFormat('EEEE, d MMM, yyyy'),
    onChanged: (_) {},
    resetIcon: null,
    onShowPicker: (context, currentValue) {
      return showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          initialDate: currentValue ?? DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 10)));
    },
  );
}

Widget _userIcon(String name) {
  var lastLitter = name.indexOf(' ') + 1;
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 1, right: 1, bottom: 2),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(3) //                 <--- border radius here
                  ),
              color: Color.fromRGBO(13, 56, 120, 1),
              border: Border.all(color: Colors.grey)),
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: Text(
              name[0] + name[lastLitter],
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    ],
  );
}
