import 'package:date_time_picker/date_time_picker.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:project/dialogs/load_dialog.dart';
import 'package:project/widgets/task/add_teams_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:project/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:project/provider/UserData.dart';

import 'auth/signUp1.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  FirebaseStorage _storage = FirebaseStorage.instance;
  File _image;
  String _email, _password, _confirmPassword, _name, _phone, _address;
  PickedFile pickedFile;
  final picker = ImagePicker();

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }

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

  Future<String> uploadFile(var imageFile,String folderName) async {
    StorageReference ref =
        _storage.ref().child("$folderName/${_image.path.split('/').last}");
    StorageUploadTask uploadTask = ref.putFile(imageFile);
    loadDialog(context);
    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    Navigator.pop(context);
    String url = dowurl.toString();
    print(url);
    return url;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context, listen: false);

    var height = MediaQuery.of(context).size.height;
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
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Profile();
                      }));
                    },
                    child:
                        Text("Profile", style: TextStyle(color: Colors.white))),
              ],
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 0, right: 15, left: 15),
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
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
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
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Center(
                    child: Text(
                  user.userName.toString(),
                  style: TextStyle(fontSize: 25, color: Colors.white),
                )),
              ),
              Center(
                  child: Text(
                user.jobTitle.toString(),
                style: TextStyle(fontSize: 25, color: Colors.white),
              )),

              Divider(
                color: Theme.of(context).accentColor,
              ),
              textField(
                  text: user.userName.toString(),
                  icon: Icons.person,
                  onSaved: (value) => user.setUserName = value,
                  validator: (value) {
                    if (value.isEmpty)
                      return "Please enter your name";
                    else if (value.length < 3)
                      return "name must be more than 3 digit";
                    else
                      return null;
                  }),
              textField(
                  text: user.mail.toString(),
                  icon: Icons.email,
                  onSaved: (value) => user.setMail = value,
                  validator: (value) {
                    if (value.isEmpty)
                      return "Please enter your E-mail";
                    else if (!isEmail(value))
                      return "Please enter valid mail";
                    else
                      return null;
                  }),
              textField(
                  text: user.mobile.toString(),
                  icon: Icons.phone,
                  onSaved: (value) => user.setMobile = value,
                  validator: (value) {
                    if (value.length != 11) return "incorrect phone number";
                    try {
                      int.parse(value);
                    } catch (e) {
                      return "incorrect phone number";
                    }
                    return null;
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  child: DateTimeField(
                    initialValue: user.birthDate,
                    style: TS_Style,
                    decoration: TEXT_FIELD_DECORATION1.copyWith(
                      hintText: 'birth date',
                      prefixIcon:
                          Icon(Icons.date_range, color: COLOR_BACKGROUND),
                    ),
                    onSaved: (value) => user.setBirthDate = value,
                    validator: (value) {
                      if (value == null)
                        return "Please enter your date of birth";
                      else
                        return null;
                    },
                    format: DateFormat("dd/MM/yyyy"),
                    resetIcon: null,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ??
                              DateTime.now().subtract(Duration(days: 16 * 365)),
                          lastDate: DateTime.now());
                    },
                  ),
                ),
              ),
              // textField(text:DateFormat('dd/MM/yyy').format(user.birthDate).toString(),icon: Icons.date_range,validator: (value){
              //   if (value.isEmpty)
              //     return "Please enter your date of birth";
              //   else
              //     return null;
              // }),

              Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.3,
                      right: MediaQuery.of(context).size.width * 0.3,
                      top: 10),
                  child: addTeamsButton(
                      hintText: "Save",
                      onPressed: () async {
                        //     StorageReference reference = _storage.ref().child("images/${_image.path.split('/').last}");
                        //
                        //     //Upload the file to firebase
                        //     StorageUploadTask uploadTask = reference.putFile(_image);
                        //     var url =await (await uploadTask.onComplete).ref.getDownloadURL();
                        // var    rurl = url.toString();
                        //     print(rurl);
                        if (_formKey.currentState.validate()) {
                          print("");
                        }

                        uploadFile(_image,"images");
                      })),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textField({String text, icon, Function validator, Function onSaved}) {
  return Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 5),
    child: Container(
      child: TextFormField(
          validator: validator,
          onSaved: onSaved,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) {},
          autofocus: false,
          initialValue: text,
          style: TextStyle(color: Colors.grey[800], fontSize: 20),
          decoration: TEXT_FIELD_DECORATION1.copyWith(
              prefixIcon: Icon(
            icon,
            color: Colors.grey[800],
          ))),
    ),
  );
}

showDialog({context, function1, function2}) {
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                  onPressed: () async {
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
                  onPressed: () async {
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
