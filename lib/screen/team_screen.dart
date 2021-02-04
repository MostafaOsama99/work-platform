import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/widgets/datepicker.dart';
import 'package:project/widgets/task/add_checkpoint_widget.dart';
import 'package:project/widgets/task/description_widget.dart';

import '../model/task.dart';
import '../widgets/task/task_card.dart';

import '../constants.dart';
import '../demoData.dart';
import 'edit_team_screen.dart';

class TeamScreen extends StatefulWidget {
  final teamName;
  final List<Task> tasks;

  TeamScreen({this.teamName, this.tasks});

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  ScrollController _scrollController;
  var _isVisible;

  hideButton() {
    print('hide button called');
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (_isVisible == true) {
        // only set when the previous state is false, Less widget rebuilds
        setState(() => _isVisible = false);
      }
    } else {
      if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (_isVisible == false) {
          // only set when the previous state is false, Less widget rebuilds
          setState(() => _isVisible = true);
        }
      }
    }
  }

  createTask(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: COLOR_SCAFFOLD, //Color.fromRGBO(8, 77, 99, 1),
        shape: RoundedRectangleBorder(
          side:BorderSide(color: COLOR_ACCENT),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        builder: (BuildContext context)
    {
    return SizedBox(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: TEXT_FIELD_DECORATION_2.copyWith(
                  hintText: 'Task title',
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12)
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              textInputAction: TextInputAction.next,
              maxLines: 3,
              decoration: TEXT_FIELD_DECORATION_2.copyWith(
                  hintText: 'Description',
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12)
              ),
            ),
            AddCheckpointWidget()
          ],
        ),
      ),
    );

    });
  }

  @override
  initState() {
    _isVisible = true;
    _scrollController = ScrollController();
    _scrollController.addListener(hideButton);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(hideButton);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(HEIGHT_APPBAR),
        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          child: AppBar(
            leading: IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            title: Text(widget.teamName),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                splashRadius: 21,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditTeamScreen()));
                },
              )
            ],
          ),
        ),
      ),
      body: ListView.builder(
          controller: _scrollController,
          // scrollDirection: Axis.horizontal,
          itemCount: widget.tasks.length,
          itemBuilder: (context, i) => TaskCard(widget.tasks[i])),

      floatingActionButton: Visibility(
        visible: _isVisible,
        child: FloatingActionButton(
          onPressed: () {
            //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => PickerDemo()));
            createTask(context);
            },
          tooltip: 'Add Task',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
