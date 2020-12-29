import 'dart:io';
import 'package:dio/dio.dart';

Future<bool> signUp(String firstName,String lastName, String email, String password, image,
    String mobile,birthDate,String city , context) async {
  final response = await Dio().post(
    'url',
    data: FormData.fromMap({
      "first_name": firstName,
      "last_name":lastName,
      "email": email,
      "password": password,
      "mobile": mobile,
      "image": (image==null) ? '' :await MultipartFile.fromFile(image.path,
          filename: image.path.split('/').last),
      "city":city,
      "birthDate":birthDate
    }),
  );
  print(response);
  if (response.statusCode == 200) {


    return true;
  } else {
    return false;
  }
}

Future<bool> signIn( String email, String password, context) async {
  final response = await Dio().post(
    'url',
    data: FormData.fromMap({

      "email": email,
      "password": password,

    }),
  );
  print(response);
  if (response.statusCode == 200) {


    return true;
  } else {
    return false;
  }
}