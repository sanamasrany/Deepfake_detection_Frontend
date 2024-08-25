
import 'package:deepfake_voice_detection/pages/login_voice/login_voice_service.dart';
import 'package:get/get.dart';

class loginVoiceController extends GetxController{


  var identifier='';
  var audioPath='';
  var loginVoiceStatus = false;
  var generated_textlogin='';

  var showrecordeandtxt = false.obs;

  var loadingtext = true.obs;

  LoginVoiceService service = LoginVoiceService();


  Future<void> LoginVoiceOnClick() async{

    loginVoiceStatus = await service.loginVoice( identifier , audioPath); // returns t or f


  }

  Future<void> gettextLoginVoiceOnClick() async{

    generated_textlogin = await service.textgenerateloginVoice( identifier );
    loadingtext(false);
  }

}