
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/custom_expansion_title.dart';
import 'package:project/widgets/task/add_teams_button.dart';
import '../widgets/custom_expansion_title.dart' as custom;

const TS_TITLE =
TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 1.2);

const HEIGHT_PADDING = 16.0;

// ignore: non_constant_identifier_names
final TEXT_FIELD_DECORATION = InputDecoration(
  filled: true,
  fillColor: Colors.white,

  ///use it in case => theme brightness: Brightness.dark,
  //hintStyle: TextStyle(color: Colors.grey),
  errorStyle: TextStyle(height: 0,color: Colors.black),
  contentPadding: const EdgeInsets.only(left: 20, bottom: 0, top: 0),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
    ),
    borderRadius: BorderRadius.circular(20),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(20),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 3),
    borderRadius: BorderRadius.circular(20),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 3),
    borderRadius: BorderRadius.circular(20),
  ),
  // disabledBorder: OutlineInputBorder(
  //   borderSide: BorderSide(color: Colors.white),
  //   borderRadius: BorderRadius.circular(25.7),
  // ),
);

class JoinTeamScreen extends StatefulWidget {
  ///managed by child class state [ExpansionTileState]
  static GlobalKey<ExpansionTileState> currentOpened;

  @override
  _JoinTeamScreenState createState() => _JoinTeamScreenState();
}

class _JoinTeamScreenState extends State<JoinTeamScreen> {
  static final _formKey = GlobalKey<FormState>();
  String nameError="";
  String descriptionError="";
  //key for each ExpansionTile
  final _joinTeamKey =
  GlobalKey<ExpansionTileState>(debugLabel: '_joinTeamKey');
  final _createTeamKey =
  GlobalKey<ExpansionTileState>(debugLabel: '_createTeamKey');
  final _createRoomKey =
  GlobalKey<ExpansionTileState>(debugLabel: '_createRoomKey');

  @override
  void initState() {
    //open join team by default
    Future.delayed(Duration(microseconds: 0))
        .then((value) => _joinTeamKey.currentState.handleTap());
    JoinTeamScreen.currentOpened = _joinTeamKey;
    super.initState();
  }

  onTileTap(tileKey){
    //check if current opened card is this card
    if (tileKey == JoinTeamScreen.currentOpened) return;
    //close current open
    JoinTeamScreen.currentOpened.currentState.handleTap();
    //save this card as current open
    JoinTeamScreen.currentOpened = tileKey;
    //open this card
    JoinTeamScreen.currentOpened.currentState.handleTap();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: device width may be added to provider & calculate only once
    final width = MediaQuery.of(context).size.width * 0.85;
    String hintText = 'Description';

    return Scaffold(
      appBar: AppBar(
        title: Text("Join or create team"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          children: [
            custom.ExpansionTile(
              key: _joinTeamKey,
              onTap: () => onTileTap(_joinTeamKey),
              backgroundColor: COLOR_BACKGROUND,
              onIconPressed: () => onTileTap(_joinTeamKey),
              headerBackgroundColor: Theme.of(context).appBarTheme.color,
              iconColor: Colors.white,
              title: Text(
                'Join Team',
                style: TS_TITLE,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: HEIGHT_PADDING),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) {},
                            autofocus: false,
                            decoration: TEXT_FIELD_DECORATION_2.copyWith(
                              hintText: '#TeamCode',
                            ),
                          ),
                        ),
                      ),
                      //SizedBox(width: 20),
                      Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: addTeamsButton(
                              hintText: "Join", onPressed: () {}))
                    ],
                  ),
                ),
              ],
            ),
            //
            Divider(endIndent: 25, indent: 25),
            //
            custom.ExpansionTile(
              onIconPressed: () => onTileTap(_createTeamKey),
              key: _createTeamKey,
              backgroundColor: COLOR_BACKGROUND,
              onTap: () => onTileTap(_createTeamKey),
              headerBackgroundColor: Theme.of(context).appBarTheme.color,
              iconColor: Colors.white,
              title: Text('Create Team', style: TS_TITLE),
              children: [
                SizedBox(height: HEIGHT_PADDING),
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
              ],
            ),
            //
            Divider(endIndent: 25, indent: 25),
            //
            custom.ExpansionTile(
              onIconPressed: () => onTileTap(_createRoomKey),
              key: _createRoomKey,
              backgroundColor: COLOR_BACKGROUND,
              onTap: () => onTileTap(_createRoomKey),
              headerBackgroundColor: Theme.of(context).appBarTheme.color,
              iconColor: Colors.white,
              title: Text(
                'Create Room',
                style: TS_TITLE,
              ),
              children: [
                SizedBox(height: HEIGHT_PADDING),
                SizedBox(
                  height: 40,
                  width: width,
                  child: TextFormField(
                    validator: (value) {
                      if (value.trim().length < 3){
                        setState(() {
                          nameError= 'too short name';
                        });

                        print(nameError);
                      }
                      else {
                        setState(() {
                          nameError="";
                        });

                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {},
                    decoration: TEXT_FIELD_DECORATION_2.copyWith(
                      hintText: 'name',
                    ),
                  ),
                ),

                (nameError==null) ? null : Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 40,top: 12),
                      child: Text(nameError,style: TextStyle(color: Colors.red,height: 0),textAlign:TextAlign.start,),
                    ),
                    Spacer(flex: 1,)
                  ],
                ),
                // TextFormField(
                //     onSaved: (v){},
                //     keyboardType: TextInputType.emailAddress,
                //     decoration: InputDecoration(
                //
                //
                //         labelText: "",
                //         labelStyle: TextStyle(color: Colors.grey, fontSize: 5),
                //         contentPadding: EdgeInsets.only(bottom: 0),
                //         focusedBorder: UnderlineInputBorder(
                //             borderSide: BorderSide(color: Colors.white)))),
                SizedBox(height: HEIGHT_PADDING),
                SizedBox(
                  height: 40,
                  width: width,
                  child: TextFormField(
                    validator: (value) {
                      if (value.trim().length < 3){
                        setState(() {
                          descriptionError= 'Description field is required';
                        });

                        print(descriptionError);
                      }
                      else {
                        setState(() {
                          descriptionError="";
                        });

                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) {},
                    autofocus: false,
                    decoration: TEXT_FIELD_DECORATION_2.copyWith(
                      hintText: hintText,
                      // errorStyle: TextStyle(height: 1),
                    ),
                  ),
                ),
                (descriptionError==null) ? null : Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 40,top: 15),
                      child: Text(descriptionError,style: TextStyle(color: Colors.red,height: 0),textAlign:TextAlign.start,),
                    ),
                    Spacer(flex: 1,)
                  ],
                ),
                SizedBox(height: HEIGHT_PADDING),
                addTeamsButton(
                    hintText: "Create Room",
                    onPressed: () {
                      _formKey.currentState.save();
                      _formKey.currentState.validate();
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
