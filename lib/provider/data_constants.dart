import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/widgets/snackBar.dart';

import '../model/http_exception.dart';

Map<String, String> header = {
  "Content-Type": "application/json",
  // 'Accept': 'application/json',
  // 'Connection': 'Keep-Alive',
  HttpHeaders.authorizationHeader: 'Bearer ' + token
};

const KSignIn = '/auth/signin';
const KSignUp = '/auth/signup';

const KGetUserRoomsEndpoint = '/users/rooms';

const KCreateRoom = '/rooms';

String token;
// = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJ0ZXN0QHRlc3QuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiJiZGNjZWYwNi1iYjczLTQzZWUtOGY2OC01YTVmMjcyZTVkYTEiLCJleHAiOjE2MjA1NjAxMTgsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjQ0MzM2LyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjQ0MzM2LyJ9.g_JIZi3NXAbG9YoYaCqOhIrIbloJk0G2JhGlRdcfbnQ';
// 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJ0ZXN0MUBnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImM5Mjg4ZGQ2LTNlZjEtNGJlYi1iNjE1LTczZTljNDIwMTIxNCIsImV4cCI6MTYyMDM5NTM1MCwiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NDQzMzYvIiwiYXVkIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NDQzMzYvIn0.Feyn_-_EY7gH5cmoZRscgannH-75Jvv6r6DYNMHyVrk';

///this function handles any API request & show snackBar on Exception for Auth now
Future<bool> handleRequest(Function serverRequest, BuildContext context) async {
  try {
    await serverRequest();
    return true;
  } on ServerException catch (e) {
    print('HttpException: $e');
    showSnackBar(e.message, context);
  } on TimeoutException catch (e) {
    // A timeout occurred.
    print('timeout exception: $e');
    showSnackBar('connection lost', context);
  } on SocketException catch (_) {
    print('SocketException: $_');
    showSnackBar('connection lost', context);
  } catch (e) {
    print('*** unhandled exception! ***: $e');
  }
  return false;
}

showSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context)
      .showSnackBar(snackBar(message, Theme.of(context).accentColor));
}
