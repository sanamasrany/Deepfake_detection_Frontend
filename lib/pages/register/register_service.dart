import 'dart:convert';
import 'dart:io';
import 'package:deepfake_voice_detection/background_custom.dart';
import 'package:deepfake_voice_detection/utiles.dart';
import 'package:http/http.dart' as http ;
class RegisterService {


  var token1;
  String Userid1 = '';
  var email1;
  var last_name1;
  var first_name1;
  var username1;

  var text_generated;


  var url = Uri.parse('${Utiles.baseurl}/api/create-user/');

  var urltextgeneration = Uri.parse('${Utiles.baseurl}/api/text/generate/public/');

  Future<bool> register  (String username , String password,
  String email , String first_name ,String last_name , String audioPath
      ) async { // async and await for making any comand after wait till this ends


    final file = File(audioPath);
    if (!file.existsSync()) {
      print("UPLOADING FILE NOT EXIST+++++++++++++++++++++++++++++++++++++++++++++++++");
    }else{

      print("UPLOADING FILE EXIST");
    }


    print(username);
    print(password);
    print(email);
    print(first_name);
    print(last_name);
    print(audioPath);

    var request = http.MultipartRequest('POST',
        url);
    request.fields.addAll({
      'username': username,
      'password': password,
      'email': email,
      'first_name': first_name,
      'last_name': last_name
    });

    request.files.add(await http.MultipartFile.fromPath('audio_file', audioPath));

    http.StreamedResponse response = await request.send();


    print(response.statusCode);

    if(response.statusCode == 201) {


      Map<String,dynamic> replay = jsonDecode(await response.stream.bytesToString());

      token1 = replay['token'];
      Userid1 = replay['id'].toString();
      username1 = replay['username'];
      email1 = replay['email'];
      first_name1 = replay['first_name'];
      last_name1 = replay['last_name'];

      //save token to device
      SecureStorage storage = SecureStorage();

      await storage.save('token', token1);
      await storage.save('userid', Userid1);
      await storage.save('username', username1);
      await storage.save('email', email1);
      await storage.save('first_name', first_name1);
      await storage.save('last_name', last_name1);

      String? savedtoken = await storage.read("token");
      String? savedid= await storage.read("userid");
      print("++++++++++++++++++++++++++++++++++++++++++++++");
      print(savedtoken);
      print(savedid);
      print("++++++++++++++++++++++++++++++++++++++++++++++");


      return true;
    }
    else {
      showToast(text:"Error" ,state: ToastStates.EROOR);
      print(await response.stream.bytesToString());
      return false;
    }
  }



  Future<String> getgeneratedtext() async {
    var response = await http.get(urltextgeneration,
    );
    print(response.statusCode);
    print(response.body);

    if(response.statusCode==200){
      var replay = jsonDecode(response.body);
      text_generated = replay['data'];
      String decodedText = utf8.decode(text_generated.runes.toList());
      return decodedText  ;
    }
    else{
      showToast(text:"unable to generate the text , check you internet connection please" ,state: ToastStates.EROOR);
      return '';
    }
  }



}