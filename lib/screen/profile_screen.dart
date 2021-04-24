import 'package:project/widgets/task/add_teams_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:project/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image;
  String _email, _password, _confirmPassword, _name, _phone, _address;
  PickedFile pickedFile;
  final picker = ImagePicker();

  Future getGalleryImage() async {
    pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getCameraImage() async {
    pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        leading: Icon(
          Icons.arrow_back,
          size: 35,
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: Icon(
              Icons.settings,
              size: 35,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0,right: 15,left: 15),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                /// UNKNOWN Error in refactoring check Bottom of Screen
                child: FlatButton(
                    onPressed: () {
                      return showGeneralDialog(
                        context: context,
                        barrierColor: Colors.black12.withOpacity(0.6),
                        // background color
                        barrierDismissible: false,
                        // should dialog be dismissed when tapped outside
                        barrierLabel: "Dialog",
                        // label for barrier
                        transitionDuration: Duration(milliseconds: 400),
                        // how long it takes to popup dialog after button click
                        pageBuilder: (_, __, ___) {
                          // your widget implementation
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.35,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Spacer(
                                      flex: 2,
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        getCameraImage();
                                        Navigator.pop(context);
                                      },
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.grey[200],
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 50,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ),
                                    Spacer(
                                      flex: 2,
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        getGalleryImage();
                                        Navigator.pop(context);
                                      },
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.grey[200],
                                        child: Icon(
                                          Icons.image,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Spacer(
                                      flex: 2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: (_image != null)
                        ? CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            backgroundImage: FileImage(_image),
                            radius: height * 0.12,
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: Icon(
                              Icons.person,
                              color: Colors.grey[500],
                              size: 100,
                            ),
                            radius: height * 0.12,
                          )),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Center(
                  child: Text(
                "Name",
                style: TextStyle(fontSize: 25, color: Colors.white),
              )),
            ),
            Center(
                child: Text(
              "Job Title",
              style: TextStyle(fontSize: 25, color: Colors.white),
            )),

            Divider(color: Theme.of(context).accentColor,)


            ,
            textField(text: "Mohamed",icon: Icons.person),
            textField(text: "Mohamed@gmail.com",icon: Icons.email),
            textField(text: "01117460305",icon: Icons.phone),
            textField(text: "14/4/1999",icon: Icons.date_range),

            Padding(
              padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.3,right:  MediaQuery.of(context).size.width*0.3,top: 10),
              child: addTeamsButton(hintText: "Save",onPressed: (){}),
            ),
          ],
        ),
      ),
    );
  }
}

Widget textField ({String text,icon}){

  return Padding(
    padding: const EdgeInsets.only(top: 16,bottom: 5),
    child: TextFormField(
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (_) {},
    autofocus: false,
    initialValue: text,style: TextStyle(color: Colors.grey[800],fontSize: 20),
    decoration: TEXT_FIELD_DECORATION.copyWith(

    prefixIcon: Icon(icon,color: Colors.grey[800],)
    )),
  );
}


 showDialog ({context,function1,function2}){
  return showGeneralDialog(
    context: context,
    barrierColor: Colors.black12.withOpacity(0.6),
    // background color
    barrierDismissible: false,
    // should dialog be dismissed when tapped outside
    barrierLabel: "Dialog",
    // label for barrier
    transitionDuration: Duration(milliseconds: 400),
    // how long it takes to popup dialog after button click
    pageBuilder: (_, __, ___) {
      // your widget implementation
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(
                  flex: 2,
                ),
                FlatButton(
                  onPressed:()async{

                    return function1;
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    child: Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                FlatButton(
                  onPressed: ()async{
                    return function2;
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    child: Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Spacer(
                  flex: 2,
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}