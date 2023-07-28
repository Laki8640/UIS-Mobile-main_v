import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:universal_identification_system/views/forget_password_screen.dart';
import 'package:universal_identification_system/views/new_password_screen.dart';

import '../constant/color.dart';
import '../constant/text_style.dart';

class VerifyNumberScreen extends StatefulWidget {
  const VerifyNumberScreen({
    Key? key,
    this.data,
  }) : super(key: key);
  final dynamic data;

  @override
  State<VerifyNumberScreen> createState() => _VerifyNumberScreenState();
}

class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 25.sp),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Verifying Number',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            Text(
              'We sent an otp to your ${isCheck == false ? 'Email Address' : 'Phone Number'}\n${widget.data}',
              style: const TextStyle(color: Color(0xff686868)),
            ),
            SizedBox(height: 27.h),
            OtpTextField(
              numberOfFields: 6,
              borderRadius: BorderRadius.circular(10.r),
              keyboardType: TextInputType.number,
              margin: EdgeInsets.symmetric(horizontal: 7.w),
              filled: true,
              fillColor: Color(0xffF6F6F6),
              enabledBorderColor: Colors.grey.shade100,
              cursorColor: PickColor.secondaryColor,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.r),
                      borderSide: BorderSide(color: PickColor.secondaryColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.r),
                      borderSide: BorderSide(color: PickColor.secondaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.r),
                      borderSide: BorderSide(color: PickColor.secondaryColor))),
              borderColor: PickColor.secondaryColor,
              focusedBorderColor: PickColor.secondaryColor,
              textStyle: TextStyle(color: Colors.grey),
              showFieldAsBox: true,
              borderWidth: 1,
              autoFocus: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) {},
            ),
            SizedBox(height: 35.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not yet get?',
                  style: TextStyle(
                    color: PickColor.hintColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 14.sp,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Resend OTP',
                    style: TextStyle(
                      color: PickColor.secondaryColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 120.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: PickColor.secondaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r)),
                  fixedSize: Size(MediaQuery.of(context).size.width, 62.h)),
              onPressed: () {
                // if (_key.currentState!.validate()) {
                //   Get.to(() => BottomBarScreen(),
                //       transition: Transition.zoom);
                // } else {}

                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const NewPasswordScreen();
                }));
              },
              child: Text(
                'Verify',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
