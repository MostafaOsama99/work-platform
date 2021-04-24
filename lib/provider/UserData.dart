import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../constants.dart';

class UserData extends ChangeNotifier {
  String _name = '';
  String _jobTitle = '';
  String _mobile = '';

  /// nullable
  DateTime _birthDate;

  String _userName = '';
  String _mail = '';
  String _password = '';

  set setName(String value) {
    _name = value;
  }

  set setJobTitle(String value) {
    _jobTitle = value;
  }

  set setMobile(String value) {
    _mobile = value;
  }

  set setBirthDate(DateTime value) {
    _birthDate = value;
  }

  set setUserName(String value) {
    _userName = value;
  }

  set setMail(String value) {
    _mail = value;
  }

  set setPassword(String value) {
    _password = value;
  }

  String get password => _password;

  String get mail => _mail;

  String get userName => _userName;

  DateTime get birthDate => _birthDate;

  String get mobile => _mobile;

  String get jobTitle => _jobTitle;

  String get name => _name;

  String _token;

  ///check if the useName available or not
  Future<bool> checkUserName() async {
    bool isUsernameAvailable;

    final url = server + '/users/$_userName/exists';
    try {
      final response = await http.get(Uri.parse(url));

      // print('statusCode: ${response.statusCode}');
      // print(json.decode(response.body));

      if (response.statusCode == 200)
        isUsernameAvailable = !json.decode(response.body);
    } catch (e) {
      print(e);
    }
    return isUsernameAvailable;
  }

  signUp() async {
    print('signUp called');
    const url = server + '/api/v1/auth/signup';
    String message;

    var temp = {
      "username": _userName,
      "email": _mail,
      "name": _name,
      "password": _password,
      "confirmPassword": _password,
      "phoneNumber": _mobile,
      "jobTitle": _jobTitle,
      "birthDate": '${_birthDate.day}/${_birthDate.month}/${_birthDate.year}'
    };
    print(temp);

    try {
      final response = await Dio().post(url,
          data: FormData.fromMap({
            "username": _userName,
            "email": _mail,
            "name": _name,
            "password": _password,
            "confirmPassword": _password,
            "phoneNumber": _mobile,
            "jobTitle": _jobTitle,
            "birthDate":
                '${_birthDate.day}/${_birthDate.month}/${_birthDate.year}'
          }));

      // final response = await http.post(Uri.parse(url), body: {
      //   "username": _userName,
      //   "email": _mail,
      //   "name": _name,
      //   "password": _password,
      //   "confirmPassword": _password,
      //   "phoneNumber": _mobile,
      //   "jobTitle": _jobTitle,
      //   "birthDate": '${_birthDate.day}/${_birthDate.month}/${_birthDate.year}'
      // });

      print('status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        return 'user created successfully';
      }

      print('response data: ${response.data}');

      // print(response.request);
      // print(response.contentLength);

      //Mm1010?
      // print('body:  ${json.decode(response.body)}');
      // print(response.body);
      //
      // final responseData = json.decode(response.body);
      // if (responseData['errors'] != null) print(responseData['errors']);
      // if (responseData['message'] != null) print(responseData['message']);
      // else {
      // }

    } catch (e) {
      print('exception ***** $e');
    }
  }
}
