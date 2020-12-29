import 'package:flutter/material.dart';


class UserDataProvider extends ChangeNotifier {

  String _name,
      _email,
      _password,
      _phone,
      _address,
      _accessToken,_animals,_createdAt,_updatedAt,_type;
  int _userId;
  var _image;
  get name => _name;
  get email => _email;
  get password=> _password;
  get phone => _phone;
  get address => _address;
  get image => _image;
  get accessToken =>_accessToken;
  get userId => _userId;
  get animals => _animals;
  get createdAt => _createdAt;
  get updatedAt => _updatedAt;
  get type => _type;


  void setUserMainData (String name,String email, String password , String phone ,String address, var image ){
    _name=name;
    _email=email;
    _password=password;
    _address=address;
    _phone=phone;
    _image =image;
    notifyListeners();
  }


  void setAccessToken (String token){
    _accessToken=token;
    notifyListeners();
  }

}



