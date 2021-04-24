import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'signUp1.dart';
import '../../constants.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  static final _formKey = GlobalKey<FormState>();

  final _passwordFocusScope = FocusNode();

  String emailValidation = '';
  String passwordValidation = '';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          SizedBox(
            height: KTextFieldHeight,
            child: TextFormField(
              textInputAction: TextInputAction.next,
              style: TextStyle(fontSize: 16, color: Colors.black),
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocusScope);
              },
              autofocus: false,
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
              ),
            ),
          ),
          if (emailValidation.isNotEmpty) errorMessage(emailValidation),

          Spacer(flex: 1),
          SizedBox(
            height: KTextFieldHeight,
            child: TextFormField(
              style: TextStyle(fontSize: 16, color: Colors.black),
              obscureText: hidePassword,
              textInputAction: TextInputAction.done,
              focusNode: _passwordFocusScope,
              validator: (value) {
                if (value.length < 6) {
                  setState(() => passwordValidation = 'too short password');
                  return '';
                }
                setState(() => passwordValidation = '');
                return null;
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
            ),
          ),
          if (passwordValidation.isNotEmpty) errorMessage(passwordValidation),
          Center(
            child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.white24),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)))),
                child: Text(
                  'Forget Password !',
                  style: TextStyle(color: Colors.white, fontFamily: 'pt_sans'),
                )),
          ),
          // Spacer(flex: 4),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     SizedBox(
          //       width: _buttonSocialWidth,
          //       child: MaterialButton(
          //         padding:
          //             const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          //         color: Colors.red.shade700,
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: [
          //             Image.asset('assets/icons/google_icon.png', height: 30),
          //             Text(
          //               'Google',
          //               style: TextStyle(
          //                   fontFamily: 'pt_sans',
          //                   color: Colors.white,
          //                   fontSize: 18),
          //             )
          //           ],
          //         ),
          //         onPressed: () {},
          //       ),
          //     ),
          //     SizedBox(
          //       width: _buttonSocialWidth,
          //       child: MaterialButton(
          //         padding:
          //             const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
          //         color: Colors.blue.shade800,
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Image.asset('assets/icons/facebook_icon.png',
          //                 height: 30),
          //             Text(
          //               'Facebook',
          //               style: TextStyle(
          //                   fontFamily: 'pt_sans',
          //                   color: Colors.white,
          //                   fontSize: 18),
          //             )
          //           ],
          //         ),
          //         onPressed: () {},
          //       ),
          //     )
          //   ],
          // ),
          Spacer(flex: 7),
          Center(
            child: MaterialButton(
                minWidth: 230,
                height: 45,
                color: Color.fromRGBO(40, 49, 230, 1),
                child: Text(
                  'Log in',
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
