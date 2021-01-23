import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:project/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:project/widgets/task/add_teams_button.dart';
import 'package:project/model/task.dart';
import 'package:project/widgets/task/task_card.dart';
import 'package:flutter_filereader/flutter_filereader.dart';

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

// ignore: must_be_immutable
class SingleTask extends StatefulWidget {
  List<Widget> users;

  @override
  _SingleTaskState createState() => _SingleTaskState();
}

class _SingleTaskState extends State<SingleTask> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _expandDes = false;
  var names = [
    'Mostafa Osama',
    'Mohamed Hesham',
    'Yousef Essam',
    'Mahmoud Yousef',
    'Beshoy Wagdy',
    'Habiba Sayed'
    'Ahmed Mohamed',
  ];

  @override
  void initState() {
    super.initState();
    widget.users =
        List.generate(names.length, (index) => _userTileName(names[index]));
    //names.forEach((name) => users.add(_userTile(name)));
    _nameController.text = 'Team Name';
    _descriptionController.text =
        '''this an example of a long description to test the three line in description text form field 
    this an example of a long description to test the three line in description text form field 
    this an example of a long description to test the three line in description text form field 
    this an example of a long description to test the three line in description text form field 
    ''';
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
    final height = MediaQuery.of(context).size.height;

    //TODO: subtract bottomNavigationBar height
    final bodyHeight =
        height - MediaQuery.of(context).padding.top - HEIGHT_APPBAR;

    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(HEIGHT_APPBAR),
        child: AppBar(
          title: Text(
            "Team name",
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            Row(
              children: [
                names.length > 3
                    ? Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, right: 3),
                            child: InkWell(
                              onTap: () {
                                _viewAllTeams(context, height);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: Text(
                                  "+${names.length - 3}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 145,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (context, i) {
                                  return _userTileName("${names[i]}");
                                }),
                          ),
                        ],
                      )
                    : SizedBox(
                        width: 185,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, i) {
                              return _userTileName("${names[i]}");
                            }),
                      )
              ],
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0, bottom: 2, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Description',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                IconButton(
                    splashRadius: 20,
                    splashColor: Color.fromRGBO(8, 77, 99, 1),
                    icon: Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _edit(context, _descriptionController, maxLines: 4);
                      });
                    }),
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
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: Text(
              "Check points",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 300,

            //TODO: make list dynamic
            child: Tasks([
              Task(
                progress: 70,
                description: 'description',
                name: 'Task name',
                datePlannedEnd: DateTime.now().add(Duration(days: 15)),
                //  checkPoints: {'Finish design': true, 'Animation':false, 'Task card':false}
              ),
              Task(
                  progress: 30,
                  description: 'description',
                  name: 'Task name',
                  datePlannedEnd: DateTime.now())
            ]),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, left: 0),
                child: Text('Attachments',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              Spacer(
                flex: 2,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, right: 12),
                child: IconButton(
                    splashRadius: 20,
                    splashColor: Color.fromRGBO(8, 77, 99, 1),
                    icon: Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {});
                    }),
              ),
            ],
          ),
          FlatButton(
              onPressed: () {
                getFile();
                print("this is path ${file.path}");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "add",
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
            padding: EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Activity',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, top: 10),
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, i) {
                          return commentsViewer();
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
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
                            prefixIcon: Icon(Icons.mode_comment_outlined),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child:
                            addTeamsButton(hintText: "Send", onPressed: () {}),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _viewAllTeams(context, height) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 500),
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.black.withOpacity(0.4),
      pageBuilder: (context, _, __) {
        return Column(
          //so important to use column !!
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              //so important to use Card !!
              child: Card(
                color: Theme.of(context).backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                child: Theme(
                  data: Theme.of(context),
                  child: LimitedBox(
                    maxHeight: height * 0.35,
                    maxWidth: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25)),
                      child: LimitedBox(
                        maxHeight: 500,
                        maxWidth: 200,
                        child: ListView.builder(
                            itemCount: names.length,
                            itemBuilder: (context, i) {
                              return _userTile(names[i]);
                            }),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ).drive(Tween<Offset>(
            begin: Offset(0, -1),
            end: Offset(0, (HEIGHT_APPBAR * 1.4) / height),
          )),
          child: child,
        );
      },
    );
  }
}

Widget commentsViewer() {
  return ListTile(
    contentPadding: EdgeInsets.only(right: 40, top: 10),
    leading: CircleAvatar(
      radius: 25,
      child: Icon(Icons.person),
      backgroundColor: Colors.grey[400],
    ),
    title: (Container(
        child: Padding(
          padding: EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Text(
                  "Name",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "this should be comment",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        width: 20,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
        ))),
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
            radius: 22,
            child: Text(name[0] + name[lastLitter],
                style: TextStyle(fontSize: 16)),
            backgroundColor: Colors.yellow,
          ),
        ),
      ),
    ],
  );
}

_edit(BuildContext context, TextEditingController controller,
    {int maxLines = 1}) {
  final _formKey = GlobalKey<FormState>();

  String _validate(String value) {
    if (value.length <= 3) return 'too short name !';
    return null;
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.of(context).pop();
    }
  }

  return showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      backgroundColor: Color.fromRGBO(8, 77, 99, 1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      builder: (BuildContext context) {
        return SizedBox(
          //size of keyboard + padding + button + TextField
          height: MediaQuery.of(context).viewInsets.bottom +
              35 +
              60 +
              13 +
              maxLines * 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      autofocus: true,
                      maxLines: maxLines,
                      textInputAction: maxLines == 1
                          ? TextInputAction.done
                          : TextInputAction.newline,
                      onSaved: (value) {
                        controller.text = value;
                      },
                      initialValue: controller.value.text,
                      decoration: TEXT_FIELD_DECORATION.copyWith(
                          errorStyle: TextStyle(height: 1),
                          contentPadding: const EdgeInsets.all(12),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: _validate,
                      onFieldSubmitted: (_) => _submit(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                          minWidth: 100,
                          height: 35,
                          color: Colors.red,
                          child: Center(child: Icon(Icons.cancel)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      MaterialButton(
                          minWidth: 100,
                          height: 35,
                          color: Colors.green,
                          child: Center(child: Icon(Icons.done)),
                          onPressed: _submit)
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}

Widget _userTile(String name) {
  var lastLitter = name.indexOf(' ') + 1;
  return GestureDetector(
    onLongPress: () {
      //TODO: show popup menu
      //https://stackoverflow.com/questions/54300081/flutter-popupmenu-on-long-press
      //or use 3 dot drop down menu
      //https://stackoverflow.com/questions/58144948/easiest-way-to-add-3-dot-pop-up-menu-appbar-in-flutter
    },
    child: Container(
      height: 55,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade800.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 22,
            child: Text(name[0] + name[lastLitter],
                style: TextStyle(fontSize: 16)),
            backgroundColor: Colors.yellow,
          ),
          SizedBox(width: 12),
          Flexible(
              flex: 5,
              child: Text(name,
                  style: TextStyle(color: Colors.white, fontSize: 15)))
        ],
      ),
    ),
  );
}

class Tasks extends StatelessWidget {
  final List<Task> tasks;

  const Tasks(this.tasks);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // scrollDirection: Axis.horizontal,
        itemCount: tasks.length,
        itemBuilder: (context, i) => TaskCard(tasks[i]));
  }
}
