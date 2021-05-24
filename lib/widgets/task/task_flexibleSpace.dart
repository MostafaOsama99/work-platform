import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/model/models.dart';
import 'package:project/provider/data_constants.dart';
import 'package:project/provider/team_provider.dart';
import 'package:project/screen/main_screen/activity_screen.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/task/task_card.dart';
import '../dateField_widget.dart';

class BuildFlexibleSpace extends StatefulWidget {
  final Widget child;
  final int taskId;
  final bool isEdit;
  final bool isLoading;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(DateTime date) changePSDate;
  final Function(DateTime date) changePEDate;
  final Function(String name) changeName;

  const BuildFlexibleSpace({
    Key key,
    this.child,
    @required this.taskId,
    this.isEdit = false,
    @required this.isLoading,
    @required this.changePSDate,
    @required this.changePEDate,
    @required this.changeName,
    @required this.scaffoldKey,
  }) : super(key: key);

  @override
  _BuildFlexibleSpaceState createState() {
    return new _BuildFlexibleSpaceState();
  }
}

class _BuildFlexibleSpaceState extends State<BuildFlexibleSpace> {
  TeamProvider teamProvider;

  Task task;

  bool _isInit = false;

  ScrollPosition _position;
  Color taskAccentColor;
  String taskIcon;

  final _titleKey = GlobalKey<FormState>();
  final _focus = FocusNode();
  int titleLength;

  @override
  void dispose() {
    _removeListener();
    _focus.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      teamProvider = Provider.of<TeamProvider>(context);
      task = teamProvider.findById(widget.taskId);

      if (task.dependentTask != null) {
        taskAccentColor = Colors.purple;
        taskIcon = 'assets/icons/subtask-dependent.png';
      } else if (task.parentCheckpoint != null) {
        taskAccentColor = Colors.amber;
        taskIcon = 'assets/icons/subtask.png';
      } else {
        taskAccentColor = Colors.greenAccent.shade400;
        taskIcon = 'assets/icons/task.png';
      }
      titleLength = task.name.length;
      _isInit = true;
    }
    _addListener();
    _removeListener();
  }

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings settings = context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();

    final deltaExtent = settings.maxExtent - settings.minExtent;
    var openedSpace = (settings.currentExtent - settings.minExtent);
    setState(() {
      titleIconPadding = (settings.maxExtent - settings.currentExtent) * 43 / deltaExtent;
      opacity = (settings.currentExtent - settings.minExtent) / deltaExtent;
      topPadding = openedSpace * 10 / deltaExtent; //open %
    });
  }

  var titleIconPadding = 0.0;
  var opacity = 0.0;
  var topPadding = 0.0;

  @override
  Widget build(BuildContext context) {
    final notificationHeight = MediaQuery.of(context).padding.top;
    double _progressIndicatorHeight = 4 - topPadding / 7;

    return FlexibleSpaceBar(
      // collapseMode: CollapseMode.pin,
      centerTitle: false,
      titlePadding: EdgeInsets.zero,
      stretchModes: [StretchMode.zoomBackground],
      //collapseMode: CollapseMode.pin,
      background: Opacity(
        opacity: opacity <= 0.5 ? opacity / 2 : opacity,
        child: Container(
          padding: EdgeInsets.only(top: notificationHeight, right: 16, left: 16),
          //height: 150 - notificationHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 45,
                child: Padding(
                  padding: const EdgeInsets.only(left: 37, top: 0),
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).scaffoldBackgroundColor, //Colors.black38, //COLOR_BACKGROUND,
                          ),
                          width: 32,
                          height: 32,
                          child: Image.asset('assets/icons/project.png', color: Colors.white)),
                      SizedBox(width: 8),
                      Text(task.projectName ?? 'not assigned to project!',
                          style: TextStyle(fontSize: 15, color: task.projectName == null ? Colors.grey : null, fontStyle: task.projectName == null ? FontStyle.italic : null)),
                    ],
                  ),
                ),
              ),

              //TODO: handle case: if user selects new [task.datePlannedStart] and this exceeds [task.datePlannedEnd],
              //TODO: [task.datePlannedEnd] should be empty(red text), if user didn't update [task.datePlannedEnd] deny date changes update
              SizedBox(
                height: 27,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 3),
                    Icon(Icons.calendar_today_rounded, size: KIconSize),
                    Spacer(),
                    Text('from: ', style: TextStyle(color: Colors.grey, fontSize: 15)),
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: task.datePlannedStart.isBefore(DateTime.now().add(Duration(hours: 12))) && widget.isEdit
                          ? () => showSnackBar('this task is already working!', widget.scaffoldKey.currentContext)
                          : null,
                      child: DateField(
                          initialDate: task.datePlannedStart,
                          lastDate: task.datePlannedEnd,
                          firstDate: (task.dependentTask != null ? task.dependentTask.datePlannedEnd : null),
                          onChanged: widget.changePSDate,
                          //TODO: check if the task has any sessions
                          isEditing: task.datePlannedStart.isAfter(DateTime.now().subtract(Duration(hours: 12))) && widget.isEdit),
                    ),
                    Spacer(flex: 3),
                    Text('duo: ', style: TextStyle(fontSize: 15, color: Colors.grey)),
                    DateField(
                      initialDate: task.datePlannedEnd,
                      isEditing: widget.isEdit,
                      onChanged: widget.changePEDate,
                      firstDate: task.datePlannedStart.isBefore(DateTime.now()) ? DateTime.now() : task.datePlannedStart,
                    ),
                    Spacer(flex: 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5 - topPadding / 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 6 + titleIconPadding),
                Container(
                  width: 34 - topPadding / 1.3,
                  height: 34 - topPadding / 1.2,
                  padding: EdgeInsets.all(5 - topPadding / 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).scaffoldBackgroundColor, //Colors.black38, //COLOR_BACKGROUND,
                  ),
                  child: Image.asset(taskIcon, color: taskAccentColor),
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Form(
                    key: _titleKey,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 9),
                      child: Expanded(
                        child: TextFormField(
                          initialValue: task.name,
                          focusNode: _focus,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          enabled: widget.isEdit,
                          validator: (value) => (value.length < 3 || value.length == KTaskTitleLength) ? '' : null,
                          onChanged: (value) {
                            setState(() => titleLength = value.trim().length);
                            if (_titleKey.currentState.validate()) widget.changeName(value.trim());
                          },
                          maxLength: KTaskTitleLength,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            errorMaxLines: 1,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            filled: false,
                            counter: SizedBox(),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                            focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                            disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                            errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          style: TextStyle(fontSize: 16 - topPadding / 2, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                if (_focus.hasFocus)
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 12),
                    child: Text(
                      '$titleLength',
                      style: TextStyle(color: Colors.grey, fontSize: 12 - topPadding / 5),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(left: 30 - topPadding * 2),
                  child: Opacity(
                    opacity: opacity <= 0.5 ? opacity / 2 : opacity,
                    child: SizedBox(
                      height: 22,
                      width: 22,
                      child: IconButton(
                          icon: Icon(Icons.chat),
                          color: COLOR_SCAFFOLD,
                          iconSize: 20,
                          splashRadius: 13,
                          padding: EdgeInsets.zero,
                          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Activity()))),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Opacity(
                  opacity: opacity <= 0.5 ? opacity / 2 : opacity,
                  child: buildUserAvatar(task.taskCreator.name),
                ),
              ],
            ),
          ),
          if (widget.isLoading) SizedBox(height: _progressIndicatorHeight, child: LinearProgressIndicator()),
        ],
      ),
    );
  }
}
