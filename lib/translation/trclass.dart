import 'package:deepfake_voice_detection/background_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class h extends StatefulWidget {
  @override
  _h createState()=>_h();


}
class _h extends State<h>{
  bool isarabic= false ;
  @override
  Widget build(BuildContext context) {
    return
      FloatingActionButton(
        backgroundColor: firstBackColor,
        foregroundColor: fifthBackColor,
        onPressed: ()async{
          if(!isarabic){

            setState(() {
              isarabic =true;
            });
            Get.updateLocale(Locale('ar'));

          }else{
            Get.updateLocale(Locale('en'));
            setState(() {
              isarabic =false;
            });
          }

        } ,child:  Icon(Icons.language_outlined),

      );


  }

}