import 'package:flutter/material.dart';
import 'package:project/provider/data_constants.dart';

import 'package:provider/provider.dart';

import 'package:project/provider/team_provider.dart';
import 'package:project/dialogs/assign_members_dialog.dart';
import 'package:project/screen/main_screen/attachment%20screen.dart';
import '../constants.dart';
import '../demoData.dart';
import 'create_task_screen.dart';
import '../widgets/dateField_widget.dart';
import '../widgets/task/parent_checkpoint.dart';
import '../widgets/team_tile.dart';
import '../widgets/user_tile.dart';
import '../widgets/task/add_checkpoint_widget.dart';
import '../widgets/task/checkpoint_widget.dart';
import '../widgets/task/description_widget.dart';
import '../widgets/task/task_flexibleSpace.dart';

import '../model/models.dart';
import '../model/taskType.dart';

class TaskScreen extends StatefulWidget {
  final int taskId;

  const TaskScreen({Key key, @required this.taskId}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool _isEditing = false;
  bool _isLoading = false;
  bool _showCheckpointDesc = true;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> _removedUsernames = [];
  List<User> _addedUsers = [];

  //new checkpoints
  List<CheckPoint> _addCheckpoint = [];

  //holds checkpoints ID that should be deleted
  List<int> _removeCheckpoint = [];

  //the real task data
  Task task;

  /*
  * a palace holder for edits happens on the task,
  * this is a copy from real task, to hold any changes
  * when updateTask runs: it takes all these data to be updated.
  * when update finish it reloads, and re-assigned with the real one
   */
  Task _taskUpdate;

  _reloadTask() {
    task = teamProvider.findById(widget.taskId);
    _taskUpdate = Task(
      id: task.id,
      name: task.name,
      datePlannedStart: task.datePlannedStart,
      datePlannedEnd: task.datePlannedEnd,
      description: task.description,
      progress: task.progress,
      projectName: task.projectName,
      checkPoints: task.checkPoints,
      members: task.members,
      taskCreator: task.taskCreator,
      dateActualStart: task.dateActualStart,
      dateActualEnd: task.dateActualEnd,
      parentCheckpoint: task.parentCheckpoint,
      assignedTeam: task.assignedTeam,
    );
  }

  //change data in the required update;
  changePlannedStartDate(DateTime date) => _taskUpdate.datePlannedStart = date;

  changePlannedEndDate(DateTime date) => _taskUpdate.datePlannedEnd = date;

  changeTaskName(String name) => _taskUpdate.name = name;

  TeamProvider teamProvider;

  bool _isInit = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      teamProvider = Provider.of<TeamProvider>(context);
      //get this task from the provider

      _reloadTask();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TeamProvider teamProvider = Provider.of<TeamProvider>(context);
    //
    // //get task id from previous TaskCard
    // final int taskId = ModalRoute.of(context).settings.arguments;
    // //get this task from the provider
    // Task task = teamProvider.findById(taskId);
    //
    // _taskUpdate.id ??= task.id;
    // _taskUpdate.name ??= task.name;
    // _taskUpdate.description ??= task.description;
    // _taskUpdate.datePlannedStart ??= task.datePlannedStart;
    // _taskUpdate.datePlannedEnd ??= task.datePlannedEnd;

    updateTask() async {
      setState(() => _isLoading = true);
      //await Future.delayed(Duration(seconds: 2));

      // merge current checkpoints with added checkpoints
      _addCheckpoint.forEach((element) => _taskUpdate.checkPoints.add(element));

      teamProvider.updateTask(_taskUpdate);
      // await handleRequest(() => teamProvider.updateTask(_taskUpdate), context);
      //await handleRequest(()=>teamProvider.updateTask(_taskUpdate), context);

      if (_removeCheckpoint.isNotEmpty) {
        await teamProvider.deleteCheckpoints(_removeCheckpoint);
      }

      if (_removedUsernames.isNotEmpty) {
        await teamProvider.removeAssignedMembers(task.id, _removedUsernames);
        _removedUsernames = [];
      }

      if (_addedUsers.isNotEmpty) {
        await teamProvider.assignMembers(task.id, _addedUsers);
        _addedUsers = [];
      }
      //clear data
      _addCheckpoint = [];
      _removeCheckpoint = [];
      //_removedUsernames = [];
      //_addedUsers = [];

      _reloadTask();

      setState(() => _isLoading = false);
    }

    // Future<void> updateDescription(String desc) async {
    //   setState(() => _isLoading = true);
    //   await handleRequest(() => teamProvider.updateTaskDescription(desc, task.id), context);
    //   setState(() =>_isLoading = false);
    // }

    //used for add members button
    addUsers() async {
      //TODO:show add member dialog
      // users shown on the screen
      List<User> showedUsers = task.members + _addedUsers;
      //all team members filted by shown users
      List<User> otherUsers = teamProvider.team.members;
      otherUsers.removeWhere((user) => showedUsers.contains(user));

      var result = await showDialog(context: context, builder: (_) => AssignMembersDialog(allUsers: otherUsers, selectedUsers: []));
      if (result != null) setState(() => _addedUsers = result);
    }

    final notificationHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: false,
            collapsedHeight: 45,
            toolbarHeight: 44.9999,
            expandedHeight: 125,
            //forceElevated: false,
            //automaticallyImplyLeading: false,
            //leading: IconButton(icon: Icon(Icons.arrow_back, size: 22),splashRadius: 15, onPressed: () =>Navigator.of(context).pop(),),
            actions: [
              IconButton(
                padding: const EdgeInsets.symmetric(vertical: 8),
                icon: _isEditing
                    ? Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                )
                    : Icon(Icons.edit, color: Colors.white),
                splashRadius: 20,
                onPressed: () {
                  setState(() => _isEditing = !_isEditing);
                  if (!_isEditing) {
                    updateTask();
                  }
                },
              ),
              IconButton(
                  icon: Transform.rotate(
                      angle: 3.14 / 4,
                      child: Icon(
                        Icons.attach_file,
                        color: Colors.white,
                      )),
                  splashRadius: 20,
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => Attachment())))
            ],
            flexibleSpace: BuildFlexibleSpace(
              taskId: task.id,
              isEdit: _isEditing,
              isLoading: _isLoading,
              changeName: changeTaskName,
              changePEDate: changePlannedEndDate,
              changePSDate: changePlannedStartDate,
              scaffoldKey: _scaffoldKey,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              if (task.dependentTask != null)
                Container(
                  //height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.2, 1],
                      colors: [
                        COLOR_ACCENT,
                        Colors.purple[700],
                      ],
                    ),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).scaffoldBackgroundColor, //Colors.black38, //COLOR_BACKGROUND,
                          ),
                          padding: const EdgeInsets.all(4.5),
                          child: Image.asset('assets/icons/task.png', color: Colors.purple)),
                      SizedBox(width: 8),
                      FittedBox(
                          child: Text(
                            task.dependentTask.name,
                            style: TextStyle(fontSize: 15),
                          )),
                      Spacer(),
                      Icon(Icons.pause_circle_outline_rounded, size: 23, color: Colors.redAccent),
                      SizedBox(width: 8),
                      Text('after: ', style: TextStyle(fontSize: 15)),
                      DateField(initialDate: task.dependentTask.datePlannedEnd),
                    ],
                  ),
                ),
              if (task.parentCheckpoint != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12, right: 8, left: 8, bottom: 8),
                  child: ParentCheckpoint(
                    task.parentCheckpoint,
                    taskAccentColor: taskTypes[task.type].accentColor,
                  ),
                ),

              /*
              *
              * description
              * */

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: DescriptionWidget(
                  _taskUpdate.description,
                  enableEdit: _isEditing,
                  taskAccentColor: taskTypes[task.type].accentColor,
                  onChanged: (String desc) => setState(() => _taskUpdate.description = desc),
                ),
              ),
              Divider(endIndent: 25, indent: 25),
/*
  ///
  /// Checkpoints
  ///
*/
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'Checkpoints',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: taskTypes[task.type].accentColor,
                      ),
                    ),
                    Spacer(),
                    Switch(
                      value: _showCheckpointDesc,
                      onChanged: (_) => setState(() => _showCheckpointDesc = !_showCheckpointDesc),
                      activeColor: taskTypes[task.type].accentColor,
                    ),
                  ],
                ),
              ),
            ]),
          ),

          //current checkpoints
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return InkWell(
                  onLongPress: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => CreateTask(
                        teamMembers: users,
                            parentCheckpoint: _taskUpdate.checkPoints[index],
                            cpStart: _taskUpdate.datePlannedStart,
                            cpEnd: _taskUpdate.datePlannedEnd,
                          ))),
                  child: CheckpointWidget(
                    key: UniqueKey(),
                    checkPoint: _taskUpdate.checkPoints[index],
                    taskAccentColor: taskTypes[task.type].accentColor,
                    isEditing: _isEditing,
                    showDescription: _showCheckpointDesc,
                    onChanged: (cp) {
                      _taskUpdate.checkPoints[index] = cp;
                      print('after adding cp: ${_taskUpdate.checkPoints}');
                    },
                    onRemove: (cp) {
                      setState(() => _taskUpdate.checkPoints.removeWhere((element) => element.id == cp.id));
                      _removeCheckpoint.add(cp.id);
                    },
                    //make sure that is a checkpoint left at least
                    enableDelete: (_addCheckpoint.length > 1 || _taskUpdate.checkPoints.length > 1),
                  ),
                );
              },
              childCount: _taskUpdate.checkPoints.length,
            ),
          ),

          //added checkpoints
          if (_addCheckpoint.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return CheckpointWidget(
                    key: UniqueKey(),
                    checkPoint: _addCheckpoint[index],
                    taskAccentColor: taskTypes[task.type].accentColor,
                    isEditing: _isEditing,
                    showDescription: _showCheckpointDesc,
                    onChanged: (cp) => _addCheckpoint[index] = cp,
                    onRemove: (cp) => setState(() => _addCheckpoint.removeAt(index)),
                    //make sure that is a checkpoint left at least
                    enableDelete: (_addCheckpoint.length > 0 || _taskUpdate.checkPoints.length > 0),
                  );
                },
                childCount: _addCheckpoint.length,
              ),
            ),
          SliverList(
              delegate: SliverChildListDelegate([
                if (_isEditing)
                  AddCheckpointWidget(
                    taskAccentColor: taskTypes[task.type].accentColor,
                    onSubmit: (name, desc) {
                      setState(() => _addCheckpoint.add(CheckPoint(id: null, name: name, description: desc, subtasks: [])));
                    },
                  ),
/*
  ///
    ///assigned to:
  ///
*/
                Divider(endIndent: 25, indent: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        'Assigned to:',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: taskTypes[task.type].accentColor),
                      ),
                      Spacer(),
                      task.assignedTeam != null
                          ? InkWell(
                          onTap: _isEditing
                              ? () async {
                            //TODO:show Teams dialog
                          }
                              : null,
                          child: TeamTile(task.assignedTeam))
                          : _isEditing
                          ? SizedBox(
                          height: 22,
                          child: IconButton(
                              icon: Icon(Icons.add_circle_outline_rounded),
                              padding: EdgeInsets.zero,
                              tooltip: 'add member',
                              color: Colors.white,
                              splashRadius: 20,
                              onPressed: addUsers))
                          : SizedBox()
                    ],
                  ),
                ),
              ])),
          if (task.members != null)
            SliverList(
                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                  return Row(
                    children: [
                      //SizedBox(width: 8),
                      if (_isEditing)
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => setState(() => _removedUsernames.add(task.members[index].userName)),
                          splashRadius: 20,
                          iconSize: 20,
                          padding: const EdgeInsets.all(0),
                          disabledColor: Colors.grey[800],
                          tooltip: 'remove user',
                          color: Colors.red,
                        ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 16, left: _isEditing ? 0 : 16),
                          child: _UserTile(
                            user: task.members[index],
                            isSelected: (_removedUsernames.contains(task.members[index].userName)),
                            onDeselect: (user) => setState(() => _removedUsernames.remove(user.userName)),
                          ),
                        ),
                      ),
                    ],
                  );
                }, childCount: task.members.length)),

          //added users while editing
          if (_addedUsers.isNotEmpty)
            SliverList(
                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                  return Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: _isLoading ? null : () => setState(() => _addedUsers.removeAt(index)),
                        splashRadius: 20,
                        iconSize: 20,
                        padding: const EdgeInsets.all(0),
                        disabledColor: Colors.grey[800],
                        tooltip: 'remove user',
                        color: Colors.red,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 16, left: _isEditing ? 0 : 16),
                          child: _UserTile(
                            user: _addedUsers[index],
                            icon: Icons.add_circle,
                            isSelected: (true),
                            accentColor: COLOR_ACCENT,
                            onDeselect: (_) => setState(() => _addedUsers.removeAt(index)),
                          ),
                        ),
                      ),
                    ],
                  );
                }, childCount: _addedUsers.length)),
/*
  ///
    ///Created by:
  ///
*/
          SliverList(
              delegate: SliverChildListDelegate([
                Divider(endIndent: 25, indent: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Created by:',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: taskTypes[task.type].accentColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, bottom: 12),
                  child: UserTile(task.taskCreator),
                ),
              ])),
        ],
      ),
    );
  }
}

/// custom UserTile that has selection mood, overall similar to [UserTile]
class _UserTile extends StatelessWidget {
  final User user;
  final bool isSelected;

  final Function(User) onSelected;
  final Function(User) onDeselect;

  _UserTile({Key key, this.user, this.onSelected, this.onDeselect, this.isSelected, this.accentColor = Colors.red, this.icon = Icons.remove_circle_rounded}) : super(key: key);

  final accentColor;

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    var name = user.name.split(' ');

    return GestureDetector(
      onTap: () {
        if (isSelected) onDeselect(user);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 52,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.only(left: 6, right: 14, top: 2, bottom: 2),
        decoration: BoxDecoration(
          color: isSelected ? accentColor.withOpacity(0.2) : COLOR_BACKGROUND,
          borderRadius: BorderRadius.circular(10),
          border: isSelected ? Border.all(color: accentColor) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 22,
              child: isSelected ? Icon(icon, color: accentColor) : Text(name[0][0] + (name.length > 1 ? name[1][0] : ''), style: TextStyle(fontSize: 16)),
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
                    Text(name[0] + ' ' + (name.length > 1 ? name[1] : ''), style: TextStyle(fontSize: 15)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(' @${user.userName}', style: TextStyle(fontSize: 12.5, color: Colors.grey)),
                        Spacer(),
                        Text(user.jobTitle, style: TextStyle(fontSize: 13.5)),
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
