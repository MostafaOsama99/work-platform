import 'package:flutter/material.dart';

import 'package:circular_check_box/circular_check_box.dart';

import '../widgets/user_tile.dart';
import '../constants.dart';
import '../model/task.dart';

/// [_User] is a class contains user and a bool [selected] holds the value for each dialog item if it's selected or not
class _User {
  bool selected;
  final User user;

  _User(this.user, {this.selected = false});
}

class AssignMembersDialog extends StatefulWidget {
  final List<User> selectedUsers;
  final List<User> allUsers;

  const AssignMembersDialog({Key key, this.selectedUsers, this.allUsers}) : super(key: key);

  @override
  _AssignMembersDialogState createState() => _AssignMembersDialogState();
}

class _AssignMembersDialogState extends State<AssignMembersDialog> {
  EdgeInsets _padding;
  bool _isInit = false;
  int _selectCount = 0;

  bool _selectAll = false;
  List<User> _selectedUsers;

  List<_User> _loadedUsers = [];

  @override
  void initState() {
    _selectedUsers = widget.selectedUsers;
    // if all selected
    if (_selectedUsers.length == widget.allUsers.length) {
      _selectCount = _selectedUsers.length;
      _selectAll = true;
      widget.allUsers.forEach((element) => _loadedUsers.add(_User(element, selected: true)));
    }
    // sort by selection
    else {
      widget.allUsers.forEach((element) {
        // if this element is selected
        if (_selectedUsers.contains(element))
          _loadedUsers.insert(0, _User(element, selected: true)); // insert first
        else
          _loadedUsers.add(_User(element, selected: false)); // add last
      });
      _selectCount = _selectedUsers.length;
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _padding = MediaQuery.of(context).padding;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: COLOR_SCAFFOLD,
      insetPadding: EdgeInsets.only(top: _padding.top + 51, bottom: 57, left: 12, right: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, bottom: 4, right: 6),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Members',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    '$_selectCount selected ',
                    style: const TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
                    child: CircularCheckBox(
                        checkColor: Colors.white,
                        activeColor: COLOR_ACCENT.withOpacity(0.8),
                        inactiveColor: Theme.of(context).appBarTheme.color,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        value: _selectAll,
                        onChanged: (value) {
                          _selectAll = value;
                          if (value)
                            setState(() {
                              _loadedUsers.forEach((element) => element.selected = true);
                              _selectCount = _loadedUsers.length;
                            });
                          else
                            setState(() {
                              _loadedUsers.forEach((element) => element.selected = false);
                              _selectCount = 0;
                            });
                        }),
                  )
                ],
              ),
            ),
            Expanded(
              //  maxHeight: _size.height * 0.7,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue, Colors.transparent, Colors.transparent, Colors.blue],
                    stops: [0.0, 0.03, 0.97, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstOut,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (BuildContext context, int index) => _UserTile(
                    key: UniqueKey(),
                    user: _loadedUsers[index],
                    onSelected: (id) => setState(() {
                      _selectCount++;
                      _loadedUsers.firstWhere((element) => element.user.id == id).selected = true;
                    }),
                    onDeselect: (id) => setState(() {
                      _selectCount--;
                      if (_selectAll) _selectAll = false;
                      _loadedUsers.firstWhere((element) => element.user.id == id).selected = false;
                    }),
                  ),
                  itemCount: _loadedUsers.length,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlineButton(
                    padding: const EdgeInsets.all(0),
                    //borderSide: BorderSide(color: COLOR_ACCENT, width: 2),
                    highlightedBorderColor: Colors.red,
                    child: Transform.rotate(angle: 3.14 / 4, child: Icon(Icons.add, color: Colors.red)),
                    onPressed: () => Navigator.of(context).pop()),
                OutlineButton(
                    padding: const EdgeInsets.all(0),
                    //borderSide: BorderSide(color: COLOR_ACCENT, width: 2),
                    highlightedBorderColor: Colors.green,
                    child: Icon(Icons.done, color: Colors.green),
                    onPressed: () {
                      _selectedUsers = [];
                      _loadedUsers.forEach((element) {
                        if (element.selected) _selectedUsers.add(element.user);
                      });

                      Navigator.of(context).pop(_selectedUsers);
                    }),
              ],
            ),
            SizedBox(height: 4)
          ],
        ),
      ),
    );
  }
}

/// custom UserTile that has selection mood, overall similar to [UserTile]
class _UserTile extends StatelessWidget {
  final _User user;
  final Function(int id) onSelected;
  final Function(int id) onDeselect;

  const _UserTile({Key key, this.user, this.onSelected, this.onDeselect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = user.user.name.split(' ');

    return GestureDetector(
      onTap: () {
        if (!user.selected)
          onSelected(user.user.id);
        else
          onDeselect(user.user.id);
      },
      child: Container(
        height: 52,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.only(left: 6, right: 14, top: 2, bottom: 2),
        decoration: BoxDecoration(
          color: user.selected ? COLOR_ACCENT.withOpacity(0.5) : COLOR_BACKGROUND,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 22,
              child: user.selected
                  ? Icon(Icons.check, color: COLOR_ACCENT)
                  : Text(name[0][0] + name[1][0], style: TextStyle(fontSize: 16)),
              backgroundColor: user.selected ? COLOR_SCAFFOLD : COLOR_ACCENT,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name[0] + ' ' + name[1], style: TextStyle(fontSize: 15)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(' ${user.user.userName}', style: TextStyle(fontSize: 12.5, color: Colors.grey)),
                        Spacer(),
                        Text(user.user.jobTitle, style: TextStyle(fontSize: 13.5)),
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
