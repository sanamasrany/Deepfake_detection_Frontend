import 'dart:io';

import 'package:deepfake_voice_detection/background_custom.dart';
import 'package:deepfake_voice_detection/pages/audio_detection/audio_detection_controller.dart';
import 'package:deepfake_voice_detection/translation/trclass.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_trimmer/flutter_audio_trimmer.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';


class AudioDetectionPage extends StatefulWidget {
  @override
  _AudioDetectionPage createState() => _AudioDetectionPage();
}

class _AudioDetectionPage extends State<AudioDetectionPage> {

  AudioDetectionController controller = Get.find();

  String inputFileView = 'input file path';
  File inputFile = File('');
  RangeValues cutValues = const RangeValues(0, 5);
  int timeFile = 10;
  final player = AudioPlayer();
  bool previewPlay = false;

  final AudioRecorder audioRec = AudioRecorder();
  final AudioPlayer audiPl = AudioPlayer();


  bool isRecoding =false;
  bool isPlaying =false;
  String? Recordingpath ;

  @override
  void dispose() {
    // TODO: implement dispose
    controller.pickinganaudio(false);
    controller.recordinganaudio(false);
    player.stop();
    audiPl.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // floatingActionButton: h(),
        appBar: AppBar(
          backgroundColor: secondBackColor,
        ),
      body: Container(
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
               Text(
                'Pick an Audio file or record one !'.tr,
              style: TextStyle(fontSize: 20,color:sixBackColor, ),
              ),
            SizedBox(height: 20,),
              Obx(()=>
              controller.pickinganaudio.isTrue && controller.recordinganaudio.isFalse?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      newDefaultButton(
                          background: sixBackColor,
                          text: "choose the audio".tr,
                          function: _onPickFile,
                          width: MediaQuery.of(context).size.width *0.5,
                          isAppbar: false
                      ),
                      SizedBox(height: 10,),

                      const Divider(),
                      RangeSlider(
                          activeColor: sixBackColor,
                          inactiveColor: fifthBackColor,
                          values: cutValues,
                          max: timeFile.toDouble(),
                          divisions: timeFile,
                          labels: RangeLabels(
                              _getViewTimeFromCut(cutValues.start.toInt()).toString(),
                              _getViewTimeFromCut(cutValues.end.toInt()).toString()),
                          onChanged: (values) {
                            setState(() => cutValues = values);
                            player.seek(Duration(seconds: cutValues.start.toInt()));
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Start: ${_getViewTimeFromCut(cutValues.start.toInt())}'),
                          IconButton(
                              onPressed: _onPlayPreview,
                              icon:
                              Icon(previewPlay ? Icons.stop_circle : Icons.play_arrow)),
                          Text('End: ${_getViewTimeFromCut(cutValues.end.toInt())}'),
                        ],
                      ),
                      const Divider(),
                      SizedBox(height: 10,),
                      newDefaultButton(
                          background: sixBackColor,
                          text: "Send".tr,
                          //  background: HexColor(green.toString()),
                          function: () async {
                            controller.pickinganaudio(false);
                            player.stop();
                            _onCut();

                          },
                          width: double.infinity,
                          isAppbar: false
                      ),

                    ],
                  )

                  : controller.recordinganaudio.isTrue?
              Column(
                children: [
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
                color: Colors.black87,
              ),),
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
                  const SizedBox(height: 20,),
                  newDefaultButton(

                      background: sixBackColor,
                      text: "Send".tr,
                      //  background: HexColor(green.toString()),
                      function: ()async{

                        audiPl.stop();
                       controller.recordinganaudio(false);
                        await Permission.storage.status;
                        Directory generalDownloadDir = Directory('/storage/emulated/0/Download');
                        File originalFile = File(Recordingpath!);
                        String newPath = '${generalDownloadDir.path}/${originalFile.path.split('/').last}';
                        await originalFile.copy(newPath);

                        controller.audioPath = newPath;
                        onClickSend();
                      },

                      width: double.infinity,
                      isAppbar: false
                  ),
                  ]
              )

                  :
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
              newDefaultButton(
                  background: sixBackColor,
                  text: "Picking".tr,
                  //  background: HexColor(green.toString()),
                  function: (){
                    controller.pickinganaudio(true);
                    controller.recordinganaudio(false);
                  },
                  width: MediaQuery.of(context).size.width *0.4,
                  isAppbar: false
              ),
                    SizedBox(height: 20,),
                    newDefaultButton(
                        background: sixBackColor,
                        text: "Recording".tr,
                        //  background: HexColor(green.toString()),
                        function: (){
                          controller.pickinganaudio(false);
                          controller.recordinganaudio(true);
                        },
                        width: MediaQuery.of(context).size.width *0.4,
                        isAppbar: false
                    ),
                    SizedBox(height: 30,),
                    controller.loadingresults.isTrue ?
                    Center(
                      child: CircularProgressIndicator(color: sixBackColor,),
                    ):
                        Text(''),


                ]
              )

              ),

            ],
          ),
        ),
      ),
    )
    );
  }

  void onClickSend() async {

    await controller.DeepFakeDetectionOnClick();
    if (controller.deepfakedetectionStatus) {
 //     Get.offNamed('/home');
    }else{
      print('error');
    }
  }

  Future<void> _onPickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );
    if (result != null) {
      inputFile = File(result.files.single.path!);
      await player.setFilePath(inputFile.path);
      setState(() {
        timeFile = player.duration!.inSeconds;
        cutValues = RangeValues(0, timeFile.toDouble());
        inputFileView = inputFile.path;
      });
    }
  }

  _getViewTimeFromCut(int index) {
    int minute = index ~/ 60;
    int second = index - minute * 60;
    return "$minute:$second";
  }

  void _onPlayPreview() {
    if (inputFile.path != '') {
      setState(() => previewPlay = !previewPlay);
      if (player.playing) {
        player.stop();
      } else {
        player.seek(Duration(seconds: cutValues.start.toInt()));
        player.play();
      }
    }
  }

  Future<void> _onCut() async {
      if (inputFile != null) {
        Directory directory = await getApplicationSupportDirectory();

        File? trimmedAudioFile = await FlutterAudioTrimmer.trim(
          inputFile: inputFile!,
          outputDirectory: directory,
          fileName: DateTime.now().millisecondsSinceEpoch.toString(),
          fileType: Platform.isAndroid ? AudioFileType.wav : AudioFileType.wav,
          time: AudioTrimTime(
            start:  Duration(seconds: cutValues.start.toInt()),
            end:  Duration(seconds: (cutValues.end.toInt() - cutValues.start.toInt())),
          ),

        );

        setState(() async {


          await Permission.storage.status;
          Directory generalDownloadDir = Directory('/storage/emulated/0/Download');
          File originalFile = trimmedAudioFile! ;
          String newPath = '${generalDownloadDir.path}/${originalFile.path.split('/').last}';
          print("+++++++++++++++++++++++++++++");
          print(newPath);
          await originalFile.copy(newPath);
          controller.audioPath = newPath;
          onClickSend();

        });
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
            child:  Icon(isPlaying? Icons.pause_outlined :Icons.play_arrow_outlined),),
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