import 'package:flutter/material.dart';
import 'package:project/provider/data_constants.dart';
import 'package:project/provider/room_provider.dart';

import 'package:provider/provider.dart';

import 'signUp1.dart';
import '../../model/http_exception.dart';
import '../../provider/UserData.dart';
import '../../widgets/snackBar.dart';
import '../../constants.dart';

class Login extends StatefulWidget {
  Login({Key key, @required this.whenLoading, @required this.scaffoldKey})
      : super(key: key);

  final Function(bool loading) whenLoading;
  final GlobalKey<ScaffoldState> scaffoldKey;

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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context, listen: false);

    final roomProvider = Provider.of<RoomProvider>(context, listen: false);
    submit() async {
      // user.setMail = 'test@test.com';
      // // user.setPassword = 'Mm1010?';
      // widget.whenLoading(true);
      // await handleRequest(user.signIn, widget.scaffoldKey.currentContext);
      //
      // print('getting current user ...');
      // await handleRequest(user.getCurrentUser, widget.scaffoldKey.currentContext);
      //
      // print('getting user rooms ...');
      // await handleRequest(roomProvider.getUserRooms, widget.scaffoldKey.currentContext);
      //
      // roomProvider.changeRoom(roomProvider.rooms.first.id);
      //
      // //initial loading
      // roomProvider.getUserTeams(reload: true);
      // widget.whenLoading(false);

      //await handleRequest(()=> roomProvider.createTeam('team 2', 'description'), widget.scaffoldKey.currentContext);

      //await user.getCurrentUser();
      //await handleRequest(()=>roomProvider.createRoom('room 2','description'), widget.scaffoldKey.currentContext);
      //await handleRequest(roomProvider.getUserRooms, widget.scaffoldKey.currentContext);

      //await handleRequest(()=> roomProvider.createTeam('team 2', 'description'), widget.scaffoldKey.currentContext);
      //await handleRequest(()=> roomProvider.getRoomTeams(2), widget.scaffoldKey.currentContext);
      // await handleRequest(()=> roomProvider.getRoom(2), widget.scaffoldKey.currentContext);

      // handleRequest(() => roomProvider.changeRoom(roomProvider.rooms.first.id), widget.scaffoldKey.currentContext);
      // print(roomProvider.rooms.first.id);
      // await handleRequest(() => roomProvider.getUserTeams(), widget.scaffoldKey.currentContext);

      FocusScope.of(context).unfocus();
      if (!_formKey.currentState.validate()) return;

      //show loading indicator
      widget.whenLoading(true);

      _formKey.currentState.save();

      await handleRequest(user.signIn, widget.scaffoldKey.currentContext);

      print('getting current user ...');
      await handleRequest(
          user.getCurrentUser, widget.scaffoldKey.currentContext);

      print('getting user rooms ...');
      await handleRequest(
          roomProvider.getUserRooms, widget.scaffoldKey.currentContext);
      //
      roomProvider.changeRoom(roomProvider.rooms.first.id);

    //  initial loading
      roomProvider.getUserTeams(reload: true);
      // await handleRequest(, widget.scaffoldKey.currentContext);
      widget.whenLoading(false);
    }

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
              onSaved: (value) => user.setMail = value,
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
              onSaved: (value) => user.setPassword = value,
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
                splashColor: Colors.grey.withOpacity(0.5),
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
