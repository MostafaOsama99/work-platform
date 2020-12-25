import 'package:flutter/material.dart';

import 'signUp.dart';
import 'login.dart';
import '../../constants.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = false;

  @override
  Widget build(BuildContext context) {
    final _buttonSocialWidth = MediaQuery.of(context).size.width / 2.7;

    final GlobalKey<LoginState> _loginForm = GlobalKey<LoginState>();
    final GlobalKey<SignUpState> _signUp = GlobalKey<SignUpState>();

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
                                    ? _loginForm.currentState.submit()
                                    : _signUp.currentState.submit();
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


