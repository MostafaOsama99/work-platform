import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'signUp1.dart';
import '../../constants.dart';
import '../../provider/UserData.dart';

class SignUp2 extends StatefulWidget {
  final Function() onPrev;

  SignUp2({Key key, this.onPrev}) : super(key: key);

  @override
  SignUp2State createState() => SignUp2State();
}

class SignUp2State extends State<SignUp2> with TickerProviderStateMixin {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String nameValidation = "";
  String emailValidation = "";
  String passwordValidation = "";
  String confirmPasswordValidation = "";

  final _mailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _password2FocusNode = FocusNode();

  final _mailController = TextEditingController();

  bool hidePassword = true;
  bool userNameAvailable;
  var _passwordMatch;
  var _emailCheckIcon;

  Animation _animation;
  AnimationController _animationController;

  final _passwordController = TextEditingController();

  bool _invalidMail = false;

  bool validatePassword(String value) {
    String pattern =
        r'''^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~\:;\,=+\-\(\)"%\'/_.\?]).{6,}$''';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  showPasswordCredentials() {
    if (_passwordFocusNode.hasFocus)
      _animationController.forward();
    else
      _animationController.reverse();
  }

  @override
  void initState() {
    _passwordFocusNode.addListener(showPasswordCredentials);

    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
        reverseDuration: Duration(milliseconds: 250));
    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutBack,
        reverseCurve: Curves.easeOutCubic);
    //_animationController.value = 1;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _passwordFocusNode.removeListener(showPasswordCredentials);
    _animationController.dispose();

    _mailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _password2FocusNode.dispose();
    _mailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context, listen: false);

    submit() {
      if (!_formKey.currentState.validate()) return;
      _formKey.currentState.save();
      user.setPassword = _passwordController.value.text;
      user.signUp();
    }

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              splashRadius: 18,
              icon: Icon(
                Icons.arrow_back,
                size: 20,
                color: Colors.white,
              ),
              onPressed: () {
                _formKey.currentState.save();
                widget.onPrev();
              }),
          SizedBox(
            height: KTextFieldHeight,
            child: TextFormField(
              initialValue: user.userName,
              textInputAction: TextInputAction.next,
              style: TS_Style,
              keyboardType: TextInputType.name,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_mailFocusNode);
              },
              onSaved: (value) => user.setUserName = value,
              validator: (value) {
                if (value.trim().length < 3) {
                  setState(() => nameValidation = 'too short name');
                  return '';
                } else if (!userNameAvailable) {
                  setState(() => nameValidation = 'username is already taken');
                  return '';
                }
                setState(() => nameValidation = '');
                return null;
              },
              onEditingComplete: () async {
                _formKey.currentState.save();
                userNameAvailable = await user.checkUserName();
                setState(() {
                  userNameAvailable = userNameAvailable;
                });
              },
              decoration: TEXT_FIELD_DECORATION.copyWith(
                  prefixIcon: Icon(
                    Icons.person,
                    color: COLOR_BACKGROUND,
                  ),
                  hintText: '@username',
                  suffixIcon: userNameAvailable != null
                      ? (userNameAvailable
                          ? Icon(Icons.check_sharp, color: Colors.green)
                          : _emailCheckIcon =
                              Icon(Icons.cancel, color: Colors.red))
                      : null),
            ),
          ),
          if (nameValidation.isNotEmpty) errorMessage(nameValidation),
          Spacer(),
          SizedBox(
            height: KTextFieldHeight,
            child: TextFormField(
              initialValue: user.mail,
              focusNode: _mailFocusNode,
              textInputAction: TextInputAction.next,
              style: TS_Style,
              keyboardType: TextInputType.emailAddress,
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
              },
              onSaved: (value) => user.setMail = value,
              onFieldSubmitted: (value) {
                if (isEmail(value)) {
                  setState(() => _emailCheckIcon =
                      Icon(Icons.check_sharp, color: Colors.green));
                  return '';
                } else
                  setState(() {
                    //TODO: _invalidMail = true;
                    _emailCheckIcon = Icon(Icons.cancel, color: Colors.red);
                  });
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
              validator: (value) {
                if (value.trim().length < 3) {
                  setState(() => emailValidation = 'please enter your e-mail');
                  return '';
                } else if (!isEmail(value)) {
                  setState(() => emailValidation = "please enter valid email");
                  return '';
                }
                setState(() => emailValidation = '');
                return null;
              },
              decoration: TEXT_FIELD_DECORATION.copyWith(
                  prefixIcon: Icon(Icons.mail, color: COLOR_BACKGROUND),
                  hintText: 'Email',
                  suffixIcon: _emailCheckIcon),
            ),
          ),
          if (emailValidation.isNotEmpty) errorMessage(emailValidation),
          Spacer(),
          SizeTransition(
            sizeFactor: _animation,
            child: Container(
              //duration: Duration(milliseconds: 200),

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white70),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: Center(
                child: Text(
                  '- at least 1 capital character \n- at least 1 small character\n- at least 1 symbol character\n- at least 1 number character\n- at least 6 digits',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ),
          ),
          SizedBox(
            height: KTextFieldHeight,
            child: TextFormField(
              controller: _passwordController,
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
                  splashRadius: 20,
                  icon: Icon(
                    hidePassword
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                    color: COLOR_BACKGROUND,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
                hintText: 'password',
              ),
              validator: (value) {
                if (value.length < 6) {
                  setState(() => passwordValidation = 'too short password');
                  return '';
                }
                setState(() => passwordValidation = '');
                return null;
              },
              onChanged: (value) {
                if (!validatePassword(value))
                  setState(() =>
                      passwordValidation = "password didn't match credentials");
                else
                  setState(() => passwordValidation = '');
              },
            ),
          ),
          if (passwordValidation.isNotEmpty) errorMessage(passwordValidation),
          Spacer(),
          SizedBox(
            height: KTextFieldHeight,
            child: TextFormField(
              style: TS_Style,
              obscureText: hidePassword,
              textInputAction: TextInputAction.next,
              focusNode: _password2FocusNode,
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
                  setState(
                      () => confirmPasswordValidation = 'password not match');
                  return '';
                }
                setState(() => confirmPasswordValidation = '');
                return null;
              },
            ),
          ),
          if (confirmPasswordValidation.isNotEmpty)
            errorMessage(confirmPasswordValidation),
          Spacer(flex: 5),
          Center(
            child: MaterialButton(
                minWidth: 230,
                height: 45,
                color: Color.fromRGBO(40, 49, 230, 1),
                splashColor: Colors.grey.withOpacity(0.5),
                child: Text(
                  'Sign up',
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
