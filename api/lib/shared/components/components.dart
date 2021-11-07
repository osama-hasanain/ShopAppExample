import 'package:api/modual/Login/login.dart';
import 'package:api/shared/network/local/cache_helper.dart';
import 'package:api/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
  TextInputType type = TextInputType.text,
  required String label,
  required Widget prefixIcon,
  bool isPassword = false,
  IconData? suffixIcon,
  required String? Function(String?)? validate,
  Function()? onPasPres,
}){
  return Container(
    child: TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon:prefixIcon,
        suffixIcon: suffixIcon!=null?
        IconButton(onPressed:onPasPres,icon: Icon(suffixIcon))
            :null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      validator: validate,
    ),
  );
}

Widget defaultButton({
  double width = double.infinity,
  double height = 50.0,
  required String text,
  Color color = defultColor,
  bool isUpperCase = true,
  required void Function()? pressed,
}){
  return Container(
    width: width,
    height: height,
    child: MaterialButton(
        child: Text(
            isUpperCase?text.toUpperCase():text.toLowerCase(),
          style: TextStyle(color: Colors.white),
        ),
        color: color,
        onPressed: pressed,
    ),
  );
}

Widget defaultTextButton({
  required Function() onPressed,
  required String text,
}) => TextButton(onPressed: onPressed, child: Text(text.toUpperCase()));

void navigate(context,widget) => Navigator.of(context).push(
  MaterialPageRoute(builder: (context)=>widget),
);

void navigateToAndFinish(context,widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context)=>widget),
    (Route<dynamic> route)=>false,
);

void showToast({
  required String text,
  required ToastState state,
  }) =>  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: selectToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastState {SUCCESS,WARNING,ERROR}

Color selectToastColor(ToastState state){
  late Color color;
  switch(state){
    case ToastState.SUCCESS :
      color = Colors.green;
      break;
    case ToastState.WARNING :
      color = Colors.yellow;
      break;
    case ToastState.ERROR :
      color = Colors.red;
      break;
  }
  return color;
}

void logout(context) {
  CacheHelper.removeKey(key: 'token').then((value) => navigateToAndFinish(context,ShopLoginScreen()));
}