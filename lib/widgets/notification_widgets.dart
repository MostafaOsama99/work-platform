import 'package:flutter/material.dart';

class EventButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const EventButton({Key key, this.onTap, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: fix splash shape & color
    //u may use members dialog button
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 90,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.all(Radius.circular(25) //
              ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}

//TODO: add unseen color
class NotificationWidget extends StatelessWidget {
  final String text;
  final List<Widget> buttons;
  final DateTime date;

  const NotificationWidget({Key key, this.text, this.buttons, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Text(
                    text,
                    style: TextStyle(fontSize: 16),
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (buttons != null)
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: buttons,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Text(getDuration(date)),
              SizedBox(height: 10),
              Icon(Icons.more_vert)
            ],
          )
        ],
      ),
    );
  }
}

String getDuration(DateTime date) {
  final Duration duration = DateTime.now().difference(date);
  if (duration.inSeconds < 60)
    return 'now';
  else if (duration.inMinutes < 60)
    return '${duration.inMinutes}min';
  else if (duration.inHours < 24)
    return "${duration.inHours}h";
  else if (duration.inDays < 7)
    return '${duration.inDays}d';
  else if (duration.inDays < 30)
    return '${(duration.inDays ~/ 7)}w';
  else if (duration.inDays < 365)
    return "${(duration.inDays ~/ 30)}m";
  else
    return "${(duration.inDays ~/ 365)} y";
}
