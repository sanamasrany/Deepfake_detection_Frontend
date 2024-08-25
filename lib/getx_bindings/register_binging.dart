import 'package:deepfake_voice_detection/pages/register/register_controller.dart';
import 'package:get/get.dart';

class RegisterPageBinging extends Bindings {
  @override
  void dependencies() {
    Get.put<RegisterController>(RegisterController());
  }

}