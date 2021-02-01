import 'dart:wasm';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


// maximum height for TextFormField error text height
//   usually between 0-1
const ERROR_TEXT_STYLE = 0.4;
const COLOR_BACKGROUND = Color.fromRGBO(27, 32, 41, 1);
const COLOR_ACCENT = Color.fromRGBO(13, 56, 120, 1);
const COLOR_SCAFFOLD = Color.fromRGBO(17, 20, 25, 1);
const PADDING_VERTICAL = 12.0;

const HEIGHT_APPBAR = 50.0;
const TS_TITLE =
TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 1.2);


// default TextFormField decoration
// ignore: non_constant_identifier_names
final TEXT_FIELD_DECORATION = InputDecoration(
  filled: true,
  errorStyle: TextStyle(height: 0),
  fillColor: Colors.white,

  ///use it in case => theme brightness: Brightness.dark,
  //hintStyle: TextStyle(color: Colors.grey),
  contentPadding: const EdgeInsets.only(left: 20, bottom: 0, top: 0),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2),
    borderRadius: BorderRadius.circular(25),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(25),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.5),
    borderRadius: BorderRadius.circular(25),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(25),
  ),
  // disabledBorder: OutlineInputBorder(
  //   borderSide: BorderSide(color: Colors.white),
  //   borderRadius: BorderRadius.circular(25.7),
  // ),
);

// ignore: non_constant_identifier_names
final InputDecoration TEXT_FIELD_DECORATION_2 = InputDecoration(
  fillColor: COLOR_BACKGROUND,
  //Colors.blueGrey.shade800,
  filled: true,
  contentPadding: const EdgeInsets.all(16),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.transparent),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.transparent),
  ),
);


bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}

String formatDate(DateTime date) {
  const month = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  String formatDate;
  formatDate = '${date.day} ${month[date.month - 1]}';

  if (DateTime.now().year != date.year)
    formatDate = formatDate + ', ${date.year.toString().substring(2)}';

  return formatDate;
}

class BuildDateTime extends StatefulWidget {

  final DateTime selectedDate;
  final double padding;

  const BuildDateTime({Key key, this.selectedDate, this.padding}) : super(key: key);

  @override
  _BuildDateTimeState createState() => _BuildDateTimeState(selectedDate);
}

class _BuildDateTimeState extends State<BuildDateTime> {

  DateTime date;
  _BuildDateTimeState (this.date);

  String dateFormat;
  @override
  Widget build(BuildContext context) {

    dateFormat = widget.selectedDate.year == DateTime.now().year ? 'EEE, d MMM' : 'EEE, d MMM, yyyy' ;

    return SizedBox(
      //height: 10,
      child: DateTimeField(

        style: TextStyle(fontSize: 15, color: Colors.white),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 0, left: 0, bottom: 0),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            //hintText: DateFormat(dateFormat).format(selectedDate).toString(),
            hintStyle: TextStyle(color: Colors.white)),
        format: DateFormat('EEEE, d MMM, yyyy'),
        initialValue: widget.selectedDate,

        onChanged: (value) {
          setState(() {
            date = value ;
            print('value: $value');
            dateFormat = date.year == DateTime.now().year ? 'EEE, d MMM' : 'EEE, d MMM, yyyy' ;
          });
        },
        resetIcon: null,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: date ?? DateTime.now(),
              lastDate: DateTime(2100),

          );
        },
      ),
    );
  }
}

//
// Widget buildDateTime({DateTime selectedDate, double padding = 0.0}) {
//
//   String dateFormat = selectedDate.year == DateTime.now().year ? 'EEE, d MMM' : 'EEE, d MMM, yyyy' ;
//   return SizedBox(
//     //height: 80,
//     child: DateTimeField(
//       style: TextStyle(fontSize: 15, color: Colors.white),
//       decoration: InputDecoration(
//           contentPadding: const EdgeInsets.only(top: 0, left: 0),
//           border: InputBorder.none,
//           focusedBorder: InputBorder.none,
//           enabledBorder: InputBorder.none,
//           errorBorder: InputBorder.none,
//           disabledBorder: InputBorder.none,
//           //hintText: DateFormat(dateFormat).format(selectedDate).toString(),
//           hintStyle: TextStyle(color: Colors.white)),
//       format: DateFormat(dateFormat),
//       initialValue: selectedDate,
//       onChanged: (value) {
//         selectedDate = value ;
//         dateFormat = selectedDate.year == DateTime.now().year ? 'EEE, d MMM' : 'EEE, d MMM, yyyy' ;
//       },
//       resetIcon: null,
//       onShowPicker: (context, currentValue) {
//         return showDatePicker(
//             context: context,
//             firstDate: DateTime(2000),
//             initialDate: selectedDate ?? DateTime.now(),
//             lastDate: DateTime.now().add(Duration(days:  3650)));
//       },
//     ),
//   );
// }