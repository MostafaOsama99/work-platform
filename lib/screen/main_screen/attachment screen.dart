import 'package:flutter/material.dart';
import 'package:project/screen/navigation/app.dart';

import '../../constants.dart';
import 'package:full_screen_image/full_screen_image.dart';

class Attachment extends StatefulWidget {
  @override
  _AttachmentState createState() => _AttachmentState();
}

class _AttachmentState extends State<Attachment> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: ClipRRect(

          borderRadius:
          BorderRadius.only(bottomLeft: Radius.circular(KAppBarRound), bottomRight: Radius.circular(KAppBarRound)),
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
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(
                      height: 150,
                      child: TabBar(
                        isScrollable: false,
                        indicatorPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                        //indicator: BoxDecoration(borderRadius: BorderRadius.circular(50), color: COLOR_ACCENT),
                        indicatorSize: TabBarIndicatorSize.label,

                        tabs: [
                         attachmentsTaps(Icons.insert_drive_file, "Files",false),
                        attachmentsTaps(Icons.link_outlined, "Links",true),
                          attachmentsTaps(Icons.image, "Images",false)
                        ],
                        controller: _tabController,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                         tapViewList("Files", Icons.file_copy_sharp, "My Files"),
                          tapViewList("Hyper link ", Icons.link_outlined, "My Links"),
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
    );
  }
}


Widget attachmentsTaps (IconData icon,String tapName,bool isLink){
  return   Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          radius: 30,
          child: isLink ? Transform.rotate(angle: 3.14 / 4, child: Icon(
            Icons.link_outlined,
            color: Colors.blue,
            size: 28,
          ),) : Icon(
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
    decoration: BoxDecoration(color: COLOR_SCAFFOLD, borderRadius: BorderRadius.circular(15)),
    width: 100,
    height: 120,
  );
}


Widget tapViewList (String tapName,IconData icon,String title){
  
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
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              "created at:",
                              style: const TextStyle(color: Colors.white54),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: COLOR_SCAFFOLD, borderRadius: BorderRadius.circular(15)),
                ),
              );
            }),
      )
    ],
  );
}

Widget imagesTap (){
  return  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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