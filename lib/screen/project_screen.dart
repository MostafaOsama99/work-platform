import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/constants.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:project/demoData.dart';
import 'package:project/screen/team_screen.dart';

import '../widgets/custom_expansion_title.dart' as custom;

class ProjectScreen extends StatefulWidget{
final startDate,endDate;
final String description,mangerName,projectName;
final attachments;
final task;
final teams;
ProjectScreen({this.startDate,this.endDate,this.description,this.attachments,this.task,this.mangerName,this.projectName,this.teams});
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  bool _expandDes = false;

  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _descriptionController.text =
    '''${widget.description}
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
        leadingWidth: 27,
        title: Text("${widget.projectName}",style: TextStyle(fontSize: 18),),
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
                                selectedDate: widget.startDate, padding: 10)),
                      ],
                    ),
                    Row(
                      children: [
                        Text("due:   ",
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                        SizedBox(
                            width: 180,
                            child: dateTime(
                                selectedDate: widget.endDate, padding: 0)),
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
           SizedBox(
             height: 500,
             child: ListView.builder(
                 itemCount: widget.teams.length,
                 itemBuilder: (context,i){

               return teamCard(context, widget.teams[i].teamName,widget.teams[i].tasks);
             }),
           )
          ],
        ),
      ),
    );
  }
}

Widget teamCard (context,String teamName,tasks){

  return  Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: custom.ExpansionTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return TeamScreen(teamName: teamName,tasks: tasks,);
        }));
      },
      iconColor: Colors.teal,
      headerBackgroundColor: Theme.of(context).appBarTheme.color,
      title: Text(
        '${teamName}',
        style: TS_TITLE,
      ),
      children: [
      LimitedBox(
        maxWidth: 500,
        maxHeight: 100,
        child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context,i){

          return subTaskWidget(tasks[i].name, DateTime.now(), "10");
        }),
      )
      ],
    ),
  );
}

Widget subTaskWidget (String teamName,date,percentage){

  return   Padding(
    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
    child: Row(
      children: [
        Text(
          teamName,
          style: TS_TITLE,
        ),
        Spacer(
          flex: 1,
        ),
        Text(
          DateFormat('d MMM, yyyy')
              .format(date)
              .toString(),
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5, top: 3),
          child: Text(
            percentage,
            style: TextStyle(
                fontSize: 13,
                color: Colors.amber,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    ),
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

