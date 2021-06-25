import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/provider/UserData.dart';
import 'package:project/provider/data_constants.dart';
import 'package:project/provider/team_provider.dart';
import 'package:provider/provider.dart';
import '../demoData.dart';
import '../dialogs/assign_members_dialog.dart';
import '../dialogs/assign_type_dialog.dart';
import '../model/taskType.dart';
import '../widgets/dateField_widget.dart';

import '../widgets/task/descriptionTextField.dart';

import '../widgets/team_tile.dart';
import '../widgets/user_tile.dart';
import '../widgets/snackBar.dart';

import '../constants.dart';
import '../dialogs/assign_team_dialog.dart';
import '../model/models.dart';

const Color KProjectAccentColor = Colors.lightBlue;

class CreateProject extends StatefulWidget {
  @override
  _CreateProjectState createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  ///holds new task data
  Task newTask;

  ///counter for remaining charters left
  int _titleCounter;

  bool _isLoading = false;
  bool _isInit = false;
  //bool _isLeader;

  TeamProvider teamProvider;

  _validate(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState.validate()) return;

    _submit(context);
  }

  _submit(BuildContext context) async {
    setState(() => _isLoading = true);

    //await handleRequest(() => teamProvider.createTask(_task), context);

    setState(() => _isLoading = false);

    Navigator.of(context).pop();
  }

  _addMemberOrTeam() async {
    var result;
    //witch kind user want (team, members)
    result = await showDialog(context: context, builder: (_) => AssignTypeDialog());

    if (result == 'members') {
      result = await showDialog(context: context, builder: (_) => AssignMembersDialog(allUsers: teamProvider.team.members, selectedUsers: _selectedUsers));
      if (result != null) setState(() => _selectedUsers = result);
    } else if (result == 'team') {
      result = await showDialog(context: context, builder: (_) => AssignTeamDialog(teams: teams));
      setState(() {
        if (_selectedTeam != null && result == null) return; // if there's a team selected & users canceled team selection => keep previous selection
        _selectedTeam = result;
        _selectedUsers = []; //to show the selected team
      });
    }
  }

  _updateStartDate(DateTime newDate) {
    if (newDate.isAfter(newTask.datePlannedEnd))
      setState(() {
        newTask.datePlannedStart = newDate;
        newTask.datePlannedEnd = newDate;
      });
    else
      setState(() => newTask.datePlannedStart = newDate);
  }

  final _formKey = GlobalKey<FormState>();

  final descriptionController = TextEditingController();

  ///list of current selected users
  List<User> _selectedUsers = [];

  /// current selected team
  Team _selectedTeam;

  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (!_isInit) {
      //teamProvider = Provider.of<TeamProvider>(context, listen: false);

      //_isLeader = teamProvider.isLeader(Provider.of<UserData>(context, listen: false).userName);
      //if (!_isLeader) _selectedUsers.add(Provider.of<UserData>(context, listen: false).user);
      //teamProvider.getTeamsBelow();

      _titleCounter = KTaskTitleLength;
      _isInit = true;
    }
    return Scaffold(
      body: Stack(alignment: Alignment.topCenter, children: [
        Container(
          height: 450,
          // padding: const EdgeInsets.only(top: 8, bottom: 12),
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [KProjectAccentColor.withOpacity(0.95), Colors.transparent], stops: [0, 1], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 45,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: IconButton(padding: EdgeInsets.zero, splashRadius: 20, onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back)),
                    ),
                    Text('Create Project', style: const TextStyle(fontSize: 16)),
                    Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.check,
                        ),
                        iconSize: 22,
                        splashRadius: 20,
                        onPressed: () => _validate(context)),
                    SizedBox(width: 8)
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 45, left: 6, right: 6),
          decoration: BoxDecoration(color: COLOR_SCAFFOLD, borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            child: ListView(clipBehavior: Clip.antiAlias, padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12), children: [
              // SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 25, right: 25),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Form(
                        key: _formKey,
                        child: TextFormField(
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            controller: _titleController,
                            maxLength: KTaskTitleLength,
                            onChanged: (value) {
                              ///update counter
                              setState(() => _titleCounter = KTaskTitleLength - value.length);
                            },
                            onFieldSubmitted: (value) {
                              if (value.length > KTaskTitleLength) {
                                _titleController.text = value.substring(0, KTaskTitleLength);
                                setState(() => _titleCounter = KTaskTitleLength - _titleController.value.text.length);
                              }
                            },
                            validator: (value) => (value.length < 3) ? '' : null,
                            textInputAction: TextInputAction.next,
                            decoration: TEXT_FIELD_DECORATION_2.copyWith(
                                counterStyle: TextStyle(height: 1),
                                errorStyle: TextStyle(height: 0),
                                errorMaxLines: null,
                                counter: SizedBox(),
                                hintText: 'Task title',
                                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12, bottom: 8),
                        child: Text(
                          '$_titleCounter',
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 6),
                  Icon(Icons.calendar_today_rounded, size: KIconSize),
                  SizedBox(width: 20),
                  Text('from: ', style: TextStyle(color: Colors.grey, fontSize: 15)),
                  DateField(
                    key: UniqueKey(),
                    //firstDate: widget.cpStart ?? DateTime.now(),
                    // initialDate: newTask.datePlannedStart,
                    //lastDate: widget.cpEnd,
                    isEditing: true,
                    onChanged: (newDate) => _updateStartDate(newDate),
                  ),
                  Spacer(),
                  Text('duo: ', style: TextStyle(fontSize: 15, color: Colors.grey)),
                      DateField(
                          key: UniqueKey(),
                          //    firstDate: newTask.datePlannedStart,
                          //   initialDate: newTask.datePlannedEnd,
                          //lastDate: widget.cpEnd,
                          isEditing: true,
                          onChanged: (newDate) =>
                              newTask.datePlannedEnd = newDate),
                    ],
                  ),

                  SizedBox(height: 12),

                  DescriptionTextField(
                    controller: descriptionController,
                    width: MediaQuery.of(context).size.width,
                    readOnly: false,
                    decoration: TEXT_FIELD_DECORATION_2.copyWith(
                        hintText: 'Description',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 14)),
                  ),

                  Divider(indent: 25, endIndent: 25),

                  SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add Teams:', style: TextStyle(fontSize: 16, color: KProjectAccentColor)),
                  SizedBox(
                      height: 22,
                      child: IconButton(
                          icon: Icon(Icons.add_circle_outline_rounded),
                          padding: EdgeInsets.zero,
                          tooltip: 'add member',
                          color: Colors.white,
                          splashRadius: 20,
                          onPressed: () {
                            _showBottomSheet(context);
                              }))
                ],
              ),
              SizedBox(height: 10),

              _selectedUsers.length > 0
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _selectedUsers.length,
                      itemBuilder: (BuildContext context, int index) => UserTile(_selectedUsers[index]),
                    )
                  : _selectedTeam != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: SizedBox(child: TeamTile(_selectedTeam)),
                        )
                      : SizedBox(
                          height: 40,
                          child: Center(
                            child: Text(
                              'Add teams!',
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white70),
                                ),
                          ),
                            )
                ]),
          ),
        ),
        if (_isLoading) Center(child: CircularProgressIndicator()),
      ]),
    );
  }
}

class CustomTeamTile extends StatefulWidget {
  final bool isSelected;
  final Team team;
  final void Function(int teamId) onSelected;
  final void Function(int teamId) onDeselect;

  const CustomTeamTile(
      {Key key,
      this.isSelected = false,
      @required this.team,
      this.onSelected,
      this.onDeselect})
      : super(key: key);

  @override
  _CustomTeamTileState createState() => _CustomTeamTileState();
}

class _CustomTeamTileState extends State<CustomTeamTile> {
  bool _isSelected;

  @override
  void initState() {
    _isSelected = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: _isSelected
              ? Colors.green.withOpacity(0.4)
              : KProjectAccentColor.withOpacity(0.4),
          border: Border.all(
              color: _isSelected
                  ? Colors.green
                  : KProjectAccentColor.withOpacity(0.4))),
      duration: Duration(seconds: 1),
      child: InkWell(
        onTap: () {
          setState(() => _isSelected = !_isSelected);
          if (_isSelected)
            widget.onSelected(widget.team.id);
          else
            widget.onDeselect(widget.team.id);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 22,
              child: _isSelected
                  ? Icon(Icons.check, color: Colors.green)
                  : Icon(Icons.people_alt_rounded, color: KProjectAccentColor),
              backgroundColor: COLOR_SCAFFOLD,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.team.name, style: TextStyle(fontSize: 15)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(widget.team.description,
                            style:
                                TextStyle(fontSize: 12.5, color: Colors.grey),
                            maxLines: 1),
                        Spacer(),
                        Text(widget.team.leader.name,
                            style: TextStyle(fontSize: 13.5)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            //SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          color: Color.fromRGBO(0, 0, 0, 0.001),
          child: GestureDetector(
            onTap: () {},
            child: DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.2,
              maxChildSize: 0.75,
              builder: (_, controller) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade800.withBlue(150),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.remove,
                        color: Colors.grey[600],
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: controller,
                          itemCount: 100,
                          itemBuilder: (_, index) {
                            return Card(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text("Element at index($index)"),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}