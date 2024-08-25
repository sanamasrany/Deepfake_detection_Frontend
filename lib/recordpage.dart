import 'dart:io';
import 'package:deepfake_voice_detection/background_custom.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:record/record.dart';

class Recordpage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _Recordpage();
  }


}

class _Recordpage extends State<Recordpage>{

  final AudioRecorder audioRec = AudioRecorder();
  final AudioPlayer audiPl = AudioPlayer();

  bool isRecoding =false;
  bool isPlaying =false;
  String? Recordingpath ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _recordingButten(),
      body: _buildUI(),
    );
  }

Widget   _buildUI(){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
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
          child: Text( isPlaying ? "Stop playing the recoding" : "Start playing the recording",
          style: TextStyle( color: Colors.white),),),
        if(Recordingpath == null) const Text("NO Rcording Found. :("),

      ],),
    );
}
Widget _recordingButten(){
    return FloatingActionButton(
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
        if(await audioRec.hasPermission()){
          final Directory appDocumentsDir= await getApplicationDocumentsDirectory();
          final String filePath = p.join(appDocumentsDir.path, "recording.wav");

          await audioRec.start(const RecordConfig(), path: filePath);

          setState(() {
            isRecoding =true;
            Recordingpath =null;
          });
        }
      }
    } ,child:  Icon(isRecoding? Icons.stop :Icons.mic),);
}
}