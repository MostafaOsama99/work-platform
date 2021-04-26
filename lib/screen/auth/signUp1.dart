import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../../provider/UserData.dart';
import '../../constants.dart';

Widget errorMessage(String message) {
  return Padding(
    padding: EdgeInsets.only(left: 15, top: 17),
    child: Text(
      message,
      style: TextStyle(color: Colors.red, height: 0),
      textAlign: TextAlign.start,
    ),
  );
}

const _textFormErrorHeight = 50.0;
const TS_Style = TextStyle(fontSize: 16, color: Colors.black);

class SignUp1 extends StatefulWidget {
  final Function() onNext;

  SignUp1({key: Key, this.onNext}) : super(key: key);

  @override
  _SignUp1State createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String firstNameValidation = '';
  String mobileValidation = '';
  String jobTitleValidation = '';
  String birtDateValidation = '';

  DateTime birtDate;

  final _jobTitleFocusNode = FocusNode();
  final _mobileFocusNode = FocusNode();
  final _birthDateFocusNode = FocusNode();

  static const double padding = 20;

  submit() {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    widget.onNext();

    //TODO: implement submit
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{11,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      setState(() => mobileValidation = 'Please enter mobile number');
      return '';
    } else if (!regExp.hasMatch(value)) {
      setState(() => mobileValidation = 'Please enter valid mobile number');
      return '';
    }
    setState(() => mobileValidation = '');
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context, listen: false);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(flex: 2),
          SizedBox(
            height: KTextFieldHeight,
            child: TextFormField(
                initialValue: user.name,
                textInputAction: TextInputAction.next,
                style: TS_Style,
                keyboardType: TextInputType.name,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_jobTitleFocusNode);
                },
                validator: (value) {
                  if (value.trim().length < 3) {
                    setState(() => firstNameValidation = 'too short name');
                    return '';
                  }
                  setState(() => firstNameValidation = "");
                  return null;
                },
                onSaved: (value) => user.setName = value,
                decoration: TEXT_FIELD_DECORATION.copyWith(
                  prefixIcon: Icon(
                    Icons.person,
                    color: COLOR_BACKGROUND,
                  ),
                  hintText: 'full name',
                )),
          ),
          if (firstNameValidation.isNotEmpty) errorMessage(firstNameValidation),
          Spacer(),
          SizedBox(
            height: KTextFieldHeight,
            child: TextFormField(
              initialValue: user.jobTitle,
              textInputAction: TextInputAction.next,
              style: TS_Style,
              keyboardType: TextInputType.name,
              focusNode: _jobTitleFocusNode,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_mobileFocusNode);
              },
              onSaved: (value) => user.setJobTitle = value,
              validator: (value) {
                if (value.trim().length < 3) {
                  setState(() => jobTitleValidation = 'too short name');
                  return '';
                }
                setState(() => jobTitleValidation = "");
                return null;
              },
              decoration: TEXT_FIELD_DECORATION.copyWith(
                  hintText: 'job title',
                  prefixIcon: Icon(
                    Icons.work,
                    color: COLOR_BACKGROUND,
                  ),
                  contentPadding:
                      const EdgeInsets.only(top: 8, bottom: 8, right: 15)),
            ),
          ),
          if (jobTitleValidation.isNotEmpty) errorMessage(jobTitleValidation),
          Spacer(),
          SizedBox(
            height: KTextFieldHeight,
            child: TextFormField(
              initialValue: user.mobile,
              scrollPadding: EdgeInsets.zero,
              textInputAction: TextInputAction.next,
              maxLength: KMobileLength,
              // removes the counter
              buildCounter: (BuildContext context,
                      {int currentLength, int maxLength, bool isFocused}) =>
                  null,
              style: TS_Style,
              keyboardType: TextInputType.number,
              focusNode: _mobileFocusNode,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_birthDateFocusNode);
              },
              decoration: TEXT_FIELD_DECORATION.copyWith(
                prefixIcon: Icon(
                  Icons.phone,
                  color: COLOR_BACKGROUND,
                ),
                hintText: 'mobile',
              ),
              onSaved: (value) => user.setMobile = value,
              validator: validateMobile,
            ),
          ),
          if (mobileValidation.isNotEmpty) errorMessage(mobileValidation),
          Spacer(),
          SizedBox(
            height: KTextFieldHeight,
            child: DateTimeField(
              initialValue: user.birthDate,
              style: TS_Style,
              focusNode: _birthDateFocusNode,
              decoration: TEXT_FIELD_DECORATION.copyWith(
                hintText: 'birth date',
                prefixIcon: Icon(Icons.date_range, color: COLOR_BACKGROUND),
              ),
              onSaved: (value) => user.setBirthDate = value,
              validator: (value) {
                if (value == null) {
                  setState(() =>
                      birtDateValidation = 'please enter your birth date');
                  return '';
                }
                setState(() => birtDateValidation = '');
                return null;
              },
              format: DateFormat("dd/MM/yyyy"),
              resetIcon: null,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ??
                        DateTime.now().subtract(Duration(days: 16 * 365)),
                    lastDate: DateTime.now());
              },
            ),
          ),
          if (birtDateValidation.isNotEmpty) errorMessage(birtDateValidation),
          Spacer(flex: 5),
          Center(
            child: MaterialButton(
                minWidth: 230,
                height: 45,
                color: Color.fromRGBO(40, 49, 230, 1),
                splashColor: Colors.grey.withOpacity(0.5),
                child: Text(
                  'next',
                  style: TextStyle(
                      fontSize: 20, fontFamily: 'pt_sans', color: Colors.white),
                ),
                onPressed: submit),
          ),
          Spacer(flex: 5),
        ],
      ),
    );
  }
}
