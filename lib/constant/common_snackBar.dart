import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_identification_system/constant/color.dart';

class CommonSnackBar {
  static void showSnackBar({String? title, message = ''}) {
    Get.showSnackbar(GetBar(
      // title: title,
      titleText: Text(
        title!,
        style: const TextStyle(
            color: PickColor.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w700),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      borderRadius: 8,
      backgroundColor: PickColor.secondaryColor,
      messageText: Text(
        message,
        style: const TextStyle(
            color: PickColor.borderColor,
            fontSize: 13,
            fontWeight: FontWeight.w400),
      ),
      borderColor: PickColor.primaryColor,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 500),
      barBlur: 10,
    ));
  }
}
