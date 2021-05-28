import 'package:flutter/material.dart';
import 'package:project/widgets/circular_checkBox.dart';

import 'package:provider/provider.dart';

import '../model/models.dart';
import '../model/share_package.dart';
import '../provider/data_constants.dart';
import '../provider/room_provider.dart';
import '../provider/team_provider.dart';
import '../widgets/task/add_teams_button.dart';
import '../widgets/task/description_widget.dart';
import '../widgets/task/editTextField_method.dart';
import '../widgets/custom_expansion_title.dart' as custom;
import '../constants.dart';
import 'auth/signUp1.dart';

class RoomSettings extends StatefulWidget {
  static const String route = 'RoomSettings';

  @override
  _RoomSettingsState createState() => _RoomSettingsState();
}

class _RoomSettingsState extends State<RoomSettings> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _teamName, _teamNameError = '', _teamDescription, _teamDescriptionError = '';
  bool _isLoading = false;

  List<Widget> users;

  @override
  Widget build(BuildContext context) {
    //final teamProvider = Provider.of<TeamProvider>(context);
    final roomProvider = Provider.of<RoomProvider>(context);
    _nameController.text = roomProvider.roomName;
    //TODO Performance : this list is generated when ever this screen is re-loaded, move it to initState()

    updateRoom({String name, String description}) async {
      setState(() => _isLoading = true);
      await handleRequest(() => roomProvider.updateRoom(name, description), context);
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
                  title: Text(roomProvider.roomName),
                  centerTitle: true,
                ),
                if (_isLoading) SizedBox(height: 5, child: LinearProgressIndicator())
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          SizedBox(
            height: 40,
            child: TextField(
                readOnly: true,
                controller: _nameController,
                decoration: TEXT_FIELD_DECORATION_2.copyWith(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  suffixIcon: IconButton(
                      splashRadius: 20,
                      splashColor: Color.fromRGBO(8, 77, 99, 1),
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                      onPressed: () async {
                        String newValue = await editTextField(context, _nameController.value.text);
                        if (newValue != null)
                          //if update successful
                          //TODO: add changes to provider
                          updateRoom(name: newValue);
                        //if(await updateTeam(name: newValue)) setState(() => _nameController.text = newValue);
                      }),
                )),
          ),
          Divider(height: 16, indent: 30, endIndent: 30),
          DescriptionWidget(roomProvider.roomDescription, onChanged: (desc) => updateRoom(description: desc)),
          Divider(height: 16, indent: 30, endIndent: 30),

          // Padding(
          //   padding: const EdgeInsets.only(left: 8, bottom: 6, top: 6),
          //   child: Row(
          //     children: [
          //       Text('Dual Agreement', style: TextStyle(fontSize: 17)),
          //       CircularCheckBox()
          //     ],
          //   ),
          // ),

          //Divider(height: 16, indent: 30, endIndent: 30),

          // if (_teamDescriptionError.isNotEmpty) errorMessage(_teamDescriptionError),
          // SizedBox(height: 48, child: FittedBox(child: addTeamsButton(hintText: "Create Team", onPressed: addTeam))),
          //
        ],
      ),
    );
  }
}
