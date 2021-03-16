import 'package:flutter/material.dart';

import '../constants.dart';

///choose assign type dialog, to select members or team
class AssignTypeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: COLOR_SCAFFOLD,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
                child: Text('Choose assign type', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            SizedBox(height: 20),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => Navigator.of(context).pop('members'),
              child: SizedBox(
                height: 35,
                child: Row(
                  children: [
                    SizedBox(width: 8),
                    Icon(Icons.person_rounded, color: Colors.blueAccent[700]),
                    SizedBox(width: 10),
                    Text('Assign to team members', style: const TextStyle(fontSize: 16))
                  ],
                ),
              ),
            ),
            Divider(indent: 5, endIndent: 5),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => Navigator.of(context).pop('team'),
              child: SizedBox(
                height: 35,
                child: Row(
                  children: [
                    SizedBox(width: 8),
                    Image.asset('assets/icons/team-2.png', height: 28, color: Colors.greenAccent),
                    SizedBox(width: 10),
                    Text('Assign to Team', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
