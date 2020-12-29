import 'package:flutter/material.dart';
import 'package:project/constants.dart';
import 'package:project/widgets/task/widgets.dart';
import 'package:project/widgets/task/custom_expansion_title.dart' as custom ;
class JoinTeamScreen extends StatefulWidget {
  @override
  _JoinTeamScreenState createState() => _JoinTeamScreenState();
}

class _JoinTeamScreenState extends State<JoinTeamScreen> {
  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Join or create team",
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, top: 20),
        child: Form(
          key: _formKey,

          child: ListView(
            children: [
              custom.ExpansionTile(
                headerBackgroundColor: Colors.transparent,
                iconColor: Colors.teal,
                title: Text(
                  'Join team',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          style: TextStyle(fontSize: 18),
                          onFieldSubmitted: (_) {},
                          autofocus: false,
                          decoration: TEXT_FIELD_DECORATION.copyWith(
                            hintText: 'team code',
                            errorStyle: TextStyle(height: 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Container(
                              width: 80, child: addTeamsButton(hintText: "Add")))
                    ],
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20, right: 20),
                child: Divider(
                  color: Colors.white30,
                ),
              ),
              custom.ExpansionTile(
                headerBackgroundColor: Colors.transparent,
                iconColor: Colors.teal,
                title:Padding(
                  padding: EdgeInsets.only( top: 15),
                  child: Text(
                    'Add team',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ) ,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20, right: 50),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (_) {},
                      autofocus: false,
                      decoration: TEXT_FIELD_DECORATION.copyWith(
                        hintText: 'name',
                        errorStyle: TextStyle(height: 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20, right: 55),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 18),
                      onFieldSubmitted: (_) {},
                      autofocus: false,
                      decoration: TEXT_FIELD_DECORATION.copyWith(
                        hintText: 'Description',
                        errorStyle: TextStyle(height: 1),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        color: Colors.white,
                        child: DropdownButton<String>(
                          hint: Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text('choose room'),
                          ),
                          items: <String>['A', 'B', 'C', 'D'].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ),
                      Container(
                        width: 100,
                        color: Colors.white,
                        child: DropdownButton<String>(
                          hint: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('team'),
                          ),
                          items: <String>['A', 'B', 'C', 'D'].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 135, left: 135, top: 22),
                    child: addTeamsButton(hintText: "Add Team"),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20, right: 20),
                child: Divider(

                  color: Colors.white30,
                ),
              ),
              custom.ExpansionTile(
                headerBackgroundColor: Colors.transparent,
                iconColor: Colors.teal,
                title:  Padding(
                  padding: EdgeInsets.only( top: 15),
                  child: Text(
                    'Create Room',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20, right: 50),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (_) {},
                      autofocus: false,
                      decoration: TEXT_FIELD_DECORATION.copyWith(
                        hintText: 'name',
                        errorStyle: TextStyle(height: 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20, right: 55),
                    child: TextFormField(
                      validator: (value) {
                        if (value.length < 1) return 'Description of room is Required';
                        //    _registerData['password'] = value;
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 18),
                      onFieldSubmitted: (_) {},
                      autofocus: false,
                      decoration: TEXT_FIELD_DECORATION.copyWith(
                        hintText: 'Description',
                        errorStyle: TextStyle(height: 1),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: 140, left: 140, top: 0),
                      child: addTeamsButton(hintText: "Create",onPressed: (){
                        _formKey.currentState.save();
                        _formKey.currentState.validate();
                      })),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

