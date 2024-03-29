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
import '../widgets/task/add_checkpoint_widget.dart';
import '../widgets/task/descriptionTextField.dart';
import '../widgets/task/parent_checkpoint.dart';
import '../widgets/team_tile.dart';
import '../widgets/user_tile.dart';
import '../widgets/snackBar.dart';

import '../constants.dart';
import '../dialogs/assign_team_dialog.dart';
import '../model/models.dart';

class CreateTask extends StatefulWidget {
  ///checkpoint used as parent of new subTask
  final CheckPoint parentCheckpoint;

  /// parent task planned start date
  final DateTime cpStart;

  /// parent task planned end date
  final DateTime cpEnd;

  final List<User> teamMembers;

  const CreateTask({Key key, @required this.teamMembers, this.parentCheckpoint, this.cpStart, this.cpEnd}) : super(key: key);

  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  ///holds new task data
  Task newTask;

  ///counter for remaining charters left
  int _titleCounter;

  bool _isLoading = false;
  bool _isInit = false;
  bool _isLeader;

  TeamProvider teamProvider;

  ///holds checkpoints of the new task
  final List<Map<String, String>> checkpoints = [];

  _addCheckpoint(String title, String description) {
    setState(() {
      checkpoints.add({
        "description": description,
        "title": title,
      });
    });
  }

  _removeCheckpoint(int index) => setState(() => checkpoints.removeAt(index));

  _validate(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState.validate()) return;

    //when user clicks the same button many times, there's only snackBar shown
    ScaffoldMessenger.of(context).clearSnackBars();
    if (checkpoints.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar('Add a checkpoint at least', taskTypes[newTask.type].accentColor.withAlpha(150)));
      return;
    } else if (_selectedUsers.length == 0 && _selectedTeam == null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar('Assigned to ?', taskTypes[newTask.type].accentColor.withAlpha(150)));
      return;
    }
    _submit(context);
  }

  _submit(BuildContext context) async {
    //use current user
    // newTask.taskCreator = User(name: 'Current User!', id: 4564, jobTitle: 'Current User');
    // checkpoints.forEach((element) {
    //   newTask.checkPoints.add(CheckPoint(id: null, name: element['title'], description: element['description']));
    // });
    //
    // if (_selectedUsers.length > 0)
    //   _selectedUsers.forEach((element) {
    //     newTask.members.add(element);
    //     print(element);
    //   });
    // else
    //   newTask.assignedTeam = _selectedTeam;

    Task _task = Task(
        id: null,
        name: _titleController.value.text.trim(),
        checkPoints: checkpoints.map((e) => CheckPoint(id: null, name: e['title'], description: e['description'])).toList(),
        datePlannedStart: newTask.datePlannedStart,
        datePlannedEnd: newTask.datePlannedEnd,
        dateActualStart: newTask.datePlannedStart,
        parentCheckpoint: widget.parentCheckpoint,
        members: _selectedUsers.length > 0 ? _selectedUsers : null,
        //TODO performance check: for assigned team should be a Team object or just teamId
        //if the task is assigned to a team, it will have the team, other wise : it will have member's team
        assignedTeam: _selectedUsers.length == 0 ? _selectedTeam : teamProvider.team);

    setState(() => _isLoading = true);

    await handleRequest(() => teamProvider.createTask(_task), context);

    setState(() => _isLoading = false);

    //TODO: show progress indicator till the data uploaded
    // demoTasks.insert(
    //     0,
    //     Task(
    //         name: _titleController.value.text.trim(),
    //         taskCreator:
    //             User(name: 'Current User!', userName: '', jobTitle: 'Current User'),
    //         checkPoints: checkpoints
    //             .map((e) => CheckPoint(
    //                 id: null, name: e['title'], description: e['description']))
    //             .toList(),
    //         datePlannedStart: newTask.datePlannedStart,
    //         datePlannedEnd: newTask.datePlannedEnd,
    //         parentCheckpoint: widget.parentCheckpoint,
    //         id: 'new task',
    //         members: _selectedUsers.length > 0 ? _selectedUsers : null,
    //         assignedTeam: _selectedUsers.length == 0 ? _selectedTeam : null));
    Navigator.of(context).pop();
  }

  //TODO: check if this this team dose not have teams below, to show AssignMembersDialog directly
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
      newTask = Task(
          id: null,
          name: null,
          datePlannedStart: widget.cpStart ?? DateTime.now(),
          datePlannedEnd: widget.cpEnd ?? DateTime.now().add(Duration(days: 7)),
          parentCheckpoint: widget.parentCheckpoint,
          checkPoints: []);

      teamProvider = Provider.of<TeamProvider>(context, listen: false);
      _isLeader = teamProvider.isLeader(Provider.of<UserData>(context, listen: false).userName);
      if (!_isLeader) _selectedUsers.add(Provider.of<UserData>(context, listen: false).user);
      teamProvider.getTeamsBelow();

      _titleCounter = KTaskTitleLength;
      _isInit = true;
    }
    return Scaffold(
      body: Stack(alignment: Alignment.topCenter, children: [
        Container(
          height: 450,
          // padding: const EdgeInsets.only(top: 8, bottom: 12),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [taskTypes[newTask.type].accentColor.withOpacity(0.95), Colors.transparent], stops: [0, 1], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
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
                    Text(newTask.type == taskType.task ? 'Create new Task' : 'Create SubTask', style: const TextStyle(fontSize: 16)),
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
                  Spacer(),
                  Text('from: ', style: TextStyle(color: Colors.grey, fontSize: 15)),
                  DateField(
                    key: UniqueKey(),
                    firstDate: widget.cpStart ?? DateTime.now(),
                    initialDate: newTask.datePlannedStart,
                    lastDate: widget.cpEnd,
                    isEditing: true,
                    onChanged: (newDate) => _updateStartDate(newDate),
                  ),
                  Spacer(flex: 3),
                  Text('duo: ', style: TextStyle(fontSize: 15, color: Colors.grey)),
                  DateField(
                      key: UniqueKey(),
                      firstDate: newTask.datePlannedStart,
                      initialDate: newTask.datePlannedEnd,
                      lastDate: widget.cpEnd,
                      isEditing: true,
                      onChanged: (newDate) => newTask.datePlannedEnd = newDate),
                  Spacer(),
                  SizedBox(
                    width: 25,
                    child: PopupMenuButton(
                      onSelected: (_) {
                        //TODO: show list of tasks to select
                      },
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.more_vert,
                        size: 18,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<int>(
                          child: Text(
                            'depends on another task?',
                            style: TextStyle(fontSize: 15),
                          ),
                          height: 20,
                          value: 0,
                        )
                      ],
                    ),
                  )
                ],
              ),

              SizedBox(height: 4),

              if (widget.parentCheckpoint != null)
                Padding(
                    padding: const EdgeInsets.only(right: 4, left: 4, bottom: 16),
                    child: ParentCheckpoint(
                      newTask.parentCheckpoint,
                      taskAccentColor: taskTypes[newTask.type].accentColor,
                    )),

              DescriptionTextField(
                controller: descriptionController,
                width: MediaQuery.of(context).size.width,
                readOnly: false,
                decoration: TEXT_FIELD_DECORATION_2.copyWith(hintText: 'Description', contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14)),
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: ScrollPhysics(),
                itemCount: checkpoints.length,
                itemBuilder: (BuildContext context, int index) => CustomCheckpointWidget(
                  key: UniqueKey(),
                  onRemove: (_) => _removeCheckpoint(index),
                  onChanged: (cp) {
                    checkpoints[index]['title'] = cp.name;
                    checkpoints[index]['description'] = cp.description;
                  },
                  checkPoint: CheckPoint(name: checkpoints[index]['title'], description: checkpoints[index]['description'], id: null),
                  taskAccentColor: taskTypes[newTask.type].accentColor,
                ),
              ),
              AddCheckpointWidget(
                onSubmit: _addCheckpoint,
                taskAccentColor: taskTypes[newTask.type].accentColor,
              ),

              Divider(indent: 25, endIndent: 25),

              /*
                 * Assigned to
                 *
                 * TODO: disable this feature if the user is not the leader of the team
                 *  TODO: remove current user from team members
                 * */

              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Assigned to:', style: TextStyle(fontSize: 16, color: taskTypes[newTask.type].accentColor)),
                  SizedBox(
                      height: 22,
                      child: IconButton(
                          icon: Icon(Icons.add_circle_outline_rounded),
                          padding: EdgeInsets.zero,
                          tooltip: 'add member',
                          color: Colors.white,
                          splashRadius: 20,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            _addMemberOrTeam();
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
                    'Add members or a team!',
                    style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.white70),
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

class CustomCheckpointWidget extends StatefulWidget {
  final CheckPoint checkPoint;
  final Color taskAccentColor;
  final Function(CheckPoint checkPoint) onChanged;

  final ValueChanged<Key> onRemove;

  // submit() => onChanged(
  //     state.titleController.value.text, state.descriptionController.value.text);

  CustomCheckpointWidget({
    Key key,
    @required this.checkPoint,
    this.taskAccentColor,
    this.onChanged,
    this.onRemove,
  }) : super(key: key);

  ///saving state of the state class
  final _CustomCheckpointWidgetState state = _CustomCheckpointWidgetState();

  @override
  _CustomCheckpointWidgetState createState() {
    return state;
  }
}

class _CustomCheckpointWidgetState extends State<CustomCheckpointWidget> {
  bool _isEditing;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    _isEditing = false;
    titleController.text = widget.checkPoint.name;
    descriptionController.text = widget.checkPoint.description;
    super.initState();
  }

  saveCheckpoint() {
    widget.onChanged(CheckPoint(name: titleController.value.text, description: descriptionController.value.text, id: widget.checkPoint.id));
  }

  get getTitle => titleController.value.text;

  @override
  void dispose() {
    // nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.adjust, color: widget.taskAccentColor, size: 18),
              SizedBox(width: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextField(
                  readOnly: !_isEditing,
                  controller: titleController,
                  autofocus: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              Spacer(),
              IconButton(
                icon: _isEditing ? Icon(Icons.check_circle_outline, color: Colors.green) : Icon(Icons.edit, color: Colors.white, size: 20),
                splashRadius: 20,
                onPressed: () {
                  setState(() => _isEditing = !_isEditing);
                },
              ),
            ],
          ),
        ),
        if (_isEditing)
          Padding(
            padding: const EdgeInsets.only(bottom: 8, right: 8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () => widget.onRemove(widget.key),
                  splashRadius: 20,
                  iconSize: 28,
                  padding: EdgeInsets.zero,
                  disabledColor: Colors.grey[800],
                  tooltip: 'Delete Checkpoint',
                  color: Colors.red,
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 8),
                      child: TextField(autofocus: false, maxLines: null, controller: descriptionController, decoration: TEXT_FIELD_DECORATION_CHECKPOINT)),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
