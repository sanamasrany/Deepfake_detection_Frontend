import 'package:deepfake_voice_detection/pages/login_voice/login_voice_controller.dart';
import 'package:get/get.dart';

class LoginVoicePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<loginVoiceController>(loginVoiceController());
  }

}