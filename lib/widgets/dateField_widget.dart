import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateField extends StatefulWidget {
  final bool isEditing;
  final DateTime firstDate, lastDate, initialDate;

  const DateField({Key key, this.isEditing = false, this.firstDate, this.lastDate, this.initialDate }) : super(key: key);

  @override
  _DateFieldState createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  DateTime _date ;
  String _dateFormat;

  Future<void> _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate,
      firstDate: widget.firstDate ?? DateTime(2015, 1),
      lastDate: widget.lastDate ?? DateTime.now().add(Duration(days: 36500)),
    );
    if (picked != null && picked != _date) {
      setState(() {
        if(_date.year != picked.year)
          _dateFormat = picked.year == DateTime.now().year ? 'EEE, d MMM' : 'EEE, d MMM, yy';
        _date = picked;

      });
    }
  }

  @override
  void initState() {
    _date = widget.initialDate ?? DateTime.now();
    _dateFormat = _date.year == DateTime.now().year ? 'EEE, d MMM' : 'EEE, d MMM, yy';
    //_date = DateFormat(_dateFormat).format(_date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      child: Text(
          DateFormat(_dateFormat).format(_date)
        //  _date.toString()
      ),
      onTap: widget.isEditing ? _showDatePicker : null,
    );
  }
}
