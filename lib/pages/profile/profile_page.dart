import 'package:deepfake_voice_detection/background_custom.dart';
import 'package:deepfake_voice_detection/pages/profile/profile_controller.dart';
import 'package:deepfake_voice_detection/translation/trclass.dart';
import 'package:deepfake_voice_detection/utiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProfilePage();
  }

}


class _ProfilePage extends State<ProfilePage>{

  late ProfileController controller;
  late TextEditingController firstnameController;
  late TextEditingController lastnameController;

  var passwordController=TextEditingController();

  @override
  void initState() {
    super.initState();

    // Find the controller after the widget is initialized
    controller = Get.find<ProfileController>();

    // Initialize your TextEditingController with the observable's value
    firstnameController = TextEditingController(text: controller.first_name.value);
    lastnameController = TextEditingController(text: controller.last_name.value);

    ever(controller.first_name, (value) {
      firstnameController.text = value;
    });

    ever(controller.last_name, (value) {
      lastnameController.text = value;
    });
  }

  @override
  void dispose() {
    // Dispose of the controllers to free up resources
    firstnameController.dispose();
    lastnameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //floatingActionButton: h()
    appBar: AppBar(
        backgroundColor: secondBackColor,

      ),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                CircleAvatar(
                  radius: 80,
                  backgroundImage:
                  AssetImage('assets/images/icon1.jpg') ,//
                ) ,

                const  SizedBox(height: 34),

                Obx(()=>

                controller.showeditstuff.isTrue?
                    Column(
                      children: [
                        defaultTextField(
                            controller:firstnameController,
                            type: TextInputType.emailAddress,
                            hint: "First name".tr,
                            validate:(value){
                              if(value.isEmpty)
                              {
                                return "Your email must not be empty";
                              }
                              else{
                                return null;
                              }
                            },
                            prefix:Icons.person_outline),
                        const SizedBox(height: 20,),
                        defaultTextField(
                            controller:lastnameController,
                            type: TextInputType.emailAddress,
                            hint: "Last name".tr,
                            validate:(value){
                              if(value.isEmpty)
                              {
                                return "Your email must not be empty";
                              }
                              else{
                                return null;
                              }
                            },
                            prefix:Icons.person_outline),
                        const SizedBox(height: 20,),
                        defaultTextFieldPassword(
                          controller: passwordController,
                          type: TextInputType.emailAddress,
                          hint: "Your old or new password".tr,
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
                            text: "Save".tr,
                            //  background: HexColor(green.toString()),
                            function: (){
                              controller.first_name_new = firstnameController.text;
                              controller.last_name_new = lastnameController.text;
                              controller.password = passwordController.text;
                              onClickSave();
                            },

                            width: double.infinity,
                            isAppbar: false
                        ),
                      ],
                    )
                    :Column(
                  children: [
                    Text(
                      controller.first_name.value ,
                      style: GoogleFonts.bebasNeue(fontSize: 40),
                    ),
                    const SizedBox(height: 20,),
                    Text(
                      controller.last_name.value ,
                      style: GoogleFonts.bebasNeue(fontSize: 40),
                    ),




                    SizedBox(height: 30,),

                    newDefaultButton(

                        background: sixBackColor,
                        text: "Edit Profile".tr,
                        //  background: HexColor(green.toString()),
                        function: (){
                          controller.showeditstuff(true);
                        },

                        width: double.infinity,
                        isAppbar: false
                    ),
                  ],
                )
                ),


                const  SizedBox(height:5,),


              ],
            ),
          ),
        ),
      ),

    );
  }

  void onClickSave() async {
    await controller.EditProfileOnClick();
    if (controller.editprofileStatus) {
      controller.showeditstuff(false);
      Get.offNamed('/home');
    }else{
      print('error');
    }
  }

}