import 'package:deepfake_voice_detection/getx_bindings/audio_detection_binding.dart';
import 'package:deepfake_voice_detection/getx_bindings/home_binding.dart';
import 'package:deepfake_voice_detection/getx_bindings/login_binding.dart';
import 'package:deepfake_voice_detection/getx_bindings/login_voice_bindings.dart';
import 'package:deepfake_voice_detection/getx_bindings/precall_binding.dart';
import 'package:deepfake_voice_detection/getx_bindings/profile_binding.dart';
import 'package:deepfake_voice_detection/getx_bindings/register_binging.dart';
import 'package:deepfake_voice_detection/pages/audio_detection/audio_detection_page.dart';
import 'package:deepfake_voice_detection/pages/call/call_page.dart';
import 'package:deepfake_voice_detection/pages/home/home_page.dart';
import 'package:deepfake_voice_detection/pages/login/login_page.dart';
import 'package:deepfake_voice_detection/pages/login_voice/login_voice_page.dart';
import 'package:deepfake_voice_detection/pages/profile/profile_page.dart';
import 'package:deepfake_voice_detection/pages/register/register_page.dart';
import 'package:deepfake_voice_detection/translation/translate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



void main() {
  runApp(

      GetMaterialApp( //same as materialapp but for get package ia easier
        initialRoute: '/login', //the page that the prog will start from
        getPages: [
          GetPage(name: '/login' ,page: ()=> LoginPage() , binding: LoginPageBinding() ),
          GetPage(name: '/loginvoice' ,page: ()=> LoginVoicePage() , binding: LoginVoicePageBinding() ),
          GetPage(name: '/register' ,page: ()=> RegisterPage() , binding: RegisterPageBinging() ),
          GetPage(name: '/home' ,page: ()=> HomePage() , binding: HomePageBinding() ),
          GetPage(name: '/profile' ,page: ()=> ProfilePage() , binding: ProfilePageBinding() ),
          GetPage(name: '/precallpage' ,page: ()=> PreCallPage() , binding: PreCallPageBinding() ),
          GetPage(name: '/audiodetection' ,page: ()=> AudioDetectionPage() , binding: AudioDetectionPageBinding() ),
        ],
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        translations: Translation(),
        locale: Locale('en'),
        fallbackLocale: Locale('en'),
        debugShowCheckedModeBanner: false,
      )
  );
}





