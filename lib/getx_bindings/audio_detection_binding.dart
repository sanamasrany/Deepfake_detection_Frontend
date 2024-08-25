import 'package:deepfake_voice_detection/pages/audio_detection/audio_detection_controller.dart';
import 'package:get/get.dart';

class AudioDetectionPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AudioDetectionController>(AudioDetectionController());
  }

}