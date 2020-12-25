import 'package:flutter/material.dart';

import '../../constants.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  static final _formKey = GlobalKey<FormState>();
  final _passwordFocusScope = FocusNode();

  bool hidePassword = true;

  @override
  void dispose() {
    _passwordFocusScope.dispose();
    super.dispose();
  }

  submit() {
    FocusScope.of(context).unfocus();
    _formKey.currentState.validate();
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