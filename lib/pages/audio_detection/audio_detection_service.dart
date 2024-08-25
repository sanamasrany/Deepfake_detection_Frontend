import 'dart:convert';

import 'package:deepfake_voice_detection/background_custom.dart';
import 'package:deepfake_voice_detection/utiles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;

class AudioDetectionService {
  var url = Uri.parse('${Utiles.baseurl}/api/check/audio/');
  var Reality ='' ;


  Future<bool> checkaudio (String audioPath ) async { // async and await for making any comand after wait till this ends


    var request = http.MultipartRequest('POST', url);

    request.files.add(await http.MultipartFile.fromPath('audio_file', audioPath));

    http.StreamedResponse response = await request.send();

    print(response.statusCode);


    if(response.statusCode == 200) {
      Map<String,dynamic> replay = jsonDecode(await response.stream.bytesToString());
        Reality = replay['message'];
        showToast(text: "${Reality}" ,fontsize: 30 , timeinsec: 10 ,state: Reality == "this is a real voice" ? ToastStates.SUCCESS :ToastStates.EROOR);

      return true;
    }else {
      showToast(text:"Error" ,state: ToastStates.EROOR);
      return false;
    }
  }

}