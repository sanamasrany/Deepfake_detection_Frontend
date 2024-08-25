import 'package:deepfake_voice_detection/background_custom.dart';
import 'package:deepfake_voice_detection/pages/home/home_controller.dart';
import 'package:deepfake_voice_detection/translation/trclass.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  homeController controller = Get.find();
  final double horizontalPadding = 40;
  final double verticalPadding = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: h()
      ,  body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: gradientBackground,
          child: SafeArea(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // app bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // menu icon
              GestureDetector(
                onTap: (){
                  Get.toNamed('/profile');
                },
              child:
                  Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.grey[800],
                  ),
              ),

                  // account icon
                  PopupMenuButton(
                      child: Icon(
                          Icons.logout_outlined,
                          size: 40,
                          color: Colors.grey[800],
                        ) ,
                      itemBuilder:
                  (context) => [
                    PopupMenuItem(child: Text("Logout from this Device".tr)
                    ,value: "1",),
                    PopupMenuItem(child: Text("Logout from all Devices".tr)
                    ,value: "2",)
                  ],
                    onSelected: (String newvalue){
                        if(newvalue =="1"){
                          onClickLogout1();
                        }else if (newvalue =="2"){
                          onClickLogout2();
                        }
                    },
                  )

                ],
              ),
            ),

            const SizedBox(height: 20),

            // welcome home
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Welcome >_<".tr,
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
                  ),
                  Obx(
                      ()=>
                          Text(
                            controller.username.toString() ,
                            style: GoogleFonts.bebasNeue(fontSize: 40),
                          ),
                  ),

                ],
              ),
            ),



            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Divider(
                thickness: 1,
                color: Color.fromARGB(255, 204, 204, 204),
              ),
            ),

            const SizedBox(height: 25),

            // smart devices grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                "You should try:".tr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // grid
            Expanded(
              child: GridView(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.1,
                ),
               children: [
                 PickedBox(
                 menuoptionName: "Audio\ndeepfake\ndetection".tr,
                 pickedimage: 'assets/images/identity-theft (1).png',
                 //Icon(Icons.spatial_audio_off_outlined ,color: Colors.white, size: 50,)
                 onClick: () { Get.toNamed('/audiodetection');},
                  ),
                 PickedBox(
                   menuoptionName: "Call\ndeepfake\ndetection".tr,
                   pickedimage: 'assets/images/phone-call.png',
                   //pickedicon: Icon(Icons.spatial_audio_outlined,color: Colors.white, size: 50),
                   onClick: () { Get.toNamed('/precallpage');},
                 ),
                 ]
              ),
            )
          ],
        ),
    ),
        )
    );
  }

  void onClickLogout1() async {

    await controller.LogoutOnClick1();
    if (controller.logoutStatus1) {
      Get.offNamed('/login');
    }else{
      print('error');
    }
  }

  void onClickLogout2() async {

    await controller.LogoutOnClick2();
    if (controller.logoutStatus2) {
      Get.offNamed('/login');
    }else{
      print('error');
    }
  }

}