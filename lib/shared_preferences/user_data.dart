import 'package:shared_preferences/shared_preferences.dart';


bool loginCheck=false;
void setPrefData (String email,String password) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString("email", email);
  preferences.setString("password",password);


}



