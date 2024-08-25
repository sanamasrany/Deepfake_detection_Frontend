import 'dart:async';
import 'dart:io';
import 'package:deepfake_voice_detection/background_custom.dart';
import 'package:deepfake_voice_detection/pages/call/call_controller.dart';
import 'package:deepfake_voice_detection/translation/trclass.dart';
import 'package:deepfake_voice_detection/utiles.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:record/record.dart';


final String localuserId = math.Random().nextInt(10000).toString();

class PreCallPage extends StatelessWidget {

  PreCallController controller = Get.find();

  final callIdTextCtrl = TextEditingController();
  final guestidentifer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // floatingActionButton: h()
      appBar: AppBar(
           backgroundColor: secondBackColor,

      ),
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: gradientBackground,
              child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10 ),
      child:
      Obx(()=>
      controller.askfortype.isTrue ?
    Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [

      Text("Is the person calling me".tr,style: TextStyle(fontSize: 30,color:sixBackColor, ),),
      Text("Real or Fake ?!".tr,style: TextStyle(fontSize: 30,color:sixBackColor, ),),
      const  SizedBox(height: 20),
        Container(
          height:MediaQuery.of(context).size.height *0.07 ,
          width: MediaQuery.of(context).size.width * 0.86,
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
      Text("Wanna find out ? \nChoose if you want to Host the call or Join one !".tr
        ,style: TextStyle(
          color: Colors.black,
        ),),
            ))),
      const  SizedBox(height: 34),
      newDefaultButton(
          background: sixBackColor,
          text: "Host the call".tr,
          //  background: HexColor(green.toString()),
          function: (){
            controller.askfortype(false);
            controller.isahost(true);
          },
          width: MediaQuery.of(context).size.width *0.4,
          isAppbar: false
      ),SizedBox(height: 20,),
      newDefaultButton(
          background: sixBackColor,
          text: "Join a call".tr,
          //  background: HexColor(green.toString()),
          function: (){
            controller.askfortype(false);
            controller.isahost(false);
          },
          width: MediaQuery.of(context).size.width *0.4,
          isAppbar: false
      ),

        ]
    )
          : controller.isahost.isTrue ? // is a host
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text("You are the Host".tr,style: TextStyle(fontSize: 30,color:sixBackColor, ),),
          const  SizedBox(height: 20),
          Text("Creat a room id for your call".tr
            ,style: TextStyle(
              color: Colors.black38,
            ),),
          const  SizedBox(height: 34),
          defaultTextField(
              controller:guestidentifer,
              type: TextInputType.emailAddress,
              hint: "your guest Email or Username".tr,
              validate:(value){
                if(value.isEmpty)
                {
                  return "Your call Id must not be empty";
                }
                else{
                  return null;
                }
              },
              prefix:Icons.person_pin),
          const SizedBox(height: 20,),
          defaultTextField(
              controller:callIdTextCtrl,
              type: TextInputType.emailAddress,
              hint: "Room id".tr,
              validate:(value){
                if(value.isEmpty)
                {
                  return "Your call Id must not be empty";
                }
                else{
                  return null;
                }
              },
              prefix:Icons.call_outlined),
          SizedBox(height: 30,),
          newDefaultButton(
              background: sixBackColor,
              text: "Creat".tr,
              //  background: HexColor(green.toString()),
              function: (){
                controller.guestidentifier = guestidentifer.text;
                onClickCreatcall(context);

              },
              width: MediaQuery.of(context).size.width *0.4,
              isAppbar: false
          ),

        ],
      )
          :  // is a guest
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text("You are the Guest".tr,style: TextStyle(fontSize: 30,color:sixBackColor, ),),
          const  SizedBox(height: 20),
          Text("Type the room id that your host gave you".tr
            ,style: TextStyle(
              color: Colors.black38,
            ),),
          const  SizedBox(height: 34),
          defaultTextField(
              controller:callIdTextCtrl,
              type: TextInputType.emailAddress,
              hint: "Room id".tr,
              validate:(value){
                if(value.isEmpty)
                {
                  return "Your call Id must not be empty";
                }
                else{
                  return null;
                }
              },
              prefix:Icons.call_outlined),
          SizedBox(height: 30,),
          newDefaultButton(
              background: sixBackColor,
              text: "Join".tr,
              //  background: HexColor(green.toString()),
              function: (){
                onClickJoincall(context);
              },
              width: MediaQuery.of(context).size.width *0.4,
              isAppbar: false
          ),

        ],
      ),
      ),


          )
      )
    );


  }

  void onClickCreatcall(context) async {
    await controller.CreateCallOnClick();
    if (controller.creatcallStatus) {
      controller.askfortype(true);

      Navigator.push(context, MaterialPageRoute(builder: (context){
        return Callpage(CallId: callIdTextCtrl.text ,Username:  controller.savedusername.value);
      }));
    }else{
      print('error');
    }
  }

  void onClickJoincall(context) async {
    await controller.JoinCallOnClick();
    if (controller.joincallStatus) {
      controller.askfortype(true);
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return Callpage(CallId: callIdTextCtrl.text ,Username:  controller.savedusername.value);
      }));
    }else{
      print('error');
    }
  }


}

//the call page

class Callpage extends StatefulWidget{
  Callpage({required this.CallId , required this.Username});
  final String CallId;
  final String Username;
  @override
  State<StatefulWidget> createState() {
    return _Callpage(CallId: CallId ,Username:  Username);
  }


}

class _Callpage extends State<Callpage>{

  PreCallController controller = Get.find();
  final String CallId;
  final String Username;

  final AudioRecorder audioRec = AudioRecorder();
  final AudioPlayer audiPl = AudioPlayer();

  bool isRecoding =false;
  bool isPlaying =false;
  String? Recordingpath ;
  late Timer _timer;

  _Callpage({required this.CallId, required this.Username});

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      // Start recording for 10 seconds
      if(!isRecoding) {
        await Permission.storage.status;
        if (await audioRec.hasPermission()) {
          final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
          final String filePath = p.join(appDocumentsDir.path, "recording.wav");

          await audioRec.start(
              RecordConfig(encoder: AudioEncoder.wav), path: filePath);

          setState(() {
            isRecoding = true;
            Recordingpath = null;
          });
        }
      }
      // Wait for 10 seconds and then end recording
      Timer(Duration(seconds: 3), () async {
        if(isRecoding){
          String? filepath = await audioRec.stop();

          if(filepath != null){
            setState(() {
              isRecoding = false;
              Recordingpath = filepath;
              print("GO find it here : $Recordingpath");
            });
          }

          await Permission.storage.status;
          Directory generalDownloadDir = Directory('/storage/emulated/0/Download');
          File originalFile = File(Recordingpath!);
          String newPath = '${generalDownloadDir.path}/${originalFile.path.split('/').last}';
          await originalFile.copy(newPath);
          controller.audioPath = newPath;
          onClickCheckcall();

        }

      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: ZegoUIKitPrebuiltCall(
          appID: Utiles.appId,
          appSign:  Utiles.appSignIn,
          userID: localuserId,
          userName: "${Username}",
          callID: CallId,
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
          onDispose:  ()=>{
            controller.isahost.isTrue?
            onClickClosecall() :print("your host ended the call")
          },
        ));
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



  void onClickCheckcall() async {

    await controller.CheckCallOnCall();
    if (controller.checkcallStatus) {
      print("checked toast sent");
    }else{
      print('error');
    }
  }

  void onClickClosecall() async {
    await controller.CloseCallOnClick();
    if (controller.closecallStatus) {
      controller.askfortype(true);
      print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
      print("the call ended");
      print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
    }else{
      print('error');
    }
  }

}