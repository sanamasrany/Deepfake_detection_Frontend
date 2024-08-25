import 'package:deepfake_voice_detection/pages/register/register_service.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{

  var username='';
  var password='' ;
  var email='';
  var first_name='' ;
  var last_name='';
  var audioPath='' ;
  var loadingtxt = true.obs;
  var textdata = '';

  var registerStatus = false;

  RegisterService service = RegisterService();

  @override
  void onReady() async {
    textdata = await service.getgeneratedtext();

    loadingtxt(false);
    super.onReady();
  }


  Future<void> RegisterOnClick() async{

    registerStatus = await service.register( username ,  password , email,first_name,last_name,audioPath); // returns t or f
  }

}