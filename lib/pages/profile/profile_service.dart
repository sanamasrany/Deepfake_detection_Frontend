import 'dart:convert';
import 'package:deepfake_voice_detection/background_custom.dart';
import 'package:deepfake_voice_detection/utiles.dart';
import 'package:http/http.dart' as http ;
class ProfileService {


  var last_name1;
  var first_name1;




  Future<bool> Edituserinfo (String first_name , String last_name, String password) async { // async and await for making any comand after wait till this ends
    print(first_name);
    print(last_name);
    print(password);

    SecureStorage storage = SecureStorage();
    String? savedtoken = await storage.read("token");
    String? savedid = await storage.read("userid");

    var url = Uri.parse('${Utiles.baseurl}/api/update-user/${savedid}/');

    var response = await http.patch(url,
        headers:{
          'Authorization' : 'Token ${savedtoken.toString()}',
        },
        body: {
          'first_name': first_name,
          'last_name': last_name,
          'password': password,
        }
    );
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      var replay = jsonDecode(response.body);
      first_name1 = replay['first_name'];
      last_name1 = replay['last_name'];

      //save token to device
      SecureStorage storage = SecureStorage();


      await storage.save('first_name', first_name1);
      await storage.save('last_name', last_name1);

      showToast(text:"Profile Edited Successfully" ,state: ToastStates.SUCCESS);
      return true;
    }else {
      showToast(text:"Error" ,state: ToastStates.EROOR);
      return false;
    }

  }




}