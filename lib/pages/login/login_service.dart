import 'dart:convert';
import 'package:deepfake_voice_detection/background_custom.dart';
import 'package:deepfake_voice_detection/utiles.dart';
import 'package:http/http.dart' as http ;
class LoginService {

  var token;
  String Userid = '';
  var email;
  var last_name;
  var first_name;
  var username;


  var url = Uri.parse('${Utiles.baseurl}/api/login-user/');

  Future<bool> login (String identifier , String password) async { // async and await for making any comand after wait till this ends
    print(identifier);
    print(password);
    var response = await http.post(url,

        body: {
          'identifier': identifier,
          'password': password,
        }
    );
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      var replay = jsonDecode(response.body);
      token = replay['token'];
      Userid = replay['id'].toString();
      username = replay['username'];
      email = replay['email'];
      first_name = replay['first_name'];
      last_name = replay['last_name'];

      //save token to device
      SecureStorage storage = SecureStorage();

      await storage.save('token', token);
      await storage.save('userid', Userid);
      await storage.save('username', username);
      await storage.save('email', email);
      await storage.save('first_name', first_name);
      await storage.save('last_name', last_name);

      String? savedtoken = await storage.read("token");
      String? savedid= await storage.read("userid");
      print("++++++++++++++++++++++++++++++++++++++++++++++");
      print(savedtoken);
      print(savedid);
      print("++++++++++++++++++++++++++++++++++++++++++++++");

      return true;
    }else if (response.statusCode == 400){
      showToast(text:"make sure of your Password and your Email or Username " ,state: ToastStates.EROOR);
      return false;
    }else {
      showToast(text:"Error" ,state: ToastStates.EROOR);
      return false;
    }
  }

}