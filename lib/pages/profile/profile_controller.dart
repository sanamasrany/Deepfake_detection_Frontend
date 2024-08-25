import 'package:deepfake_voice_detection/pages/home/home_controller.dart';
import 'package:deepfake_voice_detection/pages/profile/profile_service.dart';
import 'package:deepfake_voice_detection/utiles.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {

   var first_name = ''.obs;
   var last_name = ''.obs;




  @override
  void onInit() async{
   String? f =  await storage.read("first_name");
   String? l =  await storage.read("last_name");
   first_name("$f");
   last_name("$l");
 //   last_name = (await storage.read("last_name"));
    print(first_name);

    super.onInit();
  }

  var first_name_new= '';
  var last_name_new='';

  var password='';
  var editprofileStatus = false;

  var showeditstuff = false.obs;

  ProfileService service = ProfileService();
  SecureStorage storage = SecureStorage();




  Future<void> EditProfileOnClick() async{

    editprofileStatus = await service.Edituserinfo( first_name_new , last_name_new,password); // returns t or f

  }
}