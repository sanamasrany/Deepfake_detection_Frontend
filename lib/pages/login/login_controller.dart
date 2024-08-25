import 'package:deepfake_voice_detection/pages/login/login_service.dart';
import 'package:get/get.dart';

class loginController extends GetxController{


  var identifier='';
  var password='' ;
  var loginStatus = false;

  LoginService service = LoginService();


  Future<void> LoginOnClick() async{

    loginStatus = await service.login( identifier , password); // returns t or f

    // if the back sends me a msg as a list so i can make it a string
    // if (message is List ){
    //   String fix ='';
    //   for(String m in message) {
    //     fix +=m+ '\n';
    //   }
    //   message = fix;
    //
    // }
    // if(password != passwordConfirm){
    //   message = 'make sure of your password';
    //   signupStatus = false;
    // }
  }

}