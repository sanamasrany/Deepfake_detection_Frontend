import 'package:deepfake_voice_detection/pages/call/call_controller.dart';
import 'package:get/get.dart';

class PreCallPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PreCallController>(PreCallController());
  }

}