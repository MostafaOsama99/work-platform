import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/constants.dart';
import 'package:project/screen/team_screen.dart';

import '../widgets/custom_expansion_title.dart' as custom;


Widget teamCard (context,String teamName,tasks){

  return  Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: custom.ExpansionTile(
      onTap: () async {
        print('blaa');
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TeamScreen(
            teamName: teamName,
            tasks: tasks,
          );
        }));
        print('then called');
      },
      iconColor: Colors.teal,
      headerBackgroundColor: Theme.of(context).appBarTheme.color,
      title: Text(
        '${teamName} ',
        style: TS_TITLE,
      ),
      children: [
        LimitedBox(
          maxWidth: 500,
          maxHeight: 100,
          child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context,i){
                return subTaskWidget(tasks[i].name, tasks[i].datePlannedEnd, tasks[i].progress,context);
              }),
        )
      ],
    ),
  );
}

Widget subTaskWidget (String teamName,date,percentage,context){

  return   Padding(
    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: SizedBox(
            height: 28,
            width: MediaQuery.of(context).size.width*0.5,
            child: Text(

              teamName,overflow: TextOverflow.clip,
              style: TS_TITLE,


            ),
          ),
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
            "$percentage%",
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