import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/constants.dart';

// ignore: non_constant_identifier_names
final InputDecoration TEXT_FIELD_DECORATION_2 = InputDecoration(
  fillColor: Colors.blueGrey.shade800,
  filled: true,
  contentPadding: const EdgeInsets.all(16),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: const Color.fromRGBO(39, 142, 165, 1)),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
  ),
);

class EditTeamScreen extends StatefulWidget {
  @override
  _EditTeamScreenState createState() => _EditTeamScreenState();
}

class _EditTeamScreenState extends State<EditTeamScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _expandDes = false;

  var names = [
    'Ahmed Mohamed',
    'Mostafa Osama',
    'Mohamed Hesham',
    'Yousef Essam',
    'Mahmoud Yousef',
    'Beshoy Wagdy',
    'Habiba Sayed'
  ];

  List<Widget> users;

  @override
  void initState() {
    super.initState();
    users = List.generate(names.length, (index) => _userTile(names[index]));
    //names.forEach((name) => users.add(_userTile(name)));
    _nameController.text = 'Team Name';
    _descriptionController.text =
        '''this an example of a long description to test the three line in description text form field 
    this an example of a long description to test the three line in description text form field 
    this an example of a long description to test the three line in description text form field 
    this an example of a long description to test the three line in description text form field 
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(HEIGHT_APPBAR),
        child: AppBar(
          leading: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 35,
              )),
          title: Text('Edit Team'),
          centerTitle: true,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          TextField(
              readOnly: true,
              style: TextStyle(color: Colors.white),
              controller: _nameController,
              decoration: TEXT_FIELD_DECORATION_2.copyWith(
                suffixIcon: IconButton(
                    splashRadius: 20,
                    splashColor: Color.fromRGBO(8, 77, 99, 1),
                    icon: Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _edit(context, _nameController);
                      });
                    }),
              )),
          Divider(
            height: 16,
            indent: 30,
            endIndent: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 2, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Description',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                IconButton(
                    splashRadius: 20,
                    splashColor: Color.fromRGBO(8, 77, 99, 1),
                    icon: Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _edit(context, _descriptionController, maxLines: 4);
                      });
                    }),
              ],
            ),
          ),
          TextField(
            readOnly: true,
            autofocus: false,
            controller: _descriptionController,
            maxLines: _expandDes ? null : 4,
            onTap: () => setState(() => _expandDes = !_expandDes),
            style: TextStyle(color: Colors.white),
            decoration: TEXT_FIELD_DECORATION_2,
          ),
          Divider(
            height: 16,
            indent: 30,
            endIndent: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Text('Members',
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
          ...users
        ],
      ),
    );
  }

  Widget _userTile(String name) {
    var lastLitter = name.indexOf(' ') + 1;
    return GestureDetector(
      onLongPress: () {
        //TODO: show popup menu
        //https://stackoverflow.com/questions/54300081/flutter-popupmenu-on-long-press
        //or use 3 dot drop down menu
        //https://stackoverflow.com/questions/58144948/easiest-way-to-add-3-dot-pop-up-menu-appbar-in-flutter
      },
      child: Container(
        height: 55,
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade800.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              child: Text(name[0] + name[lastLitter],
                  style: TextStyle(fontSize: 16)),
              backgroundColor: Colors.yellow,
            ),
            //  SizedBox(width: 15,),
            Flexible(
                flex: 5,
                child: Text(name,
                    style: TextStyle(color: Colors.white, fontSize: 15)))
          ],
        ),
      ),
    );
  }

  _edit(BuildContext context, TextEditingController controller,
      {int maxLines = 1}) {
    final _formKey = GlobalKey<FormState>();

    String _validate(String value) {
      if (value.length <= 3) return 'too short name !';
      return null;
    }

    _submit() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        Navigator.of(context).pop();
      }
    }

    return showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        backgroundColor: Color.fromRGBO(8, 77, 99, 1),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        builder: (BuildContext context) {
          return SizedBox(
            //size of keyboard + padding + button + TextField
            height: MediaQuery.of(context).viewInsets.bottom +
                35 +
                60 +
                13 +
                maxLines * 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        autofocus: true,
                        maxLines: maxLines,
                        textInputAction: maxLines == 1
                            ? TextInputAction.done
                            : TextInputAction.newline,
                        onSaved: (value) {
                          controller.text = value;
                        },
                        initialValue: controller.value.text,
                        decoration: TEXT_FIELD_DECORATION.copyWith(
                            errorStyle: TextStyle(height: 1),
                            contentPadding: const EdgeInsets.all(12),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        validator: _validate,
                        onFieldSubmitted: (_) => _submit(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                            minWidth: 100,
                            height: 35,
                            color: Colors.red,
                            child: Center(child: Icon(Icons.cancel)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                        MaterialButton(
                            minWidth: 100,
                            height: 35,
                            color: Colors.green,
                            child: Center(child: Icon(Icons.done)),
                            onPressed: _submit)
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
