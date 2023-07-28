import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universal_identification_system/constant/color.dart';
import 'package:universal_identification_system/constant/common_circularIndicator.dart';
import 'package:universal_identification_system/constant/common_snackBar.dart';
import 'package:universal_identification_system/constant/common_textfield.dart';
import 'package:universal_identification_system/constant/preference_manager.dart';
import 'package:universal_identification_system/constant/text_style.dart';
import 'package:universal_identification_system/controller/selector_controller.dart';
import 'package:universal_identification_system/views/Api/api_response.dart';
import 'package:universal_identification_system/views/Api/model/response_model/check_user_status_res_model.dart';
import 'package:universal_identification_system/views/Api/model/response_model/login_response_model.dart';
import 'package:universal_identification_system/views/Api/view_model/sign_up_viewmodel.dart';
import 'package:universal_identification_system/views/forget_password_screen.dart';
import 'package:universal_identification_system/views/sign_up_screen.dart';
import '../constant/image_path.dart';
import 'bottom_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  SelectorController selectorController = Get.put(SelectorController());
  SignUpViewModel loginViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectorController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 50.h),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          ImagePath.logoImage,
                          height: 168.h,
                          width: 322.w,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        'Login',
                        style: loginStyle,
                      ),
                      SizedBox(height: 7.h),
                      Text(
                        'Welcome back!',
                        style: welcomeBack,
                      ),
                      SizedBox(height: 35.h),
                      CommonTextFormField(
                        obscureText: false,
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
                      ),
                      SizedBox(height: 19.h),
                      CommonTextFormField(
                        obscureText: controller.obs,
                        suffixIcon: GestureDetector(
                          child: Icon(controller.obs == false
                              ? Icons.visibility
                              : Icons.visibility_off),
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
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return const ForgetPasswordScreen();
                              }));
                            },
                            child: Text(
                              'Forgot Password?',
                              style: forgetPassword,
                            )),
                      ),
                      SizedBox(height: 15.h),
                      GetBuilder<SignUpViewModel>(
                        builder: (controller) {
                          return controller.apiResponseLogin.status ==
                                      Status.LOADING ||
                                  controller.apiResponseCheckUser.status ==
                                      Status.LOADING
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
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    if (_key.currentState!.validate()) {
                                      await controller.loginViewModel(body: {
                                        'email': emailController.text,
                                        'password': passwordController.text,
                                      });
                                      LoginResponseModel response =
                                          controller.apiResponseLogin.data;
                                      if (controller.apiResponseLogin.status ==
                                          Status.COMPLETE) {
                                        if (response.status == "success") {
                                          PreferenceManager.setName(
                                              response.data["name"].toString());
                                          PreferenceManager.setId(response
                                              .data["user_id"]
                                              .toString());
                                          PreferenceManager.setEmail(
                                              emailController.text);
                                          PreferenceManager.setPassword(
                                              passwordController.text);
                                          PreferenceManager.setCPassword(
                                              passwordController.text);
                                          await controller
                                              .checkUserStatusViewModel(body: {
                                            'email': emailController.text,
                                            'name': response.data["name"],
                                            'password': passwordController.text,
                                            'cpassword':
                                                passwordController.text,
                                          });

                                          if (controller.apiResponseCheckUser
                                                  .status ==
                                              Status.COMPLETE) {
                                            CheckUserStatusResponseModel res =
                                                controller
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
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: Colors.white),
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    emailController
                                                                        .clear();
                                                                    passwordController
                                                                        .clear();

                                                                    Get.back();
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .clear)),
                                                            ),
                                                            Text(
                                                              "Please wait until \nadmin approve \nyour profile ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Get.height *
                                                                          0.03,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            Center(
                                                              child:
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        emailController
                                                                            .clear();
                                                                        passwordController
                                                                            .clear();

                                                                        Get.back();
                                                                      },
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor: PickColor
                                                                              .secondaryColor,
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(6
                                                                                  .r)),
                                                                          fixedSize: Size(
                                                                              MediaQuery.of(context).size.width * 0.25,
                                                                              7.h)),
                                                                      child: Text(
                                                                        "Ok",
                                                                        style: TextStyle(
                                                                            fontSize: Get.height *
                                                                                0.023,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      )),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  Get.height *
                                                                      0.01,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                                  },
                                                );
                                              } else {
                                                CommonSnackBar.showSnackBar(
                                                    title: 'Login failed',
                                                    message: response.message);
                                              }
                                            } else {
                                              PreferenceManager.setLoginStatus(
                                                  "true");
                                              CommonSnackBar.showSnackBar(
                                                  title: 'Login Successfully',
                                                  message: response.message);

                                              emailController.clear();
                                              passwordController.clear();
                                              Get.offAll(
                                                  () => BottomBarScreen(),
                                                  transition: Transition.zoom);
                                            }
                                          } else {
                                            CommonSnackBar.showSnackBar(
                                                title: 'CheckUser Failed',
                                                message: response.message);
                                          }
                                        } else {
                                          CommonSnackBar.showSnackBar(
                                              title: 'Login Failed',
                                              message: response.message);
                                        }
                                      } else {
                                        CommonSnackBar.showSnackBar(
                                            title: 'Login Failed',
                                            message: response.message);
                                      }
                                    } else {
                                      CommonSnackBar.showSnackBar(
                                          title: 'Login Failed',
                                          message:
                                              'Please enter valid email or password');
                                    }
                                  },
                                  child: const Text('Login'),
                                );
                        },
                      ),
                      SizedBox(height: 32.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have an account?',
                            style: haveAccount,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(
                                () => const SignUpScreen(),
                                transition: Transition.zoom,
                              );
                            },
                            child: Text(
                              'Register Now',
                              style: registerNow,
                            ),
                          ),
                        ],
                      ),
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
