import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universal_identification_system/constant/image_path.dart';
import 'package:universal_identification_system/constant/preference_manager.dart';
import 'package:universal_identification_system/views/bottom_screen.dart';
import 'package:universal_identification_system/views/log_in_screen.dart';
import 'package:universal_identification_system/views/sign_up_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 4), () {
      PreferenceManager.getLoginStatus() == "true"
          ? Get.offAll(() => BottomBarScreen())
          : Get.offAll(() => const SignUpScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          ImagePath.logoImage,
          height: 196.h,
          width: 375.w,
        ),
      ),
    );
  }
}
