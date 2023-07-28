import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:universal_identification_system/constant/color.dart';

class CommonCircular {
  static Center showCircularIndicator() {
    return const Center(
      child: SpinKitFadingCircle(
        color: PickColor.secondaryColor,
        size: 60.0,
      ),
    );
  }

  static void showCircularIndicatorLoader() async {
    return showDialog(
      context: Get.overlayContext!,
      barrierColor: Colors.grey.withOpacity(0.2),
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: SpinKitFadingCircle(
            color: PickColor.secondaryColor,
            size: 60.0,
          ),
        );
      },
    );
  }

  static void hideCircularIndicatorLoader() async {
    return Get.back();
  }
}
