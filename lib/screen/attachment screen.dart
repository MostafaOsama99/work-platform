import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project/dialogs/load_dialog.dart';
import 'package:project/draft_api_models/attachment.dart';
import 'package:project/provider/UserData.dart';
import 'package:project/provider/data_constants.dart';
import 'package:project/screen/navigation/app.dart';
import 'package:file_picker/file_picker.dart';
import 'package:project/widgets/NothingHere.dart';
import 'package:project/widgets/task/add_teams_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'dart:io';

class Attachment extends StatefulWidget {
  final int taskId;

  Attachment({this.taskId});

  @override
  _AttachmentState createState() => _AttachmentState();
}

class _AttachmentState extends State<Attachment>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  var pickedFile;
  final loadingKey = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  var file;
  var uploaded;
  List files = [];
  FirebaseStorage _storage = FirebaseStorage.instance;
  final _formKey = GlobalKey<FormState>();

  @override

  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    print("this is token $token");
    print("this is task id ${widget.taskId}");
    super.initState();
  }

  Future addAttachment() => post(
      KAddAttachment,
      json.encode({"name":files[0].path.split('/').last, "url": uploaded, "taskId": widget.taskId}));

  Future<String> uploadFile(File pickedFile, String folderName) async {
    StorageReference ref =
        _storage.ref().child("$folderName/${pickedFile.path.split('/').last}");
    StorageUploadTask uploadTask = ref.putFile(pickedFile);

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();

    Provider.of<UserData>(context, listen: false).setImage = dowurl;

    String url = dowurl.toString();
    print(url);
    return url;
  }

  Future getFile() async {
    pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc', 'zip', 'word', 'txt', 'image'],
        allowMultiple: true);

    setState(() {
      if (pickedFile != null) {
        files = pickedFile.paths.map((path) => File(path)).toList();
      } else {
        // User canceled the picker
        Navigator.of(loadingKey.currentContext).pop();
      }
    });
  }

  Future getImage() async {
    pickedFile = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    setState(() {
      if (pickedFile != null) {
        files = pickedFile.paths.map((path) => File(path)).toList();
      } else {
        // User canceled the picker
        Navigator.of(loadingKey.currentContext).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        key: scaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            print(_tabController.index);

            /// case 0 file case 1 links case 2 images
            _tabController.index == 0
                ? await getFile()
                : _tabController.index == 1
                    ? addLinkDialog(context, _formKey)
                    : getImage();

            /// dividerr-------------------------------

            _tabController.index == 1
                ? print("dialog opened")
                : showLoadingDialog(context, loadingKey);
             uploaded = await uploadFile(
                files[0], _tabController.index == 0 ? "files" : "image");
            addAttachment();
            Navigator.of(loadingKey.currentContext).pop();
            print(uploaded);
          },
          backgroundColor: COLOR_ACCENT,
          child: Icon(Icons.add),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(KAppBarRound),
                bottomRight: Radius.circular(KAppBarRound)),
            child: AppBar(
              backgroundColor: COLOR_SCAFFOLD,
              centerTitle: true,
              title: Text(
                "Recently Added",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 35,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: COLOR_BACKGROUND,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 150,
                        child: TabBar(
                          isScrollable: false,
                          indicatorPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 20),
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          //indicator: BoxDecoration(borderRadius: BorderRadius.circular(50), color: COLOR_ACCENT),
                          indicatorSize: TabBarIndicatorSize.label,

                          tabs: [
                            attachmentsTaps(
                                Icons.insert_drive_file, "Files", false),
                            attachmentsTaps(Icons.link_outlined, "Links", true),
                            attachmentsTaps(Icons.image, "Images", false)
                          ],
                          controller: _tabController,
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            tapViewList(
                                "Files", Icons.file_copy_sharp, "My Files",widget.taskId),
                            tapViewList(
                                "Hyper link ", Icons.link_outlined, "My Links",widget.taskId),
                            imagesTap(),
                          ],
                          controller: _tabController,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget attachmentsTaps(IconData icon, String tapName, bool isLink) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          radius: 30,
          child: isLink
              ? Transform.rotate(
                  angle: 3.14 / 4,
                  child: Icon(
                    Icons.link_outlined,
                    color: Colors.blue,
                    size: 28,
                  ),
                )
              : Icon(
                  icon,
                  color: Colors.blue,
                  size: 28,
                ),
          backgroundColor: COLOR_BACKGROUND,
        ),
        Text(
          tapName,
          style: TextStyle(fontSize: 18),
        )
      ],
    ),
    decoration: BoxDecoration(
        color: COLOR_SCAFFOLD, borderRadius: BorderRadius.circular(15)),
    width: 100,
    height: 120,
  );
}

Widget tapViewList(String tapName, IconData icon, String title,taskId) {
  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, bottom: 10),
        child: Text(
          tapName,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      Expanded(
        child: FutureBuilder(
            future: getAttachment(token, taskId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                    itemCount: snapshot.data.isEmpty ? 1 : snapshot.data.length,
                    itemBuilder: (context, i) {
                      return snapshot.data.isEmpty
                          ? Stack(children: [NothingHere(), ListView()])
                          : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 10),
                                  child: InkWell(
                                    onTap: (){
                                      launchInBrowser(snapshot.data[i].url);
                                    },
                                    child: Container(
                                      height: 60,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 80,
                                            child: CircleAvatar(
                                              radius: 22.5,
                                              child: Icon(
                                                icon,
                                                color: Colors.blue,
                                              ),
                                              backgroundColor: COLOR_BACKGROUND,
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(snapshot.data[i].name),
                                              // Padding(
                                              //   padding: const EdgeInsets.only(top: 5),
                                              //   child: Text(
                                              //     "created at:",
                                              //     style: const TextStyle(
                                              //         color: Colors.white54),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          color: COLOR_SCAFFOLD,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  ),
                                );
                              });
                    });
              } else
                return Center(child: CircularProgressIndicator());
            }),
      )
    ],
  );
}

Widget imagesTap() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
      child: Text(
        "Images",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    ),
    Expanded(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 5 / 3,
                crossAxisSpacing: 3,
                mainAxisSpacing: 10),
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: FullScreenWidget(
                  disposeLevel: DisposeLevel.Low,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }))
  ]);
}

addLinkDialog(context, formKey) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctxt) => StatefulBuilder(builder: (context, setState) {
            return new AlertDialog(
              title: Text("Add Link"),
              content: Container(
                width: 500,
                height: 120,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        onSaved: (value) => value,
                        validator: (value) {
                          if (value.isEmpty)
                            return "please enter link";
                          else
                            return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration:
                            TEXT_FIELD_DECORATION_2.copyWith(hintText: 'name'),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Row(
                        children: [
                          addTeamsButton(
                              hintText: "cancel",
                              onPressed: () async {
                                Navigator.pop(context);
                                // uploadFile(_image, "images");
                              }),
                          Spacer(
                            flex: 1,
                          ),
                          addTeamsButton(
                              hintText: "Save",
                              onPressed: () async {
                                formKey.currentState.validate();
                                // uploadFile(_image, "images");
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }));
}
