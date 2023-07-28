import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universal_identification_system/constant/common_circularIndicator.dart';
import 'package:universal_identification_system/constant/preference_manager.dart';
import 'package:universal_identification_system/controller/selector_controller.dart';
import 'package:universal_identification_system/views/Api/api_response.dart';
import 'package:universal_identification_system/views/Api/model/response_model/check_user_status_res_model.dart';
import 'package:universal_identification_system/views/Api/model/response_model/sign_up_response_model.dart';
import 'package:universal_identification_system/views/Api/view_model/sign_up_viewmodel.dart';
import 'package:universal_identification_system/views/log_in_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constant/color.dart';
import '../constant/common_snackBar.dart';
import '../constant/common_textfield.dart';
import '../constant/image_path.dart';
import '../constant/text_style.dart';
import 'bottom_bar_screen/bottom_bar.dart';
import 'bottom_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  SelectorController selectorController = Get.put(SelectorController());
  SignUpViewModel signUpViewModel = Get.put(SignUpViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectorController>(
      builder: (controller) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 70.h),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        ImagePath.logoImage,
                        height: 168.h,
                        width: 322.w,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      'Sign up',
                      style: TextStyle(
                        color: PickColor.secondaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 26.sp,
                      ),
                    ),
                    SizedBox(height: 34.h),
                    CommonTextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      hintText: 'Enter your name',
                      obscureText: false,
                    ),
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
                      hintText: 'Enter your email',
                      obscureText: false,
                    ),
                    SizedBox(height: 19.h),
                    CommonTextFormField(
                      suffixIcon: GestureDetector(
                        child: controller.obs == false
                            ? const Icon(
                                Icons.visibility,
                                size: 20.00,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                size: 20.00,
                              ),
                        onTap: () {
                          controller.isObscure();
                        },
                      ),
                      controller: passwordController,
                      validator: (password) {
                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                        if (password!.isEmpty) {
                          return 'This field is required';
                        } else if (!regex.hasMatch(password)) {
                          return 'Your password must be at least 8 characters long\n contain at least one number and have a mixture\n of uppercase and lowercase letters.';
                        }
                        return null;
                      },
                      hintText: 'Enter your password',
                      obscureText: controller.obs,
                    ),
                    SizedBox(height: 19.h),
                    CommonTextFormField(
                      controller: confirmPasswordController,
                      suffixIcon: GestureDetector(
                        child: controller.obss == false
                            ? const Icon(
                                Icons.visibility,
                                size: 20.00,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                size: 20.00,
                              ),
                        onTap: () {
                          controller.isObscures();
                        },
                      ),
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'This field is required';
                        } else if (value != passwordController.text) {
                          return 'Confirm Password not match';
                        } else {
                          return null;
                        }
                      },
                      hintText: 'Enter your confirm password',
                      obscureText: controller.obss,
                    ),
                    SizedBox(height: 40.h),
                    GetBuilder<SignUpViewModel>(
                      builder: (signUpController) {
                        return signUpController.apiResponse.status ==
                                Status.LOADING || signUpController.apiResponseCheckUser.status == Status.LOADING
                            ? CommonCircular.showCircularIndicator()
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
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (_key.currentState!.validate()) {
                                    await signUpController
                                        .signUpViewModel(body: {
                                      'email': emailController.text,
                                      'name': nameController.text,
                                      'password': passwordController.text,
                                      'cpassword':
                                          confirmPasswordController.text,
                                    });
                                    print('Enter Complete');
                                    SignUpResponseModel response =
                                        signUpController.apiResponse.data;
                                    print(
                                        '+++++++++ MESSAGE +++++++${response.message}');
                                    if (response.status == "success") {
                                      PreferenceManager.setName(
                                          nameController.text);
                                      PreferenceManager.setId(
                                          response.data["id"].toString());
                                      PreferenceManager.setEmail(
                                          emailController.text);
                                      PreferenceManager.setPassword(
                                          passwordController.text);
                                      PreferenceManager.setCPassword(
                                          confirmPasswordController.text);
                                      // PreferenceManager.setLoginStatus("true");

                                      await signUpController
                                          .checkUserStatusViewModel(body: {
                                        'email': emailController.text,
                                        'name': nameController.text,
                                        'password': passwordController.text,
                                        'cpassword':
                                            confirmPasswordController.text,
                                      });
                                      if (signUpController
                                              .apiResponseCheckUser.status ==
                                          Status.COMPLETE) {
                                        CheckUserStatusResponseModel res =
                                            signUpController
                                                .apiResponseCheckUser.data;
                                        if (res.status == 'fail') {
                                          if (res.message ==
                                              "Please wait until admin approve your profile") {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Center(
                                                    child: Container(
                                                  height: Get.height * 0.4,
                                                  width: Get.width * 0.7,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: Colors.white),
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                emailController
                                                                    .clear();
                                                                passwordController
                                                                    .clear();
                                                                nameController.clear();
                                                                confirmPasswordController.clear();
                                                                Get.back();
                                                              },
                                                              icon: const Icon(
                                                                  Icons.clear)),
                                                        ),
                                                        Text(
                                                          "Please wait until \nadmin approve \nyour profile ",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Get.height *
                                                                      0.03,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Center(
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                emailController
                                                                    .clear();
                                                                passwordController
                                                                    .clear(); nameController.clear();
                                                                confirmPasswordController.clear();
                                                                Get.back();
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      PickColor
                                                                          .secondaryColor,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(6
                                                                              .r)),
                                                                  fixedSize: Size(
                                                                      MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.25,
                                                                      7.h)),
                                                              child: Text(
                                                                "Ok",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        Get.height *
                                                                            0.023,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              )),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.01,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                              },
                                            );
                                          } else {
                                            CommonSnackBar.showSnackBar(
                                                title: 'Register failed',
                                                message: response.message);
                                          }
                                        } else {
                                          PreferenceManager.setLoginStatus(
                                              "true");
                                          CommonSnackBar.showSnackBar(
                                              title: 'Register Successfully',
                                              message: response.message);
                                          nameController.clear();
                                          emailController.clear();
                                          passwordController.clear();
                                          confirmPasswordController.clear();
                                          Get.offAll(() => BottomBarScreen(),
                                              transition: Transition.zoom);
                                        }
                                      } else {
                                        CommonSnackBar.showSnackBar(
                                            title: 'CheckUser Failed',
                                            message: response.message);
                                      }
                                    } else {
                                      CommonSnackBar.showSnackBar(
                                          title: 'Register Failed',
                                          message: response.message);
                                    }
                                  } else if (passwordController.text !=
                                      confirmPasswordController.text) {
                                    CommonSnackBar.showSnackBar(
                                        title: 'Register Failed',
                                        message:
                                            'Password and confirm password mismatch!');
                                  } else {
                                    print('enter 2');

                                    CommonSnackBar.showSnackBar(
                                        title: 'Register Failed',
                                        message:
                                            'Please enter all valid details');
                                  }
                                },
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              );
                      },
                    ),
                    SizedBox(height: 18.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: haveAccount,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => const LogInScreen(),
                                transition: Transition.rightToLeftWithFade);
                          },
                          child: Text(
                            'Login Now',
                            style: loginNow,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
