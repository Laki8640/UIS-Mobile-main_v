import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:universal_identification_system/constant/color.dart';
import 'package:universal_identification_system/constant/common_textfield.dart';
import 'package:universal_identification_system/views/verify_number_screen.dart';


bool isCheck=false;
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 25.sp),
          onTap: () {Navigator.pop(context);},
        ),
        title: Text(
          'Forgot Password',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            const Text(
              'Enter your email or phone number &\nwill send you instruction on hoe to reset\nit.',
              style: TextStyle(color: Color(0xff686868)),
            ),
            SizedBox(height: 35.h),
            Text(
              'Email',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: Color(0xff313131)),
            ),
            SizedBox(height: 12.h),
            CommonTextFormField(onTap: (){
              setState(() {
                isCheck=false;
              });
              print(isCheck);
            },
              controller: emailController,
              validator: (value) {},
              hintText: 'Enter your email',
              obscureText: false,
            ),
            SizedBox(height: 28.h),
            Center(
              child: Text(
                'or',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: Color(0xff676767)),
              ),
            ),
            SizedBox(height: 28.h),
            Text(
              'Mobile Number',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: Color(0xff313131)),
            ),
            SizedBox(height: 12.h),
            CommonTextFormField(
              onTap: (){
                setState(() {
                  isCheck=true;
                });
                print(isCheck);
              },
              controller: phoneController,
              validator: (value) {},
              hintText: 'Enter your Mobile Number',
              obscureText: false,
            ),
            SizedBox(height: 75.h),
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
                  return  VerifyNumberScreen(data: isCheck==false?emailController.text:phoneController.text,);
                }));
              },
              child: Text(
                'Sent',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
