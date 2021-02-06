import 'package:flutter/material.dart';
import 'package:project/model/task.dart';

import '../constants.dart';

class TeamTile extends StatelessWidget {
  final Team team;

  const TeamTile(this.team, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: COLOR_BACKGROUND,
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(60)),
      child: Row(
        children: [
          Image.asset(
            'assets/icons/team-2.png',
            height: 25,
            color: Colors.greenAccent,
          ),
          SizedBox(width: 8),
          Text(
            team.name,
            softWrap: false,
            overflow: TextOverflow.fade,
            //style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// Chip(
// avatar: Image.asset('assets/icons/team-2.png', color: Colors.white,),
// backgroundColor: COLOR_BACKGROUND,
// label: Text(team.name, style: TextStyle(color: Colors.white),),
// )
//
