import 'package:flutter/material.dart';
import 'package:project/provider/UserData.dart';
import 'package:project/screen/team_settings.dart';

import 'package:provider/provider.dart';

import '../provider/data_constants.dart';
import '../provider/room_provider.dart';
import '../widgets/task/description_widget.dart';
import '../widgets/task/editTextField_method.dart';
import '../constants.dart';

class RoomSettings extends StatefulWidget {
  static const String route = 'RoomSettings';

  @override
  _RoomSettingsState createState() => _RoomSettingsState();
}

class _RoomSettingsState extends State<RoomSettings> {
  final _nameController = TextEditingController();
  bool _isLoading = false;

  List<Widget> users;

  RoomProvider roomProvider;
  bool _isRoomCreator;
  bool _isInit = false;

  @override
  Widget build(BuildContext context) {
    if (!_isInit) {
      roomProvider = Provider.of<RoomProvider>(context);
      _isRoomCreator = roomProvider.isRoomCreator(
          Provider.of<UserData>(context, listen: false).userName);
      _isInit = true;
    }
    _nameController.text = roomProvider.roomName;

    updateRoom({String name, String description}) async {
      setState(() => _isLoading = true);
      await handleRequest(
          () => roomProvider.updateRoom(name, description), context);
      setState(() => _isLoading = false);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KAppBarHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(KAppBarRound), bottomRight: Radius.circular(KAppBarRound)),
          child: Container(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AppBar(
                  title: Text('Room Settings'),
                  centerTitle: true,
                ),
                if (_isLoading) SizedBox(height: 5, child: LinearProgressIndicator())
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        children: [
          EditableTextWidget(roomProvider.roomName,
              title: 'Room Name',
              onChanged: (desc) => updateRoom(description: desc),
              enableEdit: _isRoomCreator,
              maxLines: 1),
          Divider(height: 16, indent: 15, endIndent: 15),
          EditableTextWidget(
            roomProvider.roomDescription,
            onChanged: (desc) => updateRoom(description: desc),
            enableEdit: _isRoomCreator,
          ),
          Divider(height: 16, indent: 15, endIndent: 15),

          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 6, top: 6),
            child: Text('Created by',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),

          creatorTile(roomProvider.roomCreator, 'Room Manager')

          // Padding(
          //   padding: const EdgeInsets.only(left: 8, bottom: 6, top: 6),
          //   child: Row(
          //     children: [
          //       Text('Dual Agreement', style: TextStyle(fontSize: 17)),
          //       CircularCheckBox()
          //     ],
          //   ),
          // ),

          //Divider(height: 16, indent: 15, endIndent: 15),

          // if (_teamDescriptionError.isNotEmpty) errorMessage(_teamDescriptionError),
          // SizedBox(height: 48, child: FittedBox(child: addTeamsButton(hintText: "Create Team", onPressed: addTeam))),
          //
        ],
      ),
    );
  }
}
