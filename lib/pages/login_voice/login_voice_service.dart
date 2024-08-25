import 'dart:convert';
import 'package:deepfake_voice_detection/background_custom.dart';
import 'package:deepfake_voice_detection/utiles.dart';
import 'package:http/http.dart' as http ;
class LoginVoiceService {

  var token;
  String Userid = '';
  var email;
  var last_name;
  var first_name;
  var username;
  var text_generated;


  var url = Uri.parse('${Utiles.baseurl}/api/login-user-voice/');
  var urllogingeneratetxt = Uri.parse('${Utiles.baseurl}/api/text/generate/');

  Future<bool> loginVoice (String identifier , String audioPath) async { // async and await for making any comand after wait till this ends
    print(identifier);
    print(audioPath);


    var request = http.MultipartRequest('POST',
        url);
    request.fields.addAll({
      'identifier': identifier,

    });

    request.files.add(await http.MultipartFile.fromPath('audio_file', audioPath));

    http.StreamedResponse response = await request.send();


    print(response.statusCode);

    if(response.statusCode == 200) {


      Map<String,dynamic> replay = jsonDecode(await response.stream.bytesToString());

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

    }else if (response.statusCode == 403){
      print(await response.stream.bytesToString());
      showToast(text:"Oops , make sure of your email/user name and the record" ,state: ToastStates.EROOR);
      return false;
    }else if (response.statusCode == 400){
      print(await response.stream.bytesToString());
      showToast(text:"Invalid credentials...." ,state: ToastStates.EROOR);
      return false;
    } else {
      var errormasg = await response.stream.bytesToString();
      print(errormasg);
      showToast(text:errormasg.toString() ,state: ToastStates.EROOR);
      return false;
    }
  }


  Future<String> textgenerateloginVoice (String identifier) async {
    // async and await for making any comand after wait till this ends
    print(identifier);

    var response = await http.post(urllogingeneratetxt,

        body: {
          'identifier': identifier,
        }
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201) {
      var replay = jsonDecode(response.body);
      text_generated = replay['data'];
      String decodedText = utf8.decode(text_generated.runes.toList());
      return decodedText;
    }
    else {
      showToast(
          text: "unable to generate the text , check you internet connection please",
          state: ToastStates.EROOR);
      return '';
    }
  }

}