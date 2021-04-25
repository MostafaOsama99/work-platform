import 'package:flutter/material.dart';
import 'package:project/model/task.dart';

import '../../constants.dart';
import 'expandable_text.dart';

class ParentCheckpoint extends StatelessWidget {
  final CheckPoint parentCheckpoint;
  final Color taskAccentColor;

  const ParentCheckpoint(this.parentCheckpoint, {Key key, this.taskAccentColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(
              Icons.adjust,
              size: 20,
              color: taskAccentColor,
            ),
            SizedBox(width: 8),
            Text(parentCheckpoint.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17))
          ],
        ),
        if (parentCheckpoint.description != null)
          Container(
            decoration: BoxDecoration(
                color: COLOR_BACKGROUND,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2.5),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
                boxShadow: [BoxShadow(color: taskAccentColor, offset: Offset(-1, 1))]),
            margin: const EdgeInsets.only(left: 10, top: 5),
            padding: const EdgeInsets.only(left: 10, bottom: 10, right: 5, top: 5),
            child: ExpandableText(parentCheckpoint.description),
            // DescriptionTextField(
            //   controller: TextEditingController(text: widget.task.parentCheckpoint.description),
            //   width: MediaQuery.of(context).size.width - 16,
            //   decoration: TEXT_FIELD_DECORATION_2.copyWith(
            //       contentPadding: EdgeInsets.zero, border: InputBorder.none),
            // )
            //Text(widget.task.parentCheckpoint.description, style: TextStyle(fontSize: 15, height: 1.3)),
          ),
      ],
    );
  }
}
