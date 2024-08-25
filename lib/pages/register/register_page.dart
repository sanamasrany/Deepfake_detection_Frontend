import 'dart:io';

import 'package:deepfake_voice_detection/background_custom.dart';
import 'package:deepfake_voice_detection/pages/register/register_controller.dart';
import 'package:deepfake_voice_detection/translation/trclass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';


class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _RegisterPage();
  }

}

class _RegisterPage extends State<RegisterPage>{
  var firstnameController=TextEditingController();
  var lastnameController=TextEditingController();
  var usernameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  final AudioRecorder audioRec = AudioRecorder();
  final AudioPlayer audiPl = AudioPlayer();


  bool isRecoding =false;
  bool isPlaying =false;
  String? Recordingpath ;

  RegisterController controller = Get.find();

  @override
  void dispose() {
    // TODO: implement dispose
    audiPl.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // floatingActionButton: h(),
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
                Text("Register".tr,style: TextStyle(fontSize: 45,color:sixBackColor, ),),
                const  SizedBox(height: 20),

                Text("your safest option for voice scamming detection".tr
                  ,style: TextStyle(
                    color: Colors.black54,
                  ),),
                const  SizedBox(height: 34),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      defaultTextField(
                        width: MediaQuery.of(context).size.width *0.42,
                          controller:firstnameController,
                          type: TextInputType.emailAddress,
                          hint: "First name".tr,
                          validate:(value){
                            if(value.isEmpty)
                            {
                              return "Your First name must not be empty";
                            }
                            else{
                              return null;
                            }
                          },
                          prefix:Icons.person_outline),
                      const SizedBox(width: 5,),
                      defaultTextField(
                          width: MediaQuery.of(context).size.width *0.42,
                          controller:lastnameController,
                          type: TextInputType.emailAddress,
                          hint: "Last name".tr,
                          validate:(value){
                            if(value.isEmpty)
                            {
                              return "Your Last name must not be empty";
                            }
                            else{
                              return null;
                            }
                          },
                          prefix:Icons.person_outline),
                    ],
                  ),


                const SizedBox(height: 20,),
                defaultTextField(
                    controller:usernameController,
                    type: TextInputType.emailAddress,
                    hint: "User name".tr,
                    validate:(value){
                      if(value.isEmpty)
                      {
                        return "Your User name must not be empty";
                      }
                      else{
                        return null;
                      }
                    },
                    prefix:Icons.person_pin_outlined),
                const SizedBox(height: 20,),
                defaultTextField(
                    controller:emailController,
                    type: TextInputType.emailAddress,
                    hint: "Email".tr,
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

                const SizedBox(height: 20,),

    Container(
    height:MediaQuery.of(context).size.height *0.11 ,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
    secondBackColor,
    thirdBackColor,
    ],
    tileMode: TileMode.clamp,
    )),
    child:SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
    child:
                Text("Record your voice please :\nyou can hear your voice after recording it .\nyou can repeat this step as many times you wish before sending it !".tr
                  ,style: TextStyle(
                    color: Colors.black54,
                  ),)
    ))),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _recordingButten(),
                    const SizedBox(width: 50,),
                    _buildUI(),
                  ],
                ),
                const SizedBox(height: 10,),
                Text("you can read the text below for the recording :".tr
                  ,style: TextStyle(
                    color: Colors.black38,
                  ),),
                const SizedBox(height: 10,),

                 Obx (() {
                   if (controller.loadingtxt.isTrue) {
                     return Center(
                       child: CircularProgressIndicator(),
                     );
                   }
                   return
                     Container(
                       height:MediaQuery.of(context).size.height *0.15 ,
                   width: MediaQuery.of(context).size.width,
                   decoration: BoxDecoration(gradient: LinearGradient(
                     begin: Alignment.topRight,
                     end: Alignment.bottomLeft,
                     colors: [
                       secondBackColor,
                       thirdBackColor,
                       fourthBackColor,
                     ],
                     tileMode: TileMode.clamp,
                   )),
                   child:SingleChildScrollView(
                   physics: BouncingScrollPhysics(),
                   child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                   child:
                     Text(controller.textdata,
                     textAlign: TextAlign.right
                     , style: TextStyle(
                       color: Colors.black,
                     ),)
                   )));
                 }),
                SizedBox(height: 30,),
                //    ConditionalBuilder(
                //     condition: state is !PharmacyLoadingState ,
                //     builder: (context) =>
                newDefaultButton(

                    background: sixBackColor,
                    text: "Continue".tr,
                    //  background: HexColor(green.toString()),
                    function: ()async{
                      controller.email = emailController.text;
                      controller.password = passwordController.text;
                      controller.first_name = firstnameController.text;
                      controller.last_name = lastnameController.text;
                      controller.username = usernameController.text;


                      await Permission.storage.status;
                      Directory generalDownloadDir = Directory('/storage/emulated/0/Download');
                      File originalFile = File(Recordingpath!);
                      String newPath = '${generalDownloadDir.path}/${originalFile.path.split('/').last}';
                      await originalFile.copy(newPath);

                      print("+++++++++++++++++++++++++++++");
                      print(newPath);
                      print("+++++++++++++++++++++++++++++");
                      controller.audioPath = newPath;


                      onClickContinueregister();
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
                    Text("Already have an account ?".tr,style:TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,

                    ),),
                    defaultTextButton(
                        color: sixBackColor,
                        function:(){
                          Get.offAllNamed('/login');
                        }
                        , text: "Login".tr
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

  void onClickContinueregister() async {

    await controller.RegisterOnClick();
    if (controller.registerStatus) {
      Get.offNamed('/home');
    }else{
      print('error');
    }
  }

  Widget   _buildUI(){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width *.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(Recordingpath != null) MaterialButton(onPressed: () async{
            if(audiPl.playing){
              audiPl.stop();
              setState(() {
                isPlaying = false;
              });
            }else{
              await audiPl.setFilePath(Recordingpath!);
              audiPl.play();
              setState(() {
                isPlaying = true;
              });
            }
          },
            color: fourthBackColor,
            child: Icon(isPlaying? Icons.pause_outlined :Icons.play_arrow_outlined),),
          if(Recordingpath == null)  Text("NO Rcording Found. :(".tr),

        ],),
    );
  }
  Widget _recordingButten(){
    return FloatingActionButton(
      backgroundColor: firstBackColor,
      foregroundColor: fifthBackColor,
      onPressed: ()async{
        if(isRecoding){
          String? filepath = await audioRec.stop();

          if(filepath != null){
            setState(() {
              isRecoding = false;
              Recordingpath = filepath;
              print("GO find it here : $Recordingpath");
            });
          }

        }else{
          await Permission.storage.status;
          if(await audioRec.hasPermission()){
            final Directory appDocumentsDir= await getApplicationDocumentsDirectory();
            final String filePath = p.join(appDocumentsDir.path, "recording.wav");

            await audioRec.start( RecordConfig( encoder: AudioEncoder.wav ), path: filePath);

            setState(() {
              isRecoding =true;
              Recordingpath =null;
            });
          }
        }
      } ,child:  Icon(isRecoding? Icons.stop :Icons.mic),);
  }



}