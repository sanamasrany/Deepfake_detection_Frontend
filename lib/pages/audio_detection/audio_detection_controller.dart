import 'package:deepfake_voice_detection/pages/audio_detection/audio_detection_service.dart';
import 'package:get/get.dart';

class AudioDetectionController extends GetxController{

  var pickinganaudio = false.obs;
  var recordinganaudio = false.obs;
  var audioPath='';
  var deepfakedetectionStatus = false;
  var loadingresults = false.obs;

  AudioDetectionService service = AudioDetectionService();

  @override
  void onInit() {
    pickinganaudio(false);
    recordinganaudio(false);
    super.onInit();
  }

  Future<void> DeepFakeDetectionOnClick() async{
    loadingresults(true);
    deepfakedetectionStatus = await service.checkaudio( audioPath); // returns t or f
    loadingresults(false);
  }


}