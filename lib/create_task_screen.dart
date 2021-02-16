import 'package:flutter/material.dart';
import 'package:project/dialogs/assign_dialog.dart';
import 'package:project/model/taskType.dart';
import 'package:project/widgets/dateField_widget.dart';
import 'package:project/widgets/task/add_checkpoint_widget.dart';
import 'package:project/widgets/task/descriptionTextField.dart';
import 'package:project/widgets/team_tile.dart';

import 'constants.dart';
import 'model/task.dart';

class CreateTask extends StatefulWidget {
  final CheckPoint parentCheckpoint;

  const CreateTask({Key key, this.parentCheckpoint}) : super(key: key);

  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  Task newTask;

  @override
  void initState() {
    newTask = Task(
        id: null,
        name: null,
        datePlannedStart: DateTime.now(),
        datePlannedEnd: DateTime.now().add(Duration(days: 7)),
        parentCheckpoint: widget.parentCheckpoint,
        checkPoints: []);

    super.initState();
  }

  int count = 0;

  _addCheckpoint(String title, String description) {
    count++;
    setState(() {
      checkpoints.add(CustomCheckpointWidget(
        key: ValueKey(count),
        taskAccentColor: taskTypes[newTask.type].accentColor,
        onRemove: _removeCheckpoint,
        description: description,
        title: title,
      ));
    });
  }

  _removeCheckpoint(Key key) => setState(() => checkpoints.removeWhere((element) => element.key == key));

  _submit() {
    //newTask.datePlannedStart

    int idGenerator = -1;
    checkpoints.forEach((cp) => newTask.checkPoints.add(CheckPoint(
        name: cp.state.titleController.value.text,
        description: cp.state.descriptionController.value.text,
        id: ++idGenerator)));
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

  final List<CustomCheckpointWidget> checkpoints = [];

  final _formKey = GlobalKey<FormState>();

  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(alignment: Alignment.topCenter, children: [
          Container(
            height: 450,
            // padding: const EdgeInsets.only(top: 8, bottom: 12),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [taskTypes[newTask.type].accentColor.withOpacity(0.95), Colors.transparent],
                    stops: [0, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 45,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: IconButton(
                            padding: EdgeInsets.all(0),
                            splashRadius: 20,
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.arrow_back)),
                      ),
                      Text('Create new Task', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 45, left: 6, right: 6),
            //padding: const ,
            decoration: BoxDecoration(
                color: COLOR_SCAFFOLD,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
            child: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              child: ListView(
                  clipBehavior: Clip.antiAlias,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  children: [
                    // SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 25, right: 25),
                      child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                            autofocus: true,
                            maxLength: 35,
                            onFieldSubmitted: (value) {
                              newTask.name = value.trim();
                            },
                            validator: (value) {
                              if (value.length < 3) return 'too short name';
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: TEXT_FIELD_DECORATION_2.copyWith(
                                counterStyle: TextStyle(height: 1),
                                hintText: 'Task title',
                                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12))),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.calendar_today_rounded, size: KIconSize),
                        Spacer(),
                        Text('from: ', style: TextStyle(color: Colors.grey, fontSize: 15)),
                        DateField(
                          key: UniqueKey(),
                          firstDate: DateTime.now(),
                          initialDate: newTask.datePlannedStart,
                          isEditing: true,
                          onChanged: (newDate) => _updateStartDate(newDate),
                        ),
                        Spacer(flex: 3),
                        Text('duo: ', style: TextStyle(fontSize: 15, color: Colors.grey)),
                        DateField(
                            key: UniqueKey(),
                            firstDate: newTask.datePlannedStart,
                            initialDate: newTask.datePlannedEnd,
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

                    SizedBox(height: 8),

                    DescriptionTextField(
                      controller: descriptionController,
                      width: MediaQuery.of(context).size.width,
                      readOnly: false,
                      decoration: TEXT_FIELD_DECORATION_2.copyWith(
                          hintText: 'Description',
                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12)),
                    ),
                    ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      physics: ScrollPhysics(),
                      children: [...checkpoints],
                    ),
                    AddCheckpointWidget(onSubmit: _addCheckpoint),

                    Divider(indent: 25, endIndent: 25),

                    /*
                   * Assigned to
                   * */

                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Assigned to:', style: const TextStyle(fontSize: 16)),
                        newTask.assignedTeam != null
                            ? InkWell(
                                onTap: () {
                                  //TODO:show Teams dialog
                                },
                                child: TeamTile(newTask.assignedTeam))
                            : SizedBox(
                                height: 22,
                                child: IconButton(
                                    icon: Icon(Icons.add_circle_outline_rounded),
                                    padding: const EdgeInsets.all(0),
                                    tooltip: 'add member',
                                    color: Colors.white,
                                    splashRadius: 20,
                                    onPressed: () {
                                      showDialog(context: context, builder: (BuildContext context) => AssignDialog());
                                    }))
                      ],
                    )
                  ]),
            ),
          )
        ]),
      ),
    );
  }
}

class CustomCheckpointWidget extends StatefulWidget {
  final String title, description;
  final Color taskAccentColor;
  final Function(String title, String description) onChanged;

  final ValueChanged<Key> onRemove;

  submit() => onChanged(state.titleController.value.text, state.descriptionController.value.text);

  CustomCheckpointWidget({
    Key key,
    @required this.title,
    @required this.description,
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
    titleController.text = widget.title;
    descriptionController.text = widget.description;
    super.initState();
  }

  saveCheckpoint() {
    widget.onChanged(titleController.value.text, descriptionController.value.text);
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
                    contentPadding: const EdgeInsets.all(0),
                  ),
                ),
              ),
              Spacer(),
              IconButton(
                icon: _isEditing
                    ? Icon(Icons.check_circle_outline, color: Colors.green)
                    : Icon(Icons.edit, color: Colors.white, size: 20),
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
                  padding: const EdgeInsets.all(0),
                  disabledColor: Colors.grey[800],
                  tooltip: 'Delete Checkpoint',
                  color: Colors.red,
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 8),
                      child: TextField(
                          autofocus: false,
                          maxLines: null,
                          controller: descriptionController,
                          decoration: TEXT_FIELD_DECORATION_CHECKPOINT)),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
