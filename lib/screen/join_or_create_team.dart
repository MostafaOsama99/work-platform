import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/custom_expansion_title.dart';
import 'package:project/widgets/task/add_teams_button.dart';
import '../widgets/custom_expansion_title.dart' as custom;

const TS_TITLE = TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 1.2);

const HEIGHT_PADDING = 16.0;

class CreateRoomScreen extends StatefulWidget {
  ///managed by child class state [ExpansionTileState]
  static GlobalKey<ExpansionTileState> currentOpened;

  @override
  _CreateRoomScreenState createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  static final _formKey = GlobalKey<FormState>();
  String nameError;

  String descriptionError;

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
    String hintText = 'Description';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KAppBarHeight),
        child: ClipRRect(
          borderRadius:
              BorderRadius.only(bottomRight: Radius.circular(KAppBarRound), bottomLeft: Radius.circular(KAppBarRound)),
          child: AppBar(
            title: Text("create room - join team"),
            centerTitle: true,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          children: [
            Row(
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
                Padding(padding: EdgeInsets.only(left: 15), child: addTeamsButton(hintText: "Join", onPressed: () {}))
              ],
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(KAppBarRound),
                        topRight: Radius.circular(KAppBarRound),
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [COLOR_BACKGROUND, COLOR_BACKGROUND.withOpacity(0.4)],
                        stops: [0, 1])),
                child: Text('Create Room', style: TS_TITLE)),

            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                height: 40,
                width: width,
                child: TextFormField(
                  validator: (value) {
                    if (value.trim().length < 3)
                      setState(() => nameError = 'too short name');
                    else
                      setState(() => nameError = null);
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    //TODO: join team
                  },
                  decoration: TEXT_FIELD_DECORATION_2.copyWith(
                    hintText: 'name',
                  ),
                ),
              ),
            ),

            if (nameError != null)
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 40, top: 7, bottom: 2),
                    child: Text(
                      nameError,
                      style: TextStyle(color: Colors.red, height: 0),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            //SizedBox(height: HEIGHT_PADDING),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: null,
                validator: (value) {
                  if (value.trim().length < 3) {
                    setState(() {
                      descriptionError = 'Description field is required';
                    });

                    print(descriptionError);
                  } else {
                    setState(() {
                      descriptionError = "";
                    });
                  }
                  return null;
                },
                textInputAction: TextInputAction.newline,
                onFieldSubmitted: (_) {},
                autofocus: false,
                decoration: TEXT_FIELD_DECORATION_2.copyWith(
                  hintText: hintText,
                  // errorStyle: TextStyle(height: 1),
                ),
              ),
            ),
            if (descriptionError != null)
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 40, top: 7, bottom: 10),
                    child: Text(
                      descriptionError,
                      style: TextStyle(color: Colors.red, height: 0),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            SizedBox(
              height: 50,
              child: FittedBox(
                child: addTeamsButton(
                    hintText: "Create Room",
                    onPressed: () {
                      _formKey.currentState.save();
                      _formKey.currentState.validate();
                    }),
              ),
            ),
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
