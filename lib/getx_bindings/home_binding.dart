import 'package:deepfake_voice_detection/pages/home/home_controller.dart';
import 'package:get/get.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<homeController>(homeController());
  }

}