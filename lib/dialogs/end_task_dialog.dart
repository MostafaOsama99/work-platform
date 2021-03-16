import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:project/model/task.dart';

import '../constants.dart';

class EndTaskDialog extends StatefulWidget {
  final Duration duration;
  final Task task;

  const EndTaskDialog({Key key, this.duration, this.task}) : super(key: key);

  @override
  _EndTaskDialogState createState() => _EndTaskDialogState();
}

class _EndTaskDialogState extends State<EndTaskDialog> {
  EdgeInsets _padding;
  var _size;
  bool _isInit = false;

  Duration _duration;

  @override
  void initState() {
    _duration = widget.duration;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      _padding = MediaQuery.of(context).padding;
      _size = MediaQuery.of(context).size;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: COLOR_SCAFFOLD,
      insetPadding: EdgeInsets.only(top: _padding.top + 30, bottom: 70, left: 12, right: 12),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: COLOR_ACCENT.withOpacity(0.75)), borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Center(child: Text('End Task', style: const TextStyle(fontSize: 18, color: Colors.white))),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                onTap: () async {
                  var response = await showDialog(context: context, builder: (_) => DurationDialog(_duration));
                  if (response != null) setState(() => _duration = response);
                },
                child: Ink(
                  decoration: BoxDecoration(color: COLOR_BACKGROUND, borderRadius: BorderRadius.circular(25)),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('session time:', style: const TextStyle(fontSize: 16)),
                      Text(
                        (_duration.inHours % 60).toString().padLeft(2, '0') +
                            ':' +
                            (_duration.inMinutes % 60).toString().padLeft(2, '0'),
                        style: const TextStyle(fontFamily: 'digital', fontSize: 22, letterSpacing: 1.2),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (_, index) => CheckPointWidget(
                        key: Key('$index'),
                        checkPoint: widget.task.checkPoints[index],
                      ),
                  separatorBuilder: (_, __) => Divider(
                        endIndent: 5,
                        indent: 5,
                        color: Colors.white12,
                        height: 18,
                      ),
                  itemCount: widget.task.checkPoints.length),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlineButton(
                  padding: const EdgeInsets.all(0),
                  highlightedBorderColor: Colors.greenAccent.shade700,
                  splashColor: COLOR_BACKGROUND,
                  color: COLOR_SCAFFOLD,
                  highlightElevation: 2,
                  borderSide: BorderSide(width: 1.5, color: COLOR_BACKGROUND),
                  child: Text(
                    'Okay',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green.shade700),
                  ),
                  onPressed: () => Navigator.of(context).pop()),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckPointWidget extends StatefulWidget {
  final CheckPoint checkPoint;

  const CheckPointWidget({Key key, this.checkPoint}) : super(key: key);

  @override
  _CheckPointWidgetState createState() => _CheckPointWidgetState();
}

class _CheckPointWidgetState extends State<CheckPointWidget> {
  double percentage;
  bool _value;

  initState() {
    percentage = widget.checkPoint.percentage.toDouble();
    _value = (percentage == 100.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            children: [
              SizedBox(
                height: 0,
                width: 25,
                child: CircularCheckBox(
                  value: _value,
                  checkColor: Colors.white,
                  activeColor: Colors.green.shade600,
                  inactiveColor: Theme.of(context).appBarTheme.color,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  onChanged: (_) {},
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.checkPoint.name,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontStyle: _value ? FontStyle.italic : null,
                      decoration: _value ? TextDecoration.lineThrough : null),
                ),
              ),
              //Spacer(),
              Text(
                percentage.round().toString() + '%',
                style: const TextStyle(
                    color: Colors.white70, fontSize: 16, fontStyle: FontStyle.italic, fontFamily: 'digital'),
              )
            ],
          ),
        ),
        SizedBox(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Slider(
              value: percentage,
              min: 0,
              max: 100,
              onChanged: (double value) => setState(() => percentage = value),
              onChangeEnd: (value) => setState(() => _value = (value == 100.0)),
              label: percentage.round().toString(),
              inactiveColor: COLOR_BACKGROUND,
              activeColor: COLOR_ACCENT,
            ),
          ),
        )
      ],
    );
  }
}

class DurationDialog extends StatefulWidget {
  final Duration duration;

  const DurationDialog(this.duration);

  @override
  _DurationDialogState createState() => _DurationDialogState();
}

class _DurationDialogState extends State<DurationDialog> {
  Duration _duration;

  @override
  void initState() {
    _duration = widget.duration;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: COLOR_SCAFFOLD,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              'Edit Session time',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Center(
              child: DurationPicker(
            duration: _duration,
            onChange: (Duration value) => setState(() => _duration = value),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlineButton(
                    padding: const EdgeInsets.all(0),
                    highlightedBorderColor: Colors.red,
                    child: Transform.rotate(angle: 3.14 / 4, child: Icon(Icons.add, color: Colors.red)),
                    onPressed: () => Navigator.of(context).pop()),
                OutlineButton(
                    padding: const EdgeInsets.all(0),
                    highlightedBorderColor: Colors.green,
                    child: Icon(Icons.done, color: Colors.green),
                    onPressed: () {
                      Navigator.of(context).pop(_duration);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
