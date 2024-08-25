import 'package:deepfake_voice_detection/background_custom.dart';
import 'package:deepfake_voice_detection/pages/login/login_controller.dart';
import 'package:deepfake_voice_detection/translation/trclass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget{

  loginController controller = Get.find(); //find me the controller

  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
floatingActionButton: h(),
      body:Container(
        height:MediaQuery.of(context).size.height ,
        width: MediaQuery.of(context).size.width,
        decoration: gradientBackground,
        child:SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 150),


            child: Column(


              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text("Login".tr,style: TextStyle(fontSize: 45,color:sixBackColor, ),),
                const  SizedBox(height: 20),

                Text("your safest option for voice scamming detection".tr
                  ,style: TextStyle(
                    color: Colors.black54,
                  ),),
                const  SizedBox(height: 34),

                defaultTextField(

                    controller:emailController,
                    type: TextInputType.emailAddress,
                    hint: "Email or User name".tr,
                    validate:(value){
                      if(value.isEmpty)
                      {
                        return "Your email must not be empty";
                      }
                      else{
                        return null;
                      }
                    },
                    prefix:Icons.email_outlined),
                const SizedBox(height: 20,),
                defaultTextFieldPassword(
                  controller: passwordController,
                  type: TextInputType.emailAddress,
                  hint: "Password".tr,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return "Your password must not be empty";
                    }
                    return null;
                  },
                  prefix:Icons.lock_outline,
                ),


                SizedBox(height: 30,),
            //    ConditionalBuilder(
             //     condition: state is !PharmacyLoadingState ,
             //     builder: (context) =>
                      newDefaultButton(

                      background: sixBackColor,
                      text: "Continue".tr,
                      //  background: HexColor(green.toString()),
                      function: (){
                        controller.identifier = emailController.text;
                        controller.password = passwordController.text;
                        onClickContinue();
                      },

                      width: double.infinity,
                      isAppbar: false
                  ),
              //    fallback: (context) =>
              //    const Center(child: CircularProgressIndicator()),
             //   ),
                const  SizedBox(height:10,),

                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children:  [
                    Text("Wanna Login using your voice ?".tr,style:TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,

                    ),),
                    defaultTextButton(
                        color: sixBackColor,
                        function:(){
                          Get.offAllNamed('/loginvoice');
                        }
                        , text: "Voice Login".tr
                    ),


                  ],
                ),
                const  SizedBox(height:10,),
                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children:  [
                    Text("Don`t have an account ?".tr,style:TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,

                    ),),
                  defaultTextButton(
                            color: sixBackColor,
                            function:(){
                              Get.offAllNamed('/register');
                              }
                            , text: "Register".tr
                  ),


                  ],
                ),
                const  SizedBox(height:5,),


              ],
            ),
          ),
        ),
      ),

    );
  }

  void onClickContinue() async {

    await controller.LoginOnClick();
    if (controller.loginStatus) {
      Get.offNamed('/home');
    }else{
      print('error');
    }
  }

 }