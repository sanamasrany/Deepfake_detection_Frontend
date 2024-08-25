import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';



const Color firstBackColor = Color(0xffDEDCDC) ;
const Color secondBackColor = Color(0xffC5BAC4) ;
const Color thirdBackColor = Color(0xff989DAA) ;
const Color fourthBackColor = Color(0xff7B919C) ;
const Color fifthBackColor = Color(0xff57707A) ;
const Color sixBackColor = Color(0xff191D23) ;

const Color white = Color(0xFFFFFFFF) ;
const BoxDecoration gradientBackground = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          firstBackColor,
          secondBackColor,
          thirdBackColor,
          fourthBackColor,
          fifthBackColor,
          sixBackColor
        ],
      tileMode: TileMode.clamp,
    )

);


Widget defaultTextField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  bool isPassword = false,
  required validate,
  String? label,
  String? hint,
  required IconData prefix,
  IconData? suffix,
  Function()?suffixPressed,
  double width = double.infinity,


}) =>
    Container(
        width: width,
    child:
    TextFormField(
      //cursorColor: PharmacyColor,
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        // onFieldSubmitted: onSubmit!(),
        //onChanged: onChange!(),
        validator: validate,
        decoration: InputDecoration(
            contentPadding: EdgeInsetsDirectional.zero,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Color(0xff6C6D72),
              overflow: TextOverflow.visible,
            ),
            isDense: false,
            alignLabelWithHint: false,
            filled: true,
            fillColor: Color(0xffE5E4E2),
            labelText: label,
            hintText: hint,
            focusColor:fifthBackColor,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(35),

            ) ,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10.0,right:10),
              child:   Icon(prefix,color:fifthBackColor,),
            ),
            suffixIcon: IconButton(icon: Icon(suffix,color:fifthBackColor,), onPressed:suffixPressed)

        )));

var secure = true.obs;
Widget defaultTextFieldPassword({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  bool isPassword = true,
  required validate,
  String? label,
  String? hint,
  required IconData prefix,
  IconData? suffix,
  Function()?suffixPressed,


}) =>

    Obx(() =>  TextFormField(
      //cursorColor: PharmacyColor,
        controller: controller,
        keyboardType: type,
        obscureText: secure.value ,
        // onFieldSubmitted: onSubmit!(),
        //onChanged: onChange!(),
        validator: validate,
        decoration: InputDecoration(
            contentPadding: EdgeInsetsDirectional.zero,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Color(0xff6C6D72),
              overflow: TextOverflow.visible,
            ),
            isDense: false,
            alignLabelWithHint: false,
            filled: true,
            fillColor: Color(0xffE5E4E2),
            labelText: label,
            hintText: hint,
            focusColor:fifthBackColor,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(35),

            ) ,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10.0,right:10),
              child:   Icon(prefix,color:fifthBackColor,),
            ),
          suffixIcon:GestureDetector(
            onTap: (){
              secure.value =! secure.value ;

            },
            child:  Icon (
              secure == true ? Icons.visibility : Icons.visibility_off
              ,color:fifthBackColor,
            ),
          ),


        )));


Widget newDefaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isAppbar = true,
  required Function function,
  required String text,
}) =>
    Container(
      height: 47,
      width: width,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(35),
        gradient:LinearGradient(

          begin:  Alignment.topCenter,
          end:Alignment.bottomCenter ,

          colors: [
            fifthBackColor,
            sixBackColor

          ],


        ),
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isAppbar ? text.toUpperCase() : text,
          style:const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.normal
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required VoidCallback? function,
  required String text,
  required Color color,
})=>TextButton(onPressed:function, child:Text(text,
    style:TextStyle(fontSize:14,color:color,fontWeight: FontWeight.bold)));




class PickedBox extends StatelessWidget {
  final String menuoptionName;
  final String pickedimage;
  VoidCallback? onClick;

  PickedBox({
    super.key,
    required this.menuoptionName,
    required this.pickedimage,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child:
      GestureDetector(
        onTap: onClick,
        child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: secondBackColor ,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0 ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // icon
              Image(image:
              AssetImage(pickedimage) ,width: 90,height: 90,),


            ],
          ),
        ),
      ),)

    );
  }
}


void showToast({
  required String text,
  required ToastStates state,
  double fontsize = 25.0,
  int timeinsec = 5,
})=>Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,//ظهور
  timeInSecForIosWeb: timeinsec,
  backgroundColor: chooseToastColor(state),
  textColor: Colors.white,
  fontSize: fontsize,

);
enum ToastStates{
  SUCCESS,EROOR,WARNING
}
Color chooseToastColor(ToastStates state)
{  Color color;
switch(state){
  case ToastStates.SUCCESS:
    color= fourthBackColor;

    break;
  case ToastStates.EROOR:
    color=  Colors.redAccent;
    break;
  case ToastStates.WARNING:
    color=  Colors.amber;
    break;

}
return color;

}

