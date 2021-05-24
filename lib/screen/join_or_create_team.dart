import 'package:flutter/material.dart';
import 'package:project/provider/team_provider.dart';

import 'package:provider/provider.dart';

import '../provider/data_constants.dart';
import '../provider/room_provider.dart';
import '../constants.dart';
import '../widgets/custom_expansion_title.dart';
import '../widgets/task/add_teams_button.dart';
import '../widgets/custom_expansion_title.dart' as custom;

const TS_TITLE =
    TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 1.2);

const HEIGHT_PADDING = 16.0;

Widget errorMessage(String message) {
  return Padding(
    padding: EdgeInsets.only(left: 30, top: 8, bottom: 15),
    child: Text(
      message,
      style: TextStyle(color: Colors.red, height: 0),
      textAlign: TextAlign.start,
    ),
  );
}

class CreateRoomScreen extends StatefulWidget {
  ///managed by child class state [ExpansionTileState]
  static GlobalKey<ExpansionTileState> currentOpened;

  @override
  _CreateRoomScreenState createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  static final _formKey = GlobalKey<FormState>();
  String nameError = '';
  String descriptionError = '';
  String _name;
  String _description;
  String _codeError;
  final _codeController = TextEditingController();

  bool _isLoading = false;

  //key for each ExpansionTile
  // final _joinTeamKey =
  // GlobalKey<ExpansionTileState>(debugLabel: '_joinTeamKey');
  // final _createTeamKey =
  // GlobalKey<ExpansionTileState>(debugLabel: '_createTeamKey');
  // final _createRoomKey =
  // GlobalKey<ExpansionTileState>(debugLabel: '_createRoomKey');

  // @override
  // void initState() {
  //   //open join team by default
  //   Future.delayed(Duration(microseconds: 0))
  //       .then((value) => _joinTeamKey.currentState.handleTap());
  //   JoinTeamScreen.currentOpened = _joinTeamKey;
  //   super.initState();
  // }

  // onTileTap(tileKey){
  //   //check if current opened card is this card
  //   if (tileKey == JoinTeamScreen.currentOpened) return;
  //   //close current open
  //   JoinTeamScreen.currentOpened.currentState.handleTap();
  //   //save this card as current open
  //   JoinTeamScreen.currentOpened = tileKey;
  //   //open this card
  //   JoinTeamScreen.currentOpened.currentState.handleTap();
  // }

  @override
  Widget build(BuildContext context) {
    //TODO: device width may be added to provider & calculate only once
    final width = MediaQuery.of(context).size.width * 0.85;
    final roomProvider = Provider.of<RoomProvider>(context, listen: false);

    createTeam() async {
      if (!_formKey.currentState.validate()) return;

      //check that room name is unique for current user
      //TODO: get room creator to make this work
      // if (roomProvider.rooms.length > 0)
      //   roomProvider.rooms.forEach((room) {
      //     if (room.creator.userName ==
      //         roomProvider.roomCreator.userName)
      //       if (room.name == _name) {
      //       setState(() => nameError = 'this name is already taken');
      //       return;
      //     }
      //   });

      setState(() => _isLoading = true);
      _formKey.currentState.save();

      bool _isSuccess = await handleRequest(() => roomProvider.createRoom(_name, _description), context);

      //if success update user rooms
      if (_isSuccess) await roomProvider.getUserRooms();

      setState(() => _isLoading = false);
      print('is room created : $_isSuccess');
      //TODO: show alert dialog : room created successfully , on tap 'ok', pop twice
    }

    bool validateCode() {
      if (_codeController.value.text.isEmpty) {
        setState(() => _codeError = 'please enter team invitation code');
        return false;
      }
      setState(() => _codeError = '');
      return true;
    }

    joinTeam() async {
      if (!validateCode()) return;

      setState(() => _isLoading = true);

      var _isSuccess = await handleRequest(() => Provider.of<TeamProvider>(context, listen: false).joinTeam(_codeController.value.text.trim()), context);

      setState(() => _isLoading = false);
      print('join team : $_isSuccess');
      //TODO: notify user if he joined successfully, or not
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KAppBarHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(KAppBarRound), bottomLeft: Radius.circular(KAppBarRound)),
          child: AppBar(
            title: Text(
              "Create room / Join team",
              style: TS_TITLE,
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: HEIGHT_PADDING),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                            child: TextField(
                              controller: _codeController,
                              textInputAction: TextInputAction.done,
                              autofocus: false,
                              decoration: TEXT_FIELD_DECORATION_2.copyWith(
                                hintText: '#TeamCode',
                              ),
                            ),
                          ),
                          if (nameError.isNotEmpty) errorMessage(nameError),
                        ],
                      ),
                    ),
                    //SizedBox(width: 20),
                    Padding(padding: EdgeInsets.only(left: 15), child: addTeamsButton(hintText: "Join", onPressed: joinTeam))
                  ],
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 18),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(KAppBarRound),
                            topRight: Radius.circular(KAppBarRound),
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              COLOR_BACKGROUND,
                              COLOR_BACKGROUND.withOpacity(0.4)
                            ],
                            stops: [
                              0,
                              1
                            ])),
                    child: Text('Create Room', style: TS_TITLE)),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    height: 40,
                    width: width,
                    child: TextFormField(
                      onSaved: (value) => _name = value,
                      validator: (value) {
                        if (value.trim().length < 3)
                          setState(() => nameError = 'too short name');
                        else
                          setState(() => nameError = '');
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      decoration:
                          TEXT_FIELD_DECORATION_2.copyWith(hintText: 'name'),
                    ),
                  ),
                ),
                if (nameError.isNotEmpty) errorMessage(nameError),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: null,
                    onSaved: (value) => _description = value.trim(),
                    validator: (value) {
                      if (value.trim().length < 3) {
                        setState(() =>
                            descriptionError = 'Description field is required');
                        return '';
                      }
                      setState(() => descriptionError = "");
                      return null;
                    },
                    textInputAction: TextInputAction.newline,
                    autofocus: false,
                    decoration: TEXT_FIELD_DECORATION_2.copyWith(
                        hintText: 'Description'),
                  ),
                ),
                if (descriptionError.isNotEmpty) errorMessage(descriptionError),
                SizedBox(
                  height: 50,
                  child: FittedBox(
                    child: addTeamsButton(
                        hintText: "Create Room", onPressed: createTeam),
                  ),
                ),
              ],
            ),
            if (_isLoading)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey.withOpacity(0.1),
                child: Center(child: CircularProgressIndicator()),
              )
          ],
        ),
      ),
    );
  }
}

/*
* add team code
*
* SizedBox(height: HEIGHT_PADDING),
                SizedBox(
                  width: width,
                  height: 40,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {},
                    decoration: TEXT_FIELD_DECORATION_2.copyWith(
                      hintText: 'name',
                      errorStyle: TextStyle(height: 1),
                    ),
                  ),
                ),
                SizedBox(height: HEIGHT_PADDING),
                SizedBox(
                  width: width,
                  height: 40,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {},
                    decoration: TEXT_FIELD_DECORATION_2.copyWith(
                      hintText: 'Description',

                    ),
                  ),
                ),
                SizedBox(height: HEIGHT_PADDING),
                SizedBox(
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: COLOR_SCAFFOLD,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: DropdownButton<String>(
                            dropdownColor: Colors.blueGrey.shade800,
                            hint: Padding(
                              padding: EdgeInsets.only(left: 12, right: 4),
                              child: Text('select Room'),
                            ),
                            items: <String>['A', 'B', 'C', 'D']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(color: Colors.white)),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: COLOR_SCAFFOLD,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: DropdownButton<String>(
                            dropdownColor: Colors.blueGrey.shade800,
                            hint: Padding(
                              padding: EdgeInsets.only(left: 12, right: 4),
                              child: Text('select Team'),
                            ),
                            items: <String>['A', 'B', 'C', 'D']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(color: Colors.white)),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: HEIGHT_PADDING),
                addTeamsButton(hintText: "Create Team", onPressed: () {}),
*
* */
