import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/model/http_exception.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

import '../constants.dart';

const KSignIn = '/auth/signin';
const KSignUp = '/auth/signup';

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
  Future<bool> checkUserName(String calledValue) async {
    bool isUsernameAvailable;

    //wait for a second, is the user finished typing ?
    //if the given value != [_username] this means another instance of this method is called and he will finish the mission
    await Future.delayed(Duration(seconds: 1));
    if (calledValue != _userName) {
      print('scape');
      return false;
    }

    final url = server + '/users/$_userName/exists';
    //try {
    final response = await http.get(Uri.parse(url)).timeout(KTimeOutDuration);
    if (response.statusCode == 200)
      isUsernameAvailable = !json.decode(response.body);
    else
      throw HttpException('connection lost');
    // } catch (e) {
    //   print('checkUserName function error: $e');
    // }
    return isUsernameAvailable;
  }

  Future<void> signUp() => auth(
      KSignUp,
      json.encode({
        "username": _userName,
        "email": _mail,
        "name": _name,
        "password": _password,
        "confirmPassword": _password,
        "phoneNumber": _mobile,
        "jobTitle": _jobTitle,
        "birthDate": '${_birthDate.day}/${_birthDate.month}/${_birthDate.year}'
      }),
      (responseData) => null);

  Future<void> signIn() => auth(
      KSignIn,
      json.encode({"email": _mail, "password": _password}),
      (responseData) => _token = responseData['token']);

  Future<void> auth(String endpoint, String body,
      Function(Map<String, dynamic> responseData) onSuccess) async {
    final url = server + endpoint;

    //try {
    final response = await http
        .post(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: body,
        )
        .timeout(KTimeOutDuration);

    print('status code: ${response.statusCode}');

    final responseData = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      onSuccess(responseData);
      return 'user created successfully';
    } else
      throw HttpException(responseData['errors'][0]);
    //} catch (e) {throw e;}
  }
}
