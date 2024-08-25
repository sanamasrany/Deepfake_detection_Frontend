import 'dart:convert';
import 'package:deepfake_voice_detection/background_custom.dart';
import 'package:deepfake_voice_detection/utiles.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http ;
class CallService {


  String Callid = '';

  var url1 = Uri.parse('${Utiles.baseurl}/api/calls/create/');
  var url2 = Uri.parse('${Utiles.baseurl}/api/calls/accept-or-decline');

  Future<bool> creatcall (String identifier ) async { // async and await for making any comand after wait till this ends

    SecureStorage storage = SecureStorage();
    String? savedtoken = await storage.read("token");


    var response = await http.post(url1,
        headers:{
          'Authorization' : 'Token ${savedtoken.toString()}',
        },
        body: {
          'identifier': identifier,
        }
    );
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 201) {
      var replay = jsonDecode(response.body);
      Callid = replay['call_id'].toString();
      await storage.save('callid', Callid);

      String? savedcallid = await storage.read("callid");
      print("++++++++++++++++++++++++++++++++");
      print("Iam the host");
      print(savedcallid);
      print("++++++++++++++++++++++++++++++++");

      return true;
    }else {
      showToast(text:"Error" ,state: ToastStates.EROOR);
      return false;
    }
  }


  Future<bool> joincall () async { // async and await for making any comand after wait till this ends

    SecureStorage storage = SecureStorage();
    String? savedtoken = await storage.read("token");


    var response = await http.post(url2,
        headers:{
          'Authorization' : 'Token ${savedtoken.toString()}',
        },
        body: {
          'accept': 'True',
        }
    );
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200) {
      var replay = jsonDecode(response.body);
      Callid = replay['call_id'].toString();
      await storage.save('callid', Callid);

      String? savedcallid = await storage.read("callid");
      print("++++++++++++++++++++++++++++++++");
      print("Iam the guest");
      print(savedcallid);
      print("++++++++++++++++++++++++++++++++");

      return true;
    }
    else if (response.statusCode == 400){
      showToast(text:"No Incoming calles to be accepted or declined!" ,state: ToastStates.EROOR);
      return false;
    }
    else {
      showToast(text:"Error" ,state: ToastStates.EROOR);
      return false;
    }
  }


  Future<bool> closecall () async { // async and await for making any comand after wait till this ends

    SecureStorage storage = SecureStorage();
    String? savedtoken = await storage.read("token");
    String? savedCallid = await storage.read("callid");

    var url3 = Uri.parse('${Utiles.baseurl}/api/calls/close/${savedCallid}');

    var response = await http.patch(url3,
        headers:{
          'Authorization' : 'Token ${savedtoken.toString()}',
        },

    );
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200) {
      var replay = jsonDecode(response.body);
      showToast(text: "call closed", state: ToastStates.SUCCESS);
      return true;
    }else {
      showToast(text:"Error" ,state: ToastStates.EROOR);
      return false;
    }
  }

  var recipientReality = '';
  var callerReality = '';

  Future<bool> checkcall (String audioPath , RxBool ishost) async { // async and await for making any comand after wait till this ends

    SecureStorage storage = SecureStorage();
    String? savedtoken = await storage.read("token");
    String? savedCallid = await storage.read("callid");

    var url4 = Uri.parse('${Utiles.baseurl}/api/calls/voice/check/${savedCallid}');

    var headers = {
      'Authorization' : 'Token ${savedtoken.toString()}',
    };
    var request = http.MultipartRequest('PATCH', url4);

    request.files.add(await http.MultipartFile.fromPath('audio_file', audioPath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print(response.statusCode);


    if(response.statusCode == 200) {
      Map<String,dynamic> replay = jsonDecode(await response.stream.bytesToString());
      recipientReality = replay['recipient_status'];
      callerReality = replay['caller_status'];

      if(ishost.isTrue){
        showToast(text: "${recipientReality}" ,fontsize: 30 ,state: recipientReality == "REAL" ? ToastStates.SUCCESS :ToastStates.EROOR);
      }else{
        showToast(text: "${callerReality}" ,fontsize: 30 ,state: recipientReality == "REAL" ? ToastStates.SUCCESS :ToastStates.EROOR);
      }


      return true;
    }else {
    var  replay = await response.stream.bytesToString();
    print(replay);

      showToast(text:"Error" ,state: ToastStates.EROOR);
      return false;
    }
  }

}