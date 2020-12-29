import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/model/registraion_model.dart';
import 'package:project/dialogs/finish_opertaion.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

// maximum height for TextFormField error text height
//   usually between 0-1
const ERROR_TEXT_STYLE = 0.4;
const COLOR_BACKGROUND = Color.fromRGBO(37, 36, 42, 1);
const PADDING_VERTICAL = 12.0;
// default TextFormField decoration
// ignore: non_constant_identifier_names
final TEXT_FIELD_DECORATION = InputDecoration(
  filled: true,
  errorStyle: TextStyle(
    height: 0,
  ),
  fillColor: Colors.white,
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: const EdgeInsets.only(left: 20, bottom: 0, top: 0),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2),
    borderRadius: BorderRadius.circular(25.7),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(25.7),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.5),
    borderRadius: BorderRadius.circular(25.7),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
    borderRadius: BorderRadius.circular(25.7),
  ),
  // disabledBorder: OutlineInputBorder(
  //   borderSide: BorderSide(color: Colors.white),
  //   borderRadius: BorderRadius.circular(25.7),
  // ),
);

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _buttonSocialWidth = MediaQuery.of(context).size.width / 2.7;

    final GlobalKey<_LoginState> _loginForm = GlobalKey<_LoginState>();
    final GlobalKey<_SignUpState> _signUp = GlobalKey<_SignUpState>();

    return Scaffold(
      backgroundColor: COLOR_BACKGROUND,
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniStartDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: !_isLogin
            ? <Widget>[
                IconButton(
                    splashRadius: 28,
                    iconSize: 40,
                    icon: Image.asset('assets/icons/google_icon.png',
                        color: Colors.red),
                    onPressed: () {}),
                SizedBox(height: 10),
                IconButton(
                    splashRadius: 28,
                    iconSize: 40,
                    icon: Image.asset(
                      'assets/icons/facebook_icon.png',
                      color: Colors.blue.shade700,
                    ),
                    onPressed: () {}),
                SizedBox(height: 20),
              ]
            : [],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                child: Column(
                  children: [
                    Expanded(
                      flex: _isLogin ? 5 : 11,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        //  mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(flex: 1),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              _isLogin ? 'Welcome\nBack' : 'Create\nAccount',
                              style: TextStyle(
                                  fontFamily: 'pt_sans',
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(flex: 1),
                          Expanded(
                            flex: _isLogin ? 4 : 10,
                            child: _isLogin
                                ? Login(key: _loginForm)
                                : SignUp(key: _signUp),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (_isLogin)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: _buttonSocialWidth,
                                  child: MaterialButton(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 12),
                                    color: Colors.red.shade700,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/icons/google_icon.png',
                                          height: 30,
                                        ),
                                        Text(
                                          'Google',
                                          style: TextStyle(
                                              fontFamily: 'pt_sans',
                                              color: Colors.white,
                                              fontSize: 18),
                                        )
                                      ],
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  width: _buttonSocialWidth,
                                  child: MaterialButton(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 14),
                                    color: Colors.blue.shade800,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/icons/facebook_icon.png',
                                          height: 30,
                                        ),
                                        Text(
                                          'Facebook',
                                          style: TextStyle(
                                              fontFamily: 'pt_sans',
                                              color: Colors.white,
                                              fontSize: 18),
                                        )
                                      ],
                                    ),
                                    onPressed: () {},
                                  ),
                                )
                              ],
                            ),
                          MaterialButton(
                              minWidth: 230,
                              height: 45,
                              color: Color.fromRGBO(40, 49, 230, 1),
                              child: Text(
                                _isLogin ? 'Log in' : 'Sign up',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'pt_sans',
                                    color: Colors.white),
                              ),
                              onPressed: () {
                                //calling method from child class
                                _isLogin
                                    ? _loginForm.currentState._submit()
                                    : _signUp.currentState._submit();
                              }),
                          Text('or',
                              style: TextStyle(
                                  fontFamily: 'pt_sans', color: Colors.white)),
                          MaterialButton(
                              minWidth: 230,
                              height: 45,
                              color: Colors.white,
                              child: Text(
                                _isLogin ? 'Sign up' : 'Log in',
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'pt_sans'),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static final _formKey = GlobalKey<FormState>();
  final _passwordFocusScope = FocusNode();

  bool hidePassword = true;

  @override
  void dispose() {
    _passwordFocusScope.dispose();
    super.dispose();
  }

  _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()){
      finishData("g", "G");
    }

    // if (!_formKey.currentState.validate()) {
    //   // Invalid!
    //   return;
    // }
    // _formKey.currentState.save();
    // setState(() {
    //   _isLoading = true;
    // });
    // if (_authMode == AuthMode.Login) {
    //   // Log user in
    // } else {
    //   // Sign user up
    // }
    // setState(() {
    //   _isLoading = false;
    // });
  }
  void finishData(String email, String password ) async {
    var bool = await signIn( email, password,context);


    if (bool) {

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => null, // navigite to home screen if success login
          ),
              (Route route) => false);
    } else {
      print("not");
      Navigator.pop(context);
      successOperation(context,"sorry" , "something went wrong");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            style: TextStyle(fontSize: 18),
            keyboardType: TextInputType.emailAddress,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocusScope);
            },
            autofocus: false,
            validator: (value) {
              if (value.isEmpty)
                return "Please enter your email address";
              else if (!isEmail(value))
                return "Please enter a valid email address";
              //_registerData['email'] = value;
              return null;
            },
            decoration: TEXT_FIELD_DECORATION.copyWith(
              prefixIcon: Icon(
                Icons.mail,
                color: COLOR_BACKGROUND,
              ),
              hintText: 'Email',
              errorStyle: TextStyle(height: 1),
            ),
          ),
          // SizedBox(height: 20),
          TextFormField(
            // autofocus: false,
            style: TextStyle(fontSize: 18),
            obscureText: hidePassword,
            textInputAction: TextInputAction.done,
            focusNode: _passwordFocusScope,
            validator: (value) {
              if (value.length < 8) return 'Password too short';
              //    _registerData['password'] = value;
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
              errorStyle: TextStyle(height: 1),
            ),
          ),
          FlatButton(
              onPressed: () {},
              child: Text(
                'Forget Password !',
                style: TextStyle(color: Colors.white, fontFamily: 'pt_sans'),
              )),
        ],
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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

  _submit() {
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
