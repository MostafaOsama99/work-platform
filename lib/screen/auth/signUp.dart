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

  double _mailFieldHeight;

  double _passwordFieldHeight;

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
    print(_invalidMail);
    if(_invalidMail)
      _mailFieldHeight = _textFormErrorHeight;
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: PADDING_VERTICAL),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: textFormWidth,
                    height: _textFormHeight,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.name,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_lastNameFocusNode);
                      },
                      validator: (value) {
                        if (value.length < 3) return "";
                        return null;
                      },
                      decoration: TEXT_FIELD_DECORATION.copyWith(
                          prefixIcon: Icon(
                            Icons.person_outline_rounded,
                            color: COLOR_BACKGROUND,
                          ),
                          hintText: 'First name',
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8)),
                    ),
                  ),
                  SizedBox(
                    width: textFormWidth,
                    height: _textFormHeight,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      // style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.name,
                      focusNode: _lastNameFocusNode,
                      validator: (value) {
                        if (value.length < 3) return "";
                        return null;
                      },
                      decoration: TEXT_FIELD_DECORATION.copyWith(
                          hintText: 'Last name',
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8)),
                    ),
                  ),
                ],
              ),
            ),
            //  SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: PADDING_VERTICAL),
              child: SizedBox(
                height: _mailFieldHeight,
                child: TextFormField(
                  //  controller: _mailController,
                  focusNode: _mailFocusNode,
                  textInputAction: TextInputAction.next,
                  //  style: TextStyle(fontSize: 18),
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                  onFieldSubmitted: (value) {
                    if (isEmail(value)) {
                      setState(() {
                        _emailCheckIcon =
                            Icon(Icons.check_sharp, color: Colors.green);
                      });
                    } else
                      setState(() {
                        _invalidMail= true;
                        _emailCheckIcon = Icon(Icons.cancel, color: Colors.red);
                      });
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                  validator: (value) {
                    // return _mailValidation(value);
                    if (value.isEmpty) {
                      setState(() {
                        _invalidMail= true;
                        print(_invalidMail);
                        //_mailFieldHeight = _textFormErrorHeight;
                      });
                      return "Please enter your email address";
                    } else if (!isEmail(value)) {
                      setState(() {
                        _mailFieldHeight = _textFormErrorHeight;
                      });
                      return "Please enter a valid email address";
                    }
                    // if (_mailFieldHeight != _textFormHeight)
                    //   setState(() {
                    //     _mailFieldHeight = _textFormHeight;
                    //   });
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: PADDING_VERTICAL),
              child: SizedBox(
                height: _passwordFieldHeight,
                child: TextFormField(
                  // autofocus: false,
                  style: TextStyle(fontSize: 18),
                  obscureText: hidePassword,
                  focusNode: _passwordFocusNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_password2FocusNode);
                  },
                  validator: (value) {
                    if (value.length < 8) {
                      setState(() {
                        _passwordFieldHeight = _textFormErrorHeight;
                      });
                      return 'Password too short';
                    }
                    // if (_passwordFieldHeight != _textFormHeight)
                    // setState(() {
                    //   _passwordFieldHeight = _textFormHeight;
                    // });
                    return null;
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: PADDING_VERTICAL),
              child: SizedBox(
                height: _textFormHeight,
                child: TextFormField(
                  // autofocus: false,
                  style: TextStyle(fontSize: 18),
                  obscureText: hidePassword,
                  textInputAction: TextInputAction.next,
                  focusNode: _password2FocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_mobileFocusNode);
                  },
                  validator: (value) {
                    if (value.length < 8) return '';
                    return null;
                  },
                  decoration: TEXT_FIELD_DECORATION.copyWith(
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: COLOR_BACKGROUND,
                    ),
                    suffixIcon: Icon(_passwordMatch),
                    hintText: 'Confirm password',
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: PADDING_VERTICAL),
              child: SizedBox(
                height: _textFormHeight,
                child: TextFormField(
                  scrollPadding: EdgeInsets.zero,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 18),
                  keyboardType: TextInputType.number,
                  focusNode: _mobileFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_ageFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) return "";
                    return null;
                  },
                  decoration: TEXT_FIELD_DECORATION.copyWith(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: COLOR_BACKGROUND,
                    ),
                    hintText: 'Mobile',
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: PADDING_VERTICAL),
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
                          hintText: 'Birth date',
                          prefixIcon:
                          Icon(Icons.date_range, color: COLOR_BACKGROUND)),
                      format: DateFormat("dd-MM-yyyy"),
                      onChanged: (_) {
                        FocusScope.of(context).requestFocus(_genderFocusNode);
                      },
                      resetIcon: null,
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ??
                                DateTime.now()
                                    .subtract(Duration(days: 16 * 365)),
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
                      style: TextStyle(fontSize: 18),
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
