import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToastWidget {
  static void show(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG, //makes it last longer
      gravity: ToastGravity.TOP, //position(Top,center,bottom)
      timeInSecForIosWeb: 3, // iOS/Web duration
      backgroundColor: Colors.green.shade600,
      textColor: Colors.white,
      fontSize: 16.h,
    );
  }
}
