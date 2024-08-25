import 'dart:convert';
import 'package:deepfake_voice_detection/background_custom.dart';
import 'package:deepfake_voice_detection/utiles.dart';
import 'package:http/http.dart' as http ;
class HomeService {


  var urllogout1 = Uri.parse('${Utiles.baseurl}/api/logout-user/');
  var urllogout2 = Uri.parse('${Utiles.baseurl}/api/logoutall-user/');

  Future<bool> logout1 () async { // async and await for making any comand after wait till this ends

    SecureStorage storage = SecureStorage();
    String? savedtoken = await storage.read("token");
    print("bye bye");
    print(savedtoken);

    var response = await http.post(urllogout1,
        headers:{
         'Authorization' : 'Token ${savedtoken.toString()}',
        },

    );
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 204){
      showToast(text:"Logout Successfully" ,state: ToastStates.SUCCESS);
      return true;
    }else {
      showToast(text:"Error" ,state: ToastStates.EROOR);
      return false;
    }
  }


  Future<bool> logout2 () async { // async and await for making any comand after wait till this ends

    SecureStorage storage = SecureStorage();
    String? savedtoken = await storage.read("token");
    print("bye bye from all");
    print(savedtoken);

    var response = await http.post(urllogout2,
      headers:{
        'Authorization' : 'Token ${savedtoken.toString()}',
      },

    );
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 204){
      showToast(text:"Logout Successfully" ,state: ToastStates.SUCCESS);
      return true;
    }else {
      showToast(text:"Error" ,state: ToastStates.EROOR);
      return false;
    }
  }

}