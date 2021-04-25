import 'package:flutter/material.dart';
import 'package:project/model/task.dart';
import 'package:project/widgets/task/descriptionTextField.dart';

import '../../constants.dart';
import '../dateField_widget.dart';
import 'add_checkpoint_widget.dart';
import 'checkpoint_description.dart';

createTask(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: COLOR_SCAFFOLD,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      builder: (BuildContext context) {
        return CreateTask();
      });
}

class CreateTask extends StatefulWidget {
  final Color taskAccentColor;

  const CreateTask({Key key, this.taskAccentColor = Colors.green}) : super(key: key);

  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  Task newTask = Task(
      id: null,
      name: null,
      datePlannedStart: DateTime.now(),
      datePlannedEnd: DateTime.now().add(Duration(days: 7)),
      checkPoints: []);


  int count = 0;
  _addCheckpoint(String title, String description) {
    count++;
    setState(() {
      checkpoints.add(CustomCheckpointWidget(
        key: ValueKey(count),
        taskAccentColor: widget.taskAccentColor,
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

  final List<CustomCheckpointWidget> checkpoints = [];

  final _formKey = GlobalKey<FormState>();

  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      child: SizedBox(
        height: 350,
        child: Form(
          key: _formKey,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 8, bottom: 12),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [COLOR_SCAFFOLD, Colors.transparent],
                        stops: [0.7, 1],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                          autofocus: true,
                          maxLength: 35,
                          onFieldSubmitted: (value){
                            newTask.name = value.trim();
                          },
                          validator: (value){
                            if(value.length < 3) return 'too short name';
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: TEXT_FIELD_DECORATION_2.copyWith(
                              counterStyle: TextStyle(height: 1),
                              hintText: 'Task title',
                              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12))),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: ListView(clipBehavior: Clip.antiAlias, children: [
                  SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.calendar_today_rounded, size: KIconSize),
                        Spacer(),
                        Text('from: ', style: TextStyle(color: Colors.grey, fontSize: 15)),
                        DateField(
                          firstDate: newTask.datePlannedStart,
                          initialDate: newTask.datePlannedStart,
                          isEditing: true,
                          onChanged: (newDate) => newTask.datePlannedStart = newDate,
                        ),
                        Spacer(flex: 3),
                        Text('duo: ', style: TextStyle(fontSize: 15, color: Colors.grey)),
                        DateField(
                            firstDate: newTask.datePlannedStart,
                            initialDate: newTask.datePlannedEnd,
                            isEditing: true,
                            onChanged: (newDate) => newTask.datePlannedEnd = newDate),
                        Spacer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: DescriptionTextField(
                      controller: descriptionController,
                      width: MediaQuery.of(context).size.width,
                      readOnly: false,
                      decoration: TEXT_FIELD_DECORATION_2.copyWith(
                          hintText: 'Description',
                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12)),
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: ScrollPhysics(),
                    children: [...checkpoints],
                  ),
                  AddCheckpointWidget(onSubmit: _addCheckpoint),
                ]),
              )
            ].reversed.toList(),
          ),
        ),
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
        ),
        if(_isEditing)
        Padding(
          padding: const EdgeInsets.only(bottom: 8, right: 10),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.delete_outline),
                  onPressed: () => widget.onRemove(widget.key),
                  splashRadius: 20,
                  iconSize: 30,
                  padding: EdgeInsets.zero,
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
