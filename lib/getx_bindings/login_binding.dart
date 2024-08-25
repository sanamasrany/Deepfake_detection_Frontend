import 'package:deepfake_voice_detection/pages/login/login_controller.dart';
import 'package:get/get.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<loginController>(loginController());
  }

}