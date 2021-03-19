import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:project/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:project/widgets/task/add_teams_button.dart';

class Activity extends StatefulWidget {
  List<Widget> users;

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {

  var names = [
    'Ahmed Mohamed',
    'Mostafa Osama',
    'Mohamed Hesham',
    'Yousef Essam',
    'Mahmoud Yousef',
    'Beshoy Wagdy',
    'Habiba Sayed'
  ];

  @override
  void initState() {
    super.initState();
   // widget.users =
     //   List.generate(names.length, (index) => _userTileName(names[index]));
    //names.forEach((name) => users.add(_userTile(name)));

  }

  File file;

  void getFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Activity",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

           Row(
             children: [
               Padding(
                 padding: const EdgeInsets.only(top: 15,bottom: 10,left: 15),
                 child: Text("Activity",style: TextStyle(fontSize: 18,),textAlign: TextAlign.left,),
               ),
               Spacer(flex: 5,)
             ],
           ),
          NotificationViewer(),
           Text("Comments",style: TextStyle(fontSize: 18,),),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 10,left: 5),
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, i) {
                    return commentsViewer(context);
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12,),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.66,
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) {},
                    autofocus: false,
                    decoration: TEXT_FIELD_DECORATION.copyWith(
                      hintText: 'Add comment',
                      prefixIcon: Icon(Icons.mode_comment_outlined,color: Colors.grey,),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: addTeamsButton(hintText: "Send", onPressed: () {}),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget commentsViewer(context) {
  return ListTile(
    contentPadding: EdgeInsets.only(right: 40, top: 10),
    leading: CircleAvatar(
      radius: 25,
      child: Icon(Icons.person),
      backgroundColor: Colors.grey[400],
    ),
    title: Column(
 crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "Name",
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            child: Padding(
              padding: EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 3),

                  ),
                  Text(
                    "this should be comment",
                    style: TextStyle(fontSize: 18,color: Colors.white),
                  ),
                ],
              ),
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color:COLOR_BACKGROUND,
              borderRadius: BorderRadius.circular(15),
            )),
      ],
    ),
  );
}





class NotificationViewer extends StatelessWidget {
  final message, image, name;

  NotificationViewer({this.name, this.image, this.message});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 95,
        child: Column(
          children: <Widget>[
            ListTile(contentPadding: EdgeInsets.only(left: 5),
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 30,
                child: Icon(Icons.person),
              ),
              title: Text("name",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text(
                  "this user assigned task for you",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
              trailing: Text(
                '',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3),
              child: Divider(
                endIndent: 10,
                indent: 10,
                thickness: 1,
                color: Colors.grey[500],
              ),
            )
          ],
        ));
  }
}
