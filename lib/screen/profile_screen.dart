import 'dart:convert';


import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:project/dialogs/load_dialog.dart';
import 'package:project/provider/data_constants.dart';
import 'package:project/widgets/profile_screenn/select_image_class.dart';
import 'package:project/widgets/task/add_teams_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:project/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:project/provider/UserData.dart';
import 'package:project/provider/data_constants.dart';
import 'auth/signUp1.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();

  FirebaseStorage _storage = FirebaseStorage.instance;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  File _image;
  String _email, _password, _confirmPassword, _name, _phone, _address;

  Future<void> updateProfile() => put(
      KUpdateUser,
      json.encode({
        "imageUrl": Provider.of<UserData>(context, listen: false).image,
        "name": Provider.of<UserData>(context, listen: false).userName,
        "email": Provider.of<UserData>(context, listen: false).mail,
        "phoneNumber": Provider.of<UserData>(context, listen: false).mobile,
        "jobTitle": Provider.of<UserData>(context, listen: false).jobTitle,
      }));

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }

  Future<String> uploadFile(var imageFile, String folderName) async {
    StorageReference ref =
    _storage.ref().child("$folderName/${_image.path.split('/').last}");
    StorageUploadTask uploadTask = ref.putFile(imageFile);

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();

    Provider.of<UserData>(context, listen: false).setImage = dowurl;

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
    dialog() async {
      final loadingKey = GlobalKey();
      var result = await showDialog(
          context: context,
          // barrierColor: Colors.black12.withOpacity(0.6),
          // // background color
          // barrierDismissible: false,
          // // should dialog be dismissed when tapped outside
          // barrierLabel: "Dialog",
          // // label for barrier
          // transitionDuration: Duration(milliseconds: 400),
          // // how long it takes to popup dialog after button click
          // pageBuilder: (_, __, ___) {
          // your widget implementation

          builder: (_) {
            return SelectImage();
          });
      print(result);
      if (result != null) {
        //call api
        _image = result;
        showLoadingDialog(context, loadingKey);
        String uploadedImageUrl = await uploadFile(_image, "images");
        print(uploadedImageUrl);
        print("this is token $token");
        var handleResult =
        await handleRequest(updateProfile, scaffoldKey.currentContext);
        if (handleResult) {
          setState(() {
            _image = result;
          });
        }
        Navigator.of(loadingKey.currentContext).pop();
      } else
        print('error');
    }

    var height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      key: scaffoldKey,

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
                Text("Profile", style: TextStyle(color: Colors.white)),
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
                  child: FlatButton(
                      onPressed: () {
                        dialog();
                      },
                      child: (_image == null)
                          ? CircleAvatar(
                        backgroundImage: NetworkImage(Provider.of<UserData>(context, listen: false).image==null?"":Provider.of<UserData>(context, listen: false).image),
                        backgroundColor: Colors.grey[200],
                        child:Provider.of<UserData>(context, listen: false).image==null?  Icon(
                          Icons.person,
                          color: Colors.grey[500],
                          size: 100,
                        ) : Text(""),
                        radius: height * 0.12,
                      )
                          : CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        backgroundImage: FileImage(_image),
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
                          _formKey.currentState.save();

                          var handleResult =
                          await handleRequest(updateProfile, scaffoldKey.currentContext);

                          showSnackBar("Data Updated Successfully", context);

                        }

                        // uploadFile(_image, "images");
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
