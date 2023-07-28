import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:universal_identification_system/constant/color.dart';
import 'package:universal_identification_system/constant/common_circularIndicator.dart';
import 'package:universal_identification_system/constant/common_snackBar.dart';
import 'package:universal_identification_system/constant/common_textfield.dart';
import 'package:universal_identification_system/constant/preference_manager.dart';
import 'package:universal_identification_system/controller/selector_controller.dart';
import 'package:universal_identification_system/views/Api/api_response.dart';
import 'package:universal_identification_system/views/Api/model/response_model/update_profile_view_model.dart';
import 'package:universal_identification_system/views/Api/view_model/sign_up_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SelectorController selectorController = Get.put(SelectorController());
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final locationController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  void initState() {
    nameController.text = PreferenceManager.getName()??"";
    emailController.text = PreferenceManager.getEmail()??"";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectorController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            leading: GestureDetector(
              child:
                  Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
              onTap: () {
                selectorController.selected(0);
              },
            ),
            title: Text(
              'Profile',
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
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Form(
              key: _key,
              child: Container(

                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      Center(
                        child: Stack(
                          clipBehavior: Clip.antiAlias,
                          children: [
                            Container(
                              height: 104.h,
                              width: 104.w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/images/profile.png'),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 3,
                              right: 3,
                              child: Container(
                                height: 34.h,
                                width: 34.w,
                                decoration: const BoxDecoration(
                                    color: PickColor.secondaryColor,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.edit,
                                  size: 18.sp,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 53.h),
                      CommonTextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                          hintText: 'Enter your name',
                          obscureText: false),
                      SizedBox(height: 19.h),
                      CommonTextFormField(
                          controller: emailController,
                          validator: (value) {
                            RegExp regex1 = RegExp(
                                r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                            if (value!.trim().isEmpty) {
                              return 'This field is required';
                            } else if (!regex1.hasMatch(value)) {
                              return 'please enter valid Email';
                            }
                            return null;
                          },
                          hintText: 'Enter your Email',
                          obscureText: false),
                      SizedBox(height: 19.h),
                      CommonTextFormField(
                          controller: phoneNumberController,
                          validator: (value) {},
                          hintText: 'Enter your Phone Number',
                          obscureText: false),
                      SizedBox(height: 19.h),
                      CommonTextFormField(
                          controller: locationController,
                          validator: (value) {},
                          hintText: 'Enter your location',
                          obscureText: false),
                      SizedBox(height: 88.h),
                      GetBuilder<SignUpViewModel>(
                        builder: (controller) {
                          return controller.apiResponseUpdateProfile.status ==
                                  Status.LOADING
                              ? Center(
                                  child: CommonCircular.showCircularIndicator())
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: PickColor.secondaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.r)),
                                      fixedSize: Size(
                                          MediaQuery.of(context).size.width,
                                          62.h)),
                                  onPressed: () async {
                                    if (_key.currentState!.validate()) {
                                      await controller
                                          .updateProfileViewModel(body: {
                                        'email': emailController.text,
                                        'name': nameController.text,
                                        'password':
                                            PreferenceManager.getPassword(),
                                        'cpassword':
                                            PreferenceManager.getPassword(),
                                      });
                                      print('Enter Complete');

                                      log('controller.apiResponseUpdateProfile.data ==> ${controller.apiResponseUpdateProfile.data}');

                                      if (controller
                                              .apiResponseUpdateProfile.status ==
                                          Status.COMPLETE) {
                                        UpdateProfileViewModel response =
                                            controller
                                                .apiResponseUpdateProfile.data;
                                        if (response.status == "success") {
                                          CommonSnackBar.showSnackBar(
                                              title: 'Update Successfully',
                                              message: response.message);
                                          PreferenceManager.setName(
                                              response.data.name);
                                          PreferenceManager.setEmail(
                                              response.data.email);
                                        } else {
                                          CommonSnackBar.showSnackBar(
                                              title: 'Update Failed',
                                              message: response.message);
                                        }
                                      } else {
                                        CommonSnackBar.showSnackBar(
                                            title: 'Update Failed',
                                            message: 'Please try again');
                                      }
                                    } else {
                                      CommonSnackBar.showSnackBar(
                                          title: 'Update Failed',
                                          message: 'Please enter all details');
                                    }
                                  },
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
