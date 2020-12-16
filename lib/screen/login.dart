import 'package:flutter/material.dart';

const COLOR_BACKGROUND = Color.fromRGBO(37, 36, 42, 1);


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    final _buttonSocialWidth = MediaQuery.of(context).size.width/2.7;
    return Scaffold(
      backgroundColor: COLOR_BACKGROUND,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Spacer(),
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
                          Spacer(),
                          LoginForm(),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: _buttonSocialWidth,
                                child: MaterialButton(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35)),
                                  color: Colors.red.shade700,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/icons/google_icon.png',
                                        height: 30,
                                      ),
                                     // SizedBox(width: 10),
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
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35)),
                                  color: Colors.blue.shade800,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'assets/icons/facebook_icon.png',
                                        height: 30,
                                      ),
                                   //   SizedBox(width: 10),
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
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35)),
                              child: Text(
                                _isLogin ? 'Log in' : 'Sign up',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'pt_sans',
                                    color: Colors.white),
                              ),
                              onPressed: () {}),
                          Text('or',
                              style: TextStyle(
                                  fontFamily: 'pt_sans', color: Colors.white)),
                          MaterialButton(
                              minWidth: 230,
                              height: 45,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35)),
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



class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            // autofocus: false,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.mail,
                color: COLOR_BACKGROUND,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Email',
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 12.0, top: 12.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(25.7),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7),
              ),
            ),
          ),

          SizedBox(height: 20),

          TextFormField(
            // autofocus: false,
            style: TextStyle(fontSize: 18),
            obscureText: hidePassword,
            decoration: InputDecoration(
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
              filled: true,
              fillColor: Colors.white,
              hintText: 'password',
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 12.0, top: 12.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(25.7),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7),
              ),
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
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
