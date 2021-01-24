import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/constants.dart';
import '../widgets/custom_expansion_title.dart' as custom;
import '../widgets/task/project_card_widget.dart';
import 'join_or_create_team.dart';
import 'package:project/demoData.dart';
import 'package:project/widgets/home/dropDownMenu.dart';

class RoomScreen extends StatefulWidget {
  final List<List> teams;
  RoomScreen({this.teams=const []});
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
                flex: 2,
              ),
             InkWell(
                 onTap: (){
                   changeTeam(context,MediaQuery.of(context).size.height,widget.teams);
                 },
                 child: Row(children: [
                   Text("Room",style: TextStyle(color: Colors.black),),
                   Icon(Icons.arrow_drop_down,color: Colors.grey[700],)

                 ],)),
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
        body: switchProjects ? roomWidget(context) : projectWidget(names,context));
  }

}

Widget roomWidget(context) {
  return ListView(
    children: [
      Padding(
        padding: EdgeInsets.only(top: 25,left: 28),
        child: Text(
          "Teams",
          style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
        child: custom.ExpansionTile(
          iconColor: Colors.teal,
          headerBackgroundColor: Theme.of(context).appBarTheme.color,
          title: Text(
            'Team 1',style: TextStyle(color: Colors.white),

          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 12, top: 5),
              child: Row(
                children: [
                  Text(
                    'Team 1',style: TextStyle(color: Colors.white),
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

      Divider(color: Colors.teal,
      indent: 15,
        endIndent: 15,
      )

      ,Padding(
        padding:
        const EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
        child: custom.ExpansionTile(
          headerBackgroundColor: Theme.of(context).appBarTheme.color,
          iconColor: Colors.teal,
          title: Text(
            'Team 1',style: TextStyle(color: Colors.white),

          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 12, top: 5),
              child: Row(
                children: [
                  Text(
                    'Team 1',style: TextStyle(color: Colors.white),

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

Widget projectWidget(names,context) {
  return ListView(
    children: [
      Padding(
        padding: EdgeInsets.only(top: 20,left: 25),
        child: Text(
          "Projects",
          style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: LimitedBox(
          maxHeight: MediaQuery.of(context).size.height,
            maxWidth: 200,
            child: ListView.builder(
                itemCount: project.length,
                itemBuilder: (context,i){
              return SizedBox(
                height: 130,
                width: 200,
                child: ProjectCard(
                 endDate: project[i].endDate,
                  projectName: project[i].projectName,
                  mangerName: project[i].mangerName,
                  teamNames: project[i].teams[i].teamName,
                    startDate: project[i].startDate,
                    description: project[i].description,
                   teams: project[i].teams,
                ),
              );
            })),
      )
    ],
  );

}

