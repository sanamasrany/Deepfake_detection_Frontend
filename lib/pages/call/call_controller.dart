import 'package:deepfake_voice_detection/pages/call/call_service.dart';
import 'package:deepfake_voice_detection/utiles.dart';
import 'package:get/get.dart';

class PreCallController extends GetxController{

  var askfortype = true.obs;
  var isahost = false.obs;
  var guestidentifier='' ;
  var audioPath='';
  var creatcallStatus = false;
  var joincallStatus = false;
  var closecallStatus = false;
  var checkcallStatus = false;
  var savedusername = ''.obs;

  SecureStorage storage = SecureStorage();

   @override
   void onInit() async{
     askfortype(true);
     String? f =  await storage.read("username");
     savedusername("$f");
     super.onInit();
   }

  CallService service = CallService();

  Future<void> CreateCallOnClick() async{
    creatcallStatus = await service.creatcall( guestidentifier); // returns t or f
  }

  Future<void> JoinCallOnClick() async{
    joincallStatus = await service.joincall(); // returns t or f
  }

  Future<void> CloseCallOnClick() async{
    closecallStatus = await service.closecall(); // returns t or f
  }

  Future<void> CheckCallOnCall() async{
    checkcallStatus = await service.checkcall( audioPath ,isahost ); // returns t or f
  }

}