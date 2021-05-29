import 'package:flutter/material.dart';
import 'package:project/provider/UserData.dart';

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

class TeamSettings extends StatefulWidget {
  @override
  _TeamSettingsState createState() => _TeamSettingsState();
}

class _TeamSettingsState extends State<TeamSettings> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _teamName, _teamNameError = '', _teamDescription, _teamDescriptionError = '';
  bool _isLoading = false;

  TeamProvider teamProvider;
  List<Widget> users;
  bool _isLeader;
  bool _isInit = false;

  @override
  Widget build(BuildContext context) {
    if (!_isInit) {
      teamProvider = Provider.of<TeamProvider>(context);
      _nameController.text = teamProvider.team.name;
      _isLeader = teamProvider.isLeader(Provider.of<UserData>(context, listen: false).userName);
      //TODO Performance : this list is generated when ever this screen is re-loaded, move it to initState()
      users = List.generate(teamProvider.team.members.length, (index) => _userTile(teamProvider.team.members[index]));
      _isInit = true;
    }

    addTeam() async {
      //seems like it takes some time
      int roomId = Provider.of<RoomProvider>(context, listen: false).roomId;
      if (!_formKey.currentState.validate()) return;

      _formKey.currentState.save();
      setState(() => _isLoading = true);
      await handleRequest(() => teamProvider.createTeam(roomId, _teamName, _teamDescription), context);
      setState(() => _isLoading = false);
    }

    updateTeam({String name, String description}) async {
      setState(() => _isLoading = true);
      await handleRequest(() => teamProvider.updateTeam(name, description), context);
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
                  leading: IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                      )),
                  title: Text(_isLeader ? 'Edit ${teamProvider.team.name}' : teamProvider.team.name),
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
          if (_isLeader)
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
                            updateTeam(name: newValue);
                          //if(await updateTeam(name: newValue)) setState(() => _nameController.text = newValue);
                        }),
                  )),
            ),
          if (_isLeader) Divider(height: 16, indent: 30, endIndent: 30),
          DescriptionWidget(teamProvider.team.description, onChanged: (desc) => updateTeam(description: desc), enableEdit: _isLeader),
          Divider(height: 16, indent: 30, endIndent: 30),

          /*
          * Invite Members
          */
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8.0, bottom: 4),
            child: Row(
              children: [
                Transform.rotate(
                    angle: 3.14 / 1.45,
                    child: Icon(
                      Icons.link_outlined,
                      size: 25,
                      color: Colors.white70,
                    )),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Invite Members to this team:', style: TextStyle(fontSize: 15)),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 16),
                      child: Text(teamProvider.team.code.substring(0, 15) + '...',
                          overflow: TextOverflow.fade, style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic, color: Colors.white70)),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 22,
                  icon: Icon(Icons.share),
                  onPressed: () {
                    setState(() {
                      onShare(context, "Your are invited to join my ${teamProvider.team.name} team \nKindly use this code to join: ${teamProvider.team.code}");
                    });
                  },
                  splashRadius: 18,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 6, top: 6),
            child: Text('Members', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          ),
          ...users,
          Divider(height: 16, indent: 30, endIndent: 30),

          /*
          * add team
          */

          Form(
            key: _formKey,
            child: custom.ExpansionTile(
              headerBackgroundColor: COLOR_ACCENT,
              backgroundColor: COLOR_BACKGROUND.withOpacity(0.8),
              iconColor: Colors.white,
              title: Text('Create Team below this', style: TS_TITLE),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      onSaved: (value) => _teamName = value,
                      validator: (value) {
                        if (value.trim().length < 3)
                          setState(() => _teamNameError = 'too short name');
                        else
                          setState(() => _teamNameError = '');
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: TEXT_FIELD_DECORATION_2.copyWith(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        hintText: 'Name',
                        errorStyle: TextStyle(height: 1),
                      ),
                    ),
                  ),
                ),
                if (_teamNameError.isNotEmpty) errorMessage(_teamNameError),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: TextFormField(
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    onSaved: (value) => _teamDescription = value.trim(),
                    validator: (value) {
                      if (value.trim().length < 3) {
                        setState(() => _teamDescriptionError = 'Description field is required');
                        return '';
                      }
                      setState(() => _teamDescriptionError = "");
                      return null;
                    },
                    decoration: TEXT_FIELD_DECORATION_2.copyWith(
                      hintText: 'Description',
                    ),
                  ),
                ),
                if (_teamDescriptionError.isNotEmpty) errorMessage(_teamDescriptionError),
                SizedBox(height: 48, child: FittedBox(child: addTeamsButton(hintText: "Create Team", onPressed: addTeam))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _userTile(User user) {
    var lastLitter = user.name.indexOf(' ') + 1;
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: COLOR_BACKGROUND,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 22,
              child: Text(user.name[0] + user.name[lastLitter], style: TextStyle(fontSize: 16)),
              backgroundColor: COLOR_ACCENT,
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Text(user.name, style: TextStyle(fontSize: 15)), Text('@${user.userName}', style: TextStyle(fontSize: 13, color: Colors.grey))],
            ),
            Spacer(),
            Text(user.jobTitle),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
