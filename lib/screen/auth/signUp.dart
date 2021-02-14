import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../../constants.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const _textFormHeight = 35.0;
  static const _textFormErrorHeight = 50.0;
  static const TS_Style = TextStyle(fontSize: 16, color: Colors.black);

  double _mailFieldHeight;

  double _passwordFieldHeight;
  String nameValidation = "";
  String emailValidation = "";
  String passwordValidation = "";
  String confirmPasswordValidation = "";
  String phoneValidation = "";
  String dateValidation = "";
  final _lastNameFocusNode = FocusNode();
  final _mailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _password2FocusNode = FocusNode();
  final _mobileFocusNode = FocusNode();
  final _ageFocusNode = FocusNode();
  final _genderFocusNode = FocusNode();

  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();

  _changeMailFieldHeight() {
    print(_mailController.value.text.trim() + '_changeMailFieldHeight');
    final isMailValid = _mailValidation(_mailController.value.text.trim());
    if (isMailValid != null)
      setState(() {
        _mailFieldHeight = _textFormErrorHeight;
      });
  }

  String _mailValidation(String value) {
    if (value.isEmpty) {
      setState(() {
        print('empty');
        _mailFieldHeight = _textFormErrorHeight;
      });
      return "Please enter your email address";
    } else if (!isEmail(value)) {
      setState(() {
        _mailFieldHeight = _textFormErrorHeight;
      });
      return "Please enter a valid email address";
    }
    return null;
  }

  bool hidePassword = true;
  var _passwordMatch;
  var _emailCheckIcon;

  //TODO:
  /*
  * Error:
  * - solve setState() inside validation to fix dynamic TextFormField height
  *
  * there's 2 ways
  *   1. using _mailController listening to _changeHeight method
  *   2. using setState() inside validation method
  *
  *
  * - add validation for password2 confirmation
  * - add gender dropDown menu
  * - forget password
  * */

  @override
  void initState() {
    super.initState();
    _mailFieldHeight = _textFormHeight;
    _passwordFieldHeight = _textFormHeight;
    //  _mailController.addListener(_changeMailFieldHeight);
  }

  bool _invalidMail = false;

  @override
  void didChangeDependencies() {
    if (_invalidMail) _mailFieldHeight = _textFormErrorHeight;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _lastNameFocusNode.dispose();
    _mailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _password2FocusNode.dispose();
    _mobileFocusNode.dispose();
    _ageFocusNode.dispose();
    _genderFocusNode.dispose();

    //  _mailController.removeListener(_changeMailFieldHeight);
    _mailController.dispose();
  }

  submit() {
    _formKey.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    final textFormWidth = MediaQuery.of(context).size.width / 2.5;

    return Form(
      key: _formKey,
      //TODO: use SingleChildScrollView or not ?
      //if no, remove children padding
      child: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: _textFormHeight,
              child: TextFormField(
                textInputAction: TextInputAction.next,
                style: TS_Style,
                keyboardType: TextInputType.name,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_lastNameFocusNode);
                },
                validator: (value) {
                  if (value.trim().length < 3) {
                    setState(() {
                      nameValidation = 'too short name';
                    });
                  } else {
                    setState(() {
                      nameValidation = "";
                    });
                  }
                  return null;
                },
                decoration: TEXT_FIELD_DECORATION.copyWith(
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: COLOR_BACKGROUND,
                    ),
                    hintText: 'First name',
                    helperStyle: TextStyle(color: Colors.red, backgroundColor: Colors.red),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
              ),
            ),
            (nameValidation == null)
                ? null
                : Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 15),
                        child: Text(
                          nameValidation,
                          style: TextStyle(color: Colors.red, height: 0),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Spacer()
                    ],
                  ),
            //
            //
            //  SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                height: _mailFieldHeight,
                child: TextFormField(
                  //  controller: _mailController,
                  focusNode: _mailFocusNode,
                  textInputAction: TextInputAction.next,
                  style: TS_Style,
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                  onFieldSubmitted: (value) {
                    if (isEmail(value)) {
                      setState(() {
                        _emailCheckIcon = Icon(Icons.check_sharp, color: Colors.green);
                      });
                    } else
                      setState(() {
                        _invalidMail = true;
                        _emailCheckIcon = Icon(Icons.cancel, color: Colors.red);
                      });
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                  validator: (value) {
                    if (value.trim().length < 3) {
                      setState(() {
                        emailValidation = 'please enter your e-mail';
                      });
                    } else if (!isEmail(value)) {
                      setState(() {
                        emailValidation = "please enter valid email";
                      });
                    }

                    return null;
                  },
                  decoration: TEXT_FIELD_DECORATION.copyWith(
                      prefixIcon: Icon(Icons.mail, color: COLOR_BACKGROUND),
                      hintText: 'Email',
                      errorStyle: TextStyle(height: ERROR_TEXT_STYLE),
                      suffixIcon: _emailCheckIcon),
                ),
              ),
            ),
            (emailValidation == null)
                ? null
                : Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 15),
                        child: Text(
                          emailValidation,
                          style: TextStyle(color: Colors.red, height: 0),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      )
                    ],
                  ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: SizedBox(
                height: _passwordFieldHeight,
                child: TextFormField(
                  // autofocus: false,
                  style: TS_Style,
                  obscureText: hidePassword,
                  focusNode: _passwordFocusNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_password2FocusNode);
                  },

                  decoration: TEXT_FIELD_DECORATION.copyWith(
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: COLOR_BACKGROUND,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: COLOR_BACKGROUND,
                      ),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                    hintText: 'password',
                    errorStyle: TextStyle(height: ERROR_TEXT_STYLE),
                  ),
                  validator: (value) {
                    if (value.trim().length < 3) {
                      setState(() {
                        passwordValidation = 'too short password';
                      });
                    }
                    return null;
                  },
                ),
              ),
            ),
            (passwordValidation == null)
                ? null
                : Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 15),
                        child: Text(
                          passwordValidation,
                          style: TextStyle(color: Colors.red, height: 0),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      )
                    ],
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                height: _textFormHeight,
                child: TextFormField(
                  // autofocus: false,
                  style: TS_Style,
                  obscureText: hidePassword,
                  textInputAction: TextInputAction.next,
                  focusNode: _password2FocusNode,
                  onChanged: (confirm) {},
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_mobileFocusNode);
                  },

                  decoration: TEXT_FIELD_DECORATION.copyWith(
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: COLOR_BACKGROUND,
                    ),
                    suffixIcon: Icon(_passwordMatch),
                    hintText: 'Confirm password',
                  ),
                  validator: (value) {
                    if (value.trim().length < 1) {
                      setState(() {
                        passwordValidation = 'password not match';
                      });
                    }
                    return null;
                  },
                ),
              ),
            ),
            (passwordValidation == null)
                ? null
                : Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 15),
                        child: Text(
                          passwordValidation,
                          style: TextStyle(color: Colors.red, height: 0),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      )
                    ],
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                height: _textFormHeight,
                child: TextFormField(
                  scrollPadding: EdgeInsets.zero,
                  textInputAction: TextInputAction.next,
                  style: TS_Style,
                  keyboardType: TextInputType.number,
                  focusNode: _mobileFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_ageFocusNode);
                  },
                  decoration: TEXT_FIELD_DECORATION.copyWith(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: COLOR_BACKGROUND,
                    ),
                    hintText: 'Mobile',
                  ),
                  validator: (value) {
                    if (value.trim().length != 11) {
                      setState(() {
                        phoneValidation = 'please enter correct phone number';
                      });
                    }
                    return null;
                  },
                ),
              ),
            ),
            (phoneValidation == null)
                ? null
                : Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 15),
                        child: Text(
                          phoneValidation,
                          style: TextStyle(color: Colors.red, height: 0),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      )
                    ],
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: _textFormHeight,
                    width: textFormWidth,
                    child: DateTimeField(
                      focusNode: _ageFocusNode,
                      style: TextStyle(fontSize: 18),
                      decoration: TEXT_FIELD_DECORATION.copyWith(
                          hintText: 'Birth date', prefixIcon: Icon(Icons.date_range, color: COLOR_BACKGROUND)),
                      format: DateFormat("dd-MM-yyyy"),
                      onChanged: (_) {
                        FocusScope.of(context).requestFocus(_genderFocusNode);
                      },
                      resetIcon: null,
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now().subtract(Duration(days: 16 * 365)),
                            lastDate: DateTime.now());
                      },
                    ),
                  ),
                  SizedBox(
                    height: _textFormHeight,
                    width: textFormWidth,
                    child: TextFormField(
                      focusNode: _genderFocusNode,
                      textInputAction: TextInputAction.done,
                      style: TS_Style,
                      decoration: TEXT_FIELD_DECORATION.copyWith(
                        hintText: 'Gender',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
