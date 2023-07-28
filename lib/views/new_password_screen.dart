// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/color.dart';
import '../constant/common_textfield.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final passWordController=TextEditingController();
  final ConfirmPasswordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 25.sp),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'New Password',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            const Text(
              'Set your new password',
              style: TextStyle(color: Color(0xff686868)),
            ),
            SizedBox(height: 35.h),
            CommonTextFormField(
              controller: passWordController,
              validator: (value) {},
              hintText: 'Enter your Password',
              obscureText: false,
            ),
            SizedBox(height: 19.h),
            CommonTextFormField(
              controller: ConfirmPasswordController,
              validator: (value) {},
              hintText: 'Enter your ConfirmPassword',
              obscureText: false,
            ),
            SizedBox(height: 100.h),
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

                // Navigator.push(context,
                //     MaterialPageRoute(builder: (BuildContext context) {
                //       return const VerifyNumberScreen();
                //     }));
              },
              child: Text(
                'Set Password',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
