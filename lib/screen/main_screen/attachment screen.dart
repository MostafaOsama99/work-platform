import 'package:flutter/material.dart';

import '../../constants.dart';
import 'package:full_screen_image/full_screen_image.dart';

class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child:
                  SizedBox(height: 50, child: Icon(Icons.arrow_back, size: 30)),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: COLOR_BACKGROUND,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 30, bottom: 20),
                      child: Text(
                        "Recently Add",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: TabBar(
                        isScrollable: true,
                        indicatorPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: COLOR_ACCENT),
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius: 30,

                                  child: Icon(
                                    Icons.insert_drive_file,
                                    color: Colors.blue,
                                    size: 28,
                                  ),
                                  backgroundColor: COLOR_BACKGROUND,
                                ),
                                Text(
                                  "Files",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: COLOR_SCAFFOLD,
                                borderRadius: BorderRadius.circular(15)),
                            width: 120,
                            height: 150,
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius: 30,

                                  child: Icon(
                                    Icons.insert_drive_file,
                                    color: Colors.blue,
                                    size: 28,
                                  ),
                                  backgroundColor: COLOR_BACKGROUND,
                                ),
                                Text(
                                  "Files",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: COLOR_SCAFFOLD,
                                borderRadius: BorderRadius.circular(15)),
                            width: 120,
                            height: 150,
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius: 30,

                                  child: Icon(
                                    Icons.insert_drive_file,
                                    color: Colors.blue,
                                    size: 28,
                                  ),
                                  backgroundColor: COLOR_BACKGROUND,
                                ),
                                Text(
                                  "Files",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: COLOR_SCAFFOLD,
                                borderRadius: BorderRadius.circular(15)),
                            width: 120,
                            height: 150,
                          ),
                        ],
                        controller: _tabController,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 20, bottom: 10),
                                child: Text(
                                  "Folders",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: 5,
                                    itemBuilder: (context, i) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, top: 10),
                                        child: Container(
                                          height: 100,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                radius: 30,
                                                child: Icon(
                                                  Icons.file_copy_sharp,
                                                  color: Colors.blue,
                                                ),
                                                backgroundColor:
                                                    COLOR_BACKGROUND,
                                              ),
                                              title: Text(
                                                "My Files",
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text("Created at"),
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color: COLOR_SCAFFOLD,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 20, bottom: 10),
                                child: Text(
                                  "Folders",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: 5,
                                    itemBuilder: (context, i) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, top: 10),
                                        child: Container(
                                          height: 100,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                radius: 30,
                                                child: Icon(
                                                  Icons.file_copy_sharp,
                                                  color: COLOR_ACCENT,
                                                ),
                                                backgroundColor: Colors.white,
                                              ),
                                              title: Text(
                                                "My Files",
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text("Created at"),
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(15, 15, 45, 1),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, bottom: 20),
                                  child: Text(
                                    "Images",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                    child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                childAspectRatio: 5 / 3,
                                                crossAxisSpacing: 3,
                                                mainAxisSpacing: 10),
                                        itemBuilder: (context, i) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: FullScreenWidget(
                                              disposeLevel: DisposeLevel.Low,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Image.network(
                                                  "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          );
                                        }))
                              ]),
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

/**  Container(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    CircleAvatar(
    radius: 30,
    child: Icon(
    Icons.insert_drive_file,color: Colors.blue,size: 28,
    ),
    backgroundColor: COLOR_SCAFFOLD,
    )
    , Text("Files",style: TextStyle(fontSize: 20),)
    ],
    ),
    decoration: BoxDecoration(
    color: Color.fromRGBO(15, 15, 45, 1),
    borderRadius: BorderRadius.circular(15)
    ),


    width: 120,
    height: 150,
    ) **/
