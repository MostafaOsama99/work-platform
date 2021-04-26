import 'package:flutter/material.dart';

import 'signUp1.dart';
import 'signUp2.dart';
import 'login.dart';
import '../../constants.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //show login first
  bool _isLogin = true;
  bool _isLoading = false;

  bool _showSignUp1;
  SignUp1 _signUp1;
  SignUp2 _signUp2;

  loading(bool loading) => setState(() => _isLoading = loading);

  @override
  void initState() {
    _showSignUp1 = true;
    _signUp1 = SignUp1(
      onNext: () => setState(() => _showSignUp1 = false),
      key: UniqueKey(),
    );
    _signUp2 = SignUp2(
      key: UniqueKey(),
      scaffoldKey: _scaffoldKey,
      onPrev: () => setState(() => _showSignUp1 = true),
      whenLoading: loading,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _buttonSocialWidth = MediaQuery.of(context).size.width / 2.7;

    final GlobalKey<LoginState> _loginForm = GlobalKey<LoginState>();
    //final GlobalKey<SignUpState> _signUp = GlobalKey<SignUpState>();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: COLOR_BACKGROUND,
      // resizeToAvoidBottomInset: false,
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniStartDocked,
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   //crossAxisAlignment: CrossAxisAlignment.start,
      //   children: !_isLogin
      //       ? <Widget>[
      //           IconButton(
      //               splashRadius: 28,
      //               iconSize: 40,
      //               icon: Image.asset('assets/icons/google_icon.png',
      //                   color: Colors.red),
      //               onPressed: () {}),
      //           SizedBox(height: 10),
      //           IconButton(
      //               splashRadius: 28,
      //               iconSize: 40,
      //               icon: Image.asset(
      //                 'assets/icons/facebook_icon.png',
      //                 color: Colors.blue.shade700,
      //               ),
      //               onPressed: () {}),
      //           SizedBox(height: 20),
      //         ]
      //       : [],
      // ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      //  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _isLogin
                                        ? 'Welcome\nBack'
                                        : 'Create\nAccount',
                                    style: TextStyle(
                                        fontFamily: 'pt_sans',
                                        fontSize: 28,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  MaterialButton(
                                      minWidth: 100,
                                      height: 35,
                                      color: Colors.white,
                                      splashColor: Colors.grey.withOpacity(0.5),
                                      child: Text(
                                        _isLogin ? 'Sign up' : 'Log in',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'pt_sans'),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isLogin = !_isLogin;
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: _isLogin
                              ? Login(
                                  key: _loginForm,
                                  whenLoading: loading,
                                  scaffoldKey: _scaffoldKey,
                                )
                              : _showSignUp1
                                  ? _signUp1
                                  : _signUp2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_isLoading)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.grey.withOpacity(0.1),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
