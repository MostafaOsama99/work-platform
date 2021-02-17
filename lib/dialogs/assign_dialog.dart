import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../model/task.dart';

class _User extends User {
  bool selected;

  _User({this.selected = false, userName, @required id, imageUrl, @required name, jobTitle})
      : super(userName: userName, id: id, imageUrl: imageUrl, jobTitle: jobTitle, name: name);
}

//TODO: exclude current user from this list
List<_User> _users = [
  _User(name: 'Mostafa Osama Hamed', id: 0, jobTitle: 'Flutter Developer', userName: '@Mostafa99'),
  _User(name: 'Youssef Essam Name', id: 1, jobTitle: 'Java Developer', userName: '@Youssef_12'),
  _User(name: 'Mohammed Hesham Name', id: 2, jobTitle: 'Flutter Developer', userName: '@MohammedH65'),
  _User(name: 'Mostafa Osama Hamed', id: 3, jobTitle: 'Flutter Developer', userName: '@Mostafa99'),
  _User(name: 'Youssef Essam Name', id: 4, jobTitle: 'Java Developer', userName: '@Youssef_12'),
  _User(name: 'Mohammed Hesham Name', id: 5, jobTitle: 'Flutter Developer', userName: '@MohammedH65'),
  _User(name: 'Mostafa Osama Hamed', id: 6, jobTitle: 'Flutter Developer', userName: '@Mostafa99'),
  _User(name: 'Youssef Essam Name', id: 7, jobTitle: 'Java Developer', userName: '@Youssef_12'),
  _User(name: 'Mohammed Hesham Name', id: 8, jobTitle: 'Flutter Developer', userName: '@MohammedH65'),
];

class _UserTile extends StatelessWidget {
  final _User user;
  final Function(int id) onSelected;
  final Function(int id) onDeselect;

  const _UserTile({Key key, this.user, this.onSelected, this.onDeselect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = user.name.split(' ');

    return GestureDetector(
      onTap: () {
        if (!user.selected)
          onSelected(user.id);
        else
          onDeselect(user.id);
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
                        Text(' ${user.userName}', style: TextStyle(fontSize: 12.5, color: Colors.grey)),
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

class AssignDialog extends StatefulWidget {
  @override
  _AssignDialogState createState() => _AssignDialogState();
}

class _AssignDialogState extends State<AssignDialog> {
  Size _size;
  EdgeInsets _padding;
  bool _isInit = false;
  int _selectCount = 0;

  bool _selectAll = false;

  @override
  void initState() {
    _users.forEach((element) {
      if (element.selected) _selectCount++;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _size = MediaQuery.of(context).size;
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
                              _users.forEach((element) => element.selected = true);
                              _selectCount = _users.length;
                            });
                          else
                            setState(() {
                              _users.forEach((element) => element.selected = false);
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
                    user: _users[index],
                    onSelected: (id) => setState(() {
                      _selectCount++;
                      _users.firstWhere((element) => element.id == id).selected = true;
                    }),
                    onDeselect: (id) => setState(() {
                      _selectCount--;
                      _users.firstWhere((element) => element.id == id).selected = false;
                    }),
                  ),
                  itemCount: _users.length,
                ),
              ),
            ),
            OutlineButton(
                padding: const EdgeInsets.all(0),
                borderSide: BorderSide(color: COLOR_ACCENT, width: 2),
                highlightedBorderColor: Colors.green,
                child: Icon(Icons.done, color: Colors.green),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        ),
      ),
    );
  }
}
