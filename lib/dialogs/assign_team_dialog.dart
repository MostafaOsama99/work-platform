import 'package:flutter/material.dart';
import 'package:project/model/task.dart';

import '../constants.dart';

//TODO: use future builder to get the data

///to select team
class AssignTeamDialog extends StatelessWidget {
  final List<Team> teams;

  const AssignTeamDialog({Key key, @required this.teams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EdgeInsets _padding = MediaQuery.of(context).padding;

    return Dialog(
      backgroundColor: COLOR_SCAFFOLD,
      insetPadding: EdgeInsets.only(top: _padding.top + 51, bottom: 57, left: 12, right: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Text('Choose Team', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            const SizedBox(height: 20),
            SingleChildScrollView(
              child: LimitedBox(
                maxHeight: MediaQuery.of(context).size.height * 0.65,
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
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: teams.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) => CustomTeamTile(
                      key: UniqueKey(),
                      team: teams[index],
                    ),
                    separatorBuilder: (__, _) => Divider(indent: 5, endIndent: 5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTeamTile extends StatelessWidget {
  final Team team;

  const CustomTeamTile({Key key, @required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => Navigator.of(context).pop(team),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Image.asset('assets/icons/team-2.png', height: 28, color: Colors.greenAccent),
          const SizedBox(width: 14),
          Text(team.name, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
