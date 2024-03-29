import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

// maximum height for TextFormField error text height
//   usually between 0-1
const ERROR_TEXT_STYLE = 0.4;
const COLOR_BACKGROUND = Color.fromRGBO(34, 28, 38, 1);
const COLOR_ACCENT = Color.fromRGBO(13, 56, 130, 1);
const COLOR_SCAFFOLD = Color.fromRGBO(15, 15, 17, 1);
const PADDING_VERTICAL = 12.0;
const double KAppBarRound = 15.0;

const KAppBarHeight = 45.0;
const TS_TITLE =
    TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 1.2);

const KIconSize = 18.0;

const KTextFieldHeight = 40.0;

const KIconColor = Colors.white;

const KDescriptionMaxLines = 3;

///timer progress target hours
const KTargetWorkHours = 6;

///this should be deffer from country to another
const KMobileLength = 11;

///max task title length
const int KTaskTitleLength = 30;

// const server = 'http://10.0.2.2:5000/api/v1';

const serverNotification = 'http://10.0.2.2:5000/notification';
const server = 'https://workera.azurewebsites.net/api/v1';

const KTimeOutDuration = Duration(seconds: 10);

// default TextFormField decoration
// ignore: non_constant_identifier_names
final TEXT_FIELD_DECORATION = InputDecoration(
  errorStyle: TextStyle(height: 0),
  errorMaxLines: null,
  contentPadding: const EdgeInsets.all(8),
  isDense: true,
  filled: true,
  fillColor: Colors.white,
  hintStyle: TextStyle(color: Colors.grey[700]),
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
);
final TEXT_FIELD_DECORATION1 = InputDecoration(
contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
  isDense: true,
  filled: true,
  fillColor: Colors.white,
  hintStyle: TextStyle(color: Colors.grey[700]),
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
);

// ignore: non_constant_identifier_names
final InputDecoration TEXT_FIELD_DECORATION_2 = InputDecoration(
  fillColor: COLOR_BACKGROUND,
  isDense: true,
  //Colors.blueGrey.shade800,
  filled: true,
  hintText: 'add description!',
  contentPadding: const EdgeInsets.all(12),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(width: 0, style: BorderStyle.none),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(width: 0, style: BorderStyle.none),
  ),
  errorBorder:  OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.red),
  ),
  focusedErrorBorder:  OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.red),
  //  gapPadding: 0
  ),
);

// ignore: non_constant_identifier_names
final InputDecoration TEXT_FIELD_DECORATION_CHECKPOINT = InputDecoration(
  fillColor: COLOR_BACKGROUND,
  //Colors.blueGrey.shade800,
  filled: true,
  hintText: 'add description!',
  contentPadding: const EdgeInsets.all(10),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15)),
    borderSide: BorderSide(width: 0, style: BorderStyle.none),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15)),
    borderSide: BorderSide(width: 0, style: BorderStyle.none),
  ),
);

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(p);
  return regExp.hasMatch(em);
}

String formatDate(DateTime date) {
  const month = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  String formatDate;
  formatDate = '${date.day} ${month[date.month - 1]}';

  if (DateTime.now().year != date.year) formatDate = formatDate + ', ${date.year.toString().substring(2)}';

  return formatDate;
}

// class BuildDateTime extends StatefulWidget {
//   final DateTime selectedDate;
//   final double padding;
//
//   const BuildDateTime({ Key key,this.selectedDate,  this.padding}) : super(key: key);
//
//   @override
//   _BuildDateTimeState createState() => _BuildDateTimeState(selectedDate);
// }
// class _BuildDateTimeState extends State<BuildDateTime> {
//  DateTime date;
//
//   _BuildDateTimeState(this.date);
//
//   String dateFormat;
//
//   @override
//   Widget build(BuildContext context) {
//     dateFormat = widget.selectedDate.year == DateTime.now().year ? 'EEE, d MMM' : 'EEE, d MMM, yyyy';
//
//     return SizedBox(
//       //height: 10,
//       child: DateTimeField(
//         style: TextStyle(fontSize: 15, color: Colors.white),
//         decoration: InputDecoration(
//             contentPadding: const EdgeInsets.only(top: 0, left: 0, bottom: 0),
//             border: InputBorder.none,
//             focusedBorder: InputBorder.none,
//             enabledBorder: InputBorder.none,
//             errorBorder: InputBorder.none,
//             disabledBorder: InputBorder.none,
//             //hintText: DateFormat(dateFormat).format(selectedDate).toString(),
//             hintStyle: TextStyle(color: Colors.white)),
//         format: DateFormat('EEEE, d MMM, yyyy'),
//         initialValue: widget.selectedDate,
//         onChanged: (value) {
//           setState(() {
//             date = value;
//             dateFormat = date.year == DateTime.now().year ? 'EEE, d MMM' : 'EEE, d MMM, yyyy';
//           });
//         },
//         resetIcon: null,
//         onShowPicker: (context, currentValue) {
//           return showDatePicker(
//             context: context,
//             initialDate: date ?? DateTime.now(),
//             firstDate: DateTime(1900),
//             lastDate: DateTime(2100),
//           );
//         },
//       ),
//     );
//   }
// }
//
