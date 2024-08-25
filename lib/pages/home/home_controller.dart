import 'package:deepfake_voice_detection/pages/home/home_service.dart';
import 'package:get/get.dart';
import 'package:deepfake_voice_detection/utiles.dart';

class homeController extends GetxController{

  var username = 'User name'.obs;

  var logoutStatus1 = false;
  var logoutStatus2 = false;

  SecureStorage storage = SecureStorage();
  @override
  void onInit() async{
  String?  name  = await storage.read("username");
  username("$name");

    super.onInit();
  }


  HomeService service = HomeService();

  Future<void> LogoutOnClick1() async{
    logoutStatus1 = await service.logout1(); // returns t or f
  }

  Future<void> LogoutOnClick2() async{
    logoutStatus2 = await service.logout2(); // returns t or f
  }

}