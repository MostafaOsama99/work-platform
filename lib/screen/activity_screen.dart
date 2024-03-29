import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:project/constants.dart';
import 'package:file_picker/file_picker.dart';

import 'package:project/widgets/dateField_widget.dart';
import 'package:project/widgets/home/dropDownMenu.dart';
import 'dart:io';
import 'package:project/widgets/task/add_teams_button.dart';
import 'package:provider/provider.dart';

class Activity extends StatefulWidget {
  List<Widget> users;

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final TextEditingController _textEditingController = TextEditingController();
  var namess = [
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(KAppBarRound),
              bottomRight: Radius.circular(KAppBarRound)),
          child: AppBar(
            centerTitle: true,
            title: InkWell(
                onTap: () {

                  changeRoom(context, MediaQuery.of(context).size.height, []);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Activity", style: TextStyle(color: Colors.white)),

                  ],
                )),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(top: 20),
          //   child: NotificationViewer(),
          // ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 10, left: 5),
              child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, i) {
                    return commentsViewer(context,comments[i],names[i]);
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 12,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.66,
                  height: 42,
                  child: TextFormField(
                    textInputAction: TextInputAction.newline,
                    onFieldSubmitted: (_) {},
                    autofocus: false,
                    maxLines: 3,
                    controller: _textEditingController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Add Comment",
                      contentPadding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 5),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white54,
                      hintStyle: TextStyle(color: Colors.grey[700]),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.5),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
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

Widget commentsViewer(context,String text,String names) {
  return ListTile(
    contentPadding: EdgeInsets.only(right: 15, top: 15, left: 5),
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
          child: Row(
            children: [
              Text(
                names,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(
                flex: 5),
              Text(
                "by ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: DateField(
                  initialDate: DateTime.now(),
                  textStyle: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              )
            ],
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
                    text,
                    style: TextStyle(fontSize: 18, color: Colors.white),

                  ),
                ],
              ),
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: COLOR_BACKGROUND,
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
            ListTile(
              contentPadding: EdgeInsets.only(left: 5),
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
List <String> names =["Hesham" , "Mostafa Osama ", "Yousef" , "Mahmoud"];
List <String> comments =["Hey there what is the task today ? ", "it`s about Dsc Solution challenge !" ," WOW" , "i would like to join"];