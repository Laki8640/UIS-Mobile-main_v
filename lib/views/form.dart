import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_identification_system/constant/color.dart';
import 'package:universal_identification_system/constant/common_circularIndicator.dart';
import 'package:universal_identification_system/constant/common_snackBar.dart';
import 'package:universal_identification_system/constant/common_textfield.dart';
import 'package:universal_identification_system/constant/preference_manager.dart';
import 'package:universal_identification_system/controller/selector_controller.dart';
import 'package:universal_identification_system/views/Api/api_response.dart';
import 'package:universal_identification_system/views/Api/model/response_model/get_state_response_model.dart';
import 'package:universal_identification_system/views/Api/view_model/form_view_model.dart';
import 'package:universal_identification_system/views/Api/view_model/sign_up_viewmodel.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  /// Form 1 ///
  final nameControllerForm1 = TextEditingController();
  final dateInputForm1 = TextEditingController();
  final placeControllerForm1 = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final numberControllerForm1 = TextEditingController();
  final dateTimeAttachedControllerForm1 = TextEditingController();
  final phoneNumberController = TextEditingController();
  final printedForm1 = TextEditingController();
  final signatureForm1 = TextEditingController();

  String imageBand = "";

  final _key1 = GlobalKey<FormState>();
  final _key2 = GlobalKey<FormState>();
  final _key3 = GlobalKey<FormState>();
  String signature1 = "";
  String signature2 = "";
  String signature3 = "";
  String signature4 = "";
  String signature5 = "";

  XFile? imageBandFile;

  File? signatureFile1;
  File? signatureFile2;
  File? signatureFile3;
  File? signatureFile4;
  File? signatureFile5;

  ///Form 2///
  // final printedForm2 = TextEditingController();
  final directorName = TextEditingController();
  final signatureForm2 = TextEditingController();
  final addressController = TextEditingController();
  final dateInputForm2 = TextEditingController();
  final printedForm2Phase2 = TextEditingController();
  final signatureForm2Phase2 = TextEditingController();
  final dateInputForm2Phase2 = TextEditingController();

  ///Form 3///
  final printedForm3 = TextEditingController();
  final relationShipForm3 = TextEditingController();
  final signatureForm3 = TextEditingController();
  final dateInputForm3 = TextEditingController();
  final printedForm3Phase3 = TextEditingController();
  final signatureForm3Phase3 = TextEditingController();
  final dateInputForm3Phase3 = TextEditingController();

  SelectorController selectorController = Get.put(SelectorController());
  PageController? pageController;
  String? selectedCountryName;
  String? selectedCountryId;
  List<String> countryName = [];

  String? selectedStateName;
  String? selectedStateId;
  List<String> stateName = [];

  // ByteData _img = ByteData(0);
  var color = Colors.red;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();
  SignUpViewModel signUpViewModel = Get.find();

  @override
  void initState() {
    pageController = PageController(
      initialPage: 0,
    );
    getCountryList();
    dateInputForm1.text = "";
    dateInputForm2.text = "";
    dateInputForm2Phase2.text = "";
    dateInputForm3.text = "";
    dateInputForm3Phase3.text = "";
    super.initState();
  }

  int selector = 0;
  List scroll = [0];

  getCountryList() {
    signUpViewModel.country.forEach((element) {
      countryName.add(element.name);
    });
  }

  getStateList() {
    stateName.clear();
    signUpViewModel.state.forEach((element) {
      stateName.add(element.name);
    });

    setState(() {});
  }

  getStates({String countryCode = ''}) async {
    CommonCircular.showCircularIndicatorLoader();
    await signUpViewModel.getStateViewModel(
      body: {
        "email": "${PreferenceManager.getEmail()}",
        "password": PreferenceManager.getPassword()
      },
      countryCode: countryCode,
    );
    signUpViewModel.state.clear();
    stateName.clear();
    if (signUpViewModel.apiResponseStates.status == Status.COMPLETE) {
      StateResponseModel stateResponseModel =
          signUpViewModel.apiResponseStates.data;
      stateResponseModel.data.forEach((element) {
        signUpViewModel.setStates(element);
      });

      getStateList();
      CommonCircular.hideCircularIndicatorLoader();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectorController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            elevation: 0,
            leading: selector == 0
                ? GestureDetector(
                    child: Icon(Icons.arrow_back_ios,
                        color: Colors.black, size: 20.sp),
                    onTap: () {
                      controller.selected(1);
                    },
                  )
                : SizedBox(),
            actions: [
              selector == 2
                  ? Padding(
                      padding: EdgeInsets.only(right: 25.w),
                      child: SvgPicture.asset(
                        'assets/images/preview.svg',
                        height: 37.h,
                        width: 37.w,
                      ),
                    )
                  : SizedBox()
            ],
            title: Text(
              'Form',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.grey.shade100,
          ),
          body: GetBuilder<FormViewModel>(builder: (formController) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: Get.height,
                    width: Get.width,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: List.generate(
                              3,
                              (index) => Expanded(
                                child: Container(
                                  height: 3.h,
                                  width: 123.w,
                                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                                  decoration: BoxDecoration(
                                    color: scroll.contains(index)
                                        ? PickColor.secondaryColor
                                        : const Color(0xffDBDBDB),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Container(
                          height: selector == 0 ? 700.h : 600.h,
                          width: MediaQuery.of(context).size.width,

                          // color: Colors.red,
                          child: PageView(
                            controller: pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            onPageChanged: (value) {
                              setState(() {
                                selector = value;
                                print(selector);
                              });
                              if (scroll.contains(selector)) {
                                print('CONTAIN');
                              } else {
                                scroll.add(selector);
                              }
                              if (scroll.last > selector) {
                                scroll.remove(scroll.last);

                                print('REMOVE DATA $scroll');
                              }

                              print('message=====$scroll');
                            },
                            children: [
                              SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Form(
                                    key: _key1,
                                    child: Column(
                                      children: [
                                        CommonTextFormField(
                                          obscureText: false,
                                          controller: nameControllerForm1,
                                          validator: (value) {
                                            if (value!.trim().isEmpty) {
                                              return 'This field is required';
                                            }
                                            return null;
                                          },
                                          hintText: 'Name of the Deceased',
                                        ),
                                        SizedBox(height: 14.h),
                                        GestureDetector(
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101));
                                            if (pickedDate != null) {
                                              print(pickedDate);
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                              print(formattedDate);

                                              setState(() {
                                                dateInputForm1.text =
                                                    formattedDate;
                                              });
                                            } else {
                                              print("Date is not selected");
                                            }
                                          },
                                          child: TextFormField(
                                            controller: dateInputForm1,
                                            enabled: false,
                                            maxLines: 1,
                                            validator: (value) {
                                              if (value!.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              disabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: PickColor
                                                              .borderColor)),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 15.h,
                                                      horizontal: 19.w),
                                              suffixIcon: const Icon(
                                                  Icons.calendar_today_outlined,
                                                  size: 20,
                                                  color: Color(0xff555555)),
                                              filled: true,
                                              fillColor: PickColor.fillColor,
                                              hintText: 'Date of Death',
                                              hintStyle: TextStyle(
                                                  color: PickColor.hintColor,
                                                  fontSize: 14.sp),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  borderSide: const BorderSide(
                                                      color: PickColor
                                                          .borderColor)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  borderSide: const BorderSide(
                                                      color: PickColor
                                                          .borderColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  borderSide: BorderSide(
                                                      color: Colors.red)),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.r),
                                                      borderSide: BorderSide(
                                                          color: Colors.red)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 14.h),
                                        Container(
                                          height: Get.height * 0.06,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                              color: PickColor.fillColor,
                                              border: Border.all(
                                                  color:
                                                      PickColor.borderColor)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            child: DropdownButton<String>(
                                              hint: Text("Select Country",
                                                  style: TextStyle(
                                                      color:
                                                          PickColor.hintColor,
                                                      fontSize: 14.sp)),
                                              isExpanded: true,
                                              value: selectedCountryName,
                                              underline: SizedBox(),
                                              items: countryName
                                                  .map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (String? value) {
                                                log('name--->${value!}');

                                                setState(() {
                                                  selectedCountryName = value;

                                                  signUpViewModel.country
                                                      .forEach((element) {
                                                    log('element.id.toString();-------->>>>>>${element.id.toString()}');
                                                    if (element.name == value) {
                                                      selectedCountryId =
                                                          element.id.toString();
                                                    }
                                                  });

                                                  selectedStateName = null;
                                                  selectedStateId = null;

                                                  setState(() {});
                                                  log("selectedCountryId===>${selectedCountryId}");
                                                  log("selectedCountryName===>${selectedCountryName}");
                                                  if ((selectedCountryId ?? '')
                                                      .isNotEmpty) {
                                                    getStates(
                                                        countryCode:
                                                            selectedCountryId ??
                                                                '');
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 14.h),

                                        Container(
                                          height: Get.height * 0.06,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                              color: PickColor.fillColor,
                                              border: Border.all(
                                                  color:
                                                      PickColor.borderColor)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            child: DropdownButton<String>(
                                              hint: Text("Select State",
                                                  style: TextStyle(
                                                      color:
                                                          PickColor.hintColor,
                                                      fontSize: 14.sp)),
                                              isExpanded: true,
                                              value: selectedStateName,
                                              underline: SizedBox(),
                                              items:
                                                  stateName.map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (String? value) {
                                                log('State name--->${value!}');

                                                setState(() {
                                                  selectedStateName = value;

                                                  signUpViewModel.state
                                                      .forEach((element) {
                                                    log('element.id.toString();-------->>>>>>${element.id.toString()}');
                                                    if (element.name == value) {
                                                      selectedStateId =
                                                          element.id.toString();
                                                    }
                                                  });

                                                  setState(() {});
                                                  log("selectedStateId===>${selectedStateId}");
                                                });
                                              },
                                            ),
                                          ),
                                        ),

                                        // CommonTextFormField(
                                        //   obscureText: false,
                                        //   controller: stateController,
                                        //   validator: (value) {
                                        //     if (value!.trim().isEmpty) {
                                        //       return 'This field is required';
                                        //     }
                                        //     return null;
                                        //   },
                                        //   hintText: 'Enter state',
                                        // ),
                                        SizedBox(height: 14.h),
                                        // CommonTextFormField(
                                        //   obscureText: false,
                                        //   controller: cityController,
                                        //   validator: (value) {
                                        //     if (value!.trim().isEmpty) {
                                        //       return 'This field is required';
                                        //     }
                                        //     return null;
                                        //   },
                                        //   hintText: 'Enter city',
                                        // ),
                                        // SizedBox(height: 14.h),
                                        CommonTextFormField(
                                          obscureText: false,
                                          controller: placeControllerForm1,
                                          validator: (value) {
                                            if (value!.trim().isEmpty) {
                                              return 'This field is required';
                                            }
                                            return null;
                                          },
                                          hintText: 'Place Of Death',
                                        ),
                                        SizedBox(height: 14.h),
                                        // CommonTextFormField(
                                        //   obscureText: false,
                                        //   controller: numberControllerForm1,
                                        //   validator: (value) {
                                        //     if (value!.trim().isEmpty) {
                                        //       return 'This field is required';
                                        //     }
                                        //     return null;
                                        //   },
                                        //   hintText: 'Number on the UIS Bracelet',
                                        // ),
                                        // SizedBox(height: 14.h),
                                        // CommonTextFormField(
                                        //   obscureText: false,
                                        //   controller: dateTimeAttachedControllerForm1,
                                        //   validator: (value) {
                                        //     if (value!.trim().isEmpty) {
                                        //       return 'This field is required';
                                        //     }
                                        //     return null;
                                        //   },
                                        //   hintText: 'Date/Time Attached',
                                        // ),
                                        GestureDetector(
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101));
                                            if (pickedDate != null) {
                                              print(pickedDate);
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                              print(formattedDate);
                                              TimeOfDay selectedTime =
                                                  TimeOfDay(
                                                      hour: 00, minute: 00);
                                              final TimeOfDay? picked =
                                                  await showTimePicker(
                                                context: context,
                                                initialTime: selectedTime,
                                              );
                                              if (picked!.hour
                                                  .toString()
                                                  .isNotEmpty) {
                                                setState(() {
                                                  dateTimeAttachedControllerForm1
                                                          .text =
                                                      "$formattedDate ${picked.hour}:${picked.minute}:00";
                                                });
                                              }

                                              log('picked---->${dateTimeAttachedControllerForm1.text}');
                                            } else {
                                              print("Date is not selected");
                                            }
                                          },
                                          child: TextFormField(
                                            controller:
                                                dateTimeAttachedControllerForm1,
                                            enabled: false,
                                            maxLines: 1,
                                            validator: (value) {
                                              if (value!.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              disabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: PickColor
                                                              .borderColor)),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 15.h,
                                                      horizontal: 19.w),
                                              suffixIcon: const Icon(
                                                  Icons.calendar_today_outlined,
                                                  size: 20,
                                                  color: Color(0xff555555)),
                                              filled: true,
                                              fillColor: PickColor.fillColor,
                                              hintText: 'Date of Death',
                                              hintStyle: TextStyle(
                                                  color: PickColor.hintColor,
                                                  fontSize: 14.sp),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  borderSide: const BorderSide(
                                                      color: PickColor
                                                          .borderColor)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  borderSide: const BorderSide(
                                                      color: PickColor
                                                          .borderColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  borderSide: BorderSide(
                                                      color: Colors.red)),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.r),
                                                      borderSide: BorderSide(
                                                          color: Colors.red)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 32.h),
                                        Text(
                                          'Name of Person Securing the UIS on the Deceased (Place the Bracelet on the ankle of the deceased)',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 14.h),
                                        TextFormField(
                                          controller: phoneNumberController,
                                          keyboardType: TextInputType.phone,
                                          validator: (value) {
                                            if (value!.trim().isEmpty) {
                                              return 'This field is required';
                                            } else {
                                              return null;
                                            }
                                          },
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                12),
                                          ],
                                          decoration: InputDecoration(
                                            disabledBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: PickColor
                                                            .borderColor)),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 15.h,
                                                    horizontal: 19.w),
                                            filled: true,
                                            fillColor: PickColor.fillColor,
                                            hintText: 'Enter mobile number',
                                            hintStyle: TextStyle(
                                                color: PickColor.hintColor,
                                                fontSize: 14.sp),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.r),
                                                borderSide: const BorderSide(
                                                    color:
                                                        PickColor.borderColor)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.r),
                                                borderSide: const BorderSide(
                                                    color:
                                                        PickColor.borderColor)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.r),
                                                borderSide: BorderSide(
                                                    color: Colors.red)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.r),
                                                    borderSide: BorderSide(
                                                        color: Colors.red)),
                                          ),
                                        ),
                                        SizedBox(height: 14.h),
                                        Container(
                                          height: Get.height * 0.06,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                              color: PickColor.fillColor,
                                              border: Border.all(
                                                  color:
                                                      PickColor.borderColor)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            child: Row(
                                              children: [
                                                imageBand != ""
                                                    ? Row(
                                                        children: [
                                                          Text("Selected",
                                                              style: TextStyle(
                                                                  color: PickColor
                                                                      .secondaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      16.sp)),
                                                          SizedBox(width: 5.w),
                                                          IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  imageBand =
                                                                      "";
                                                                  log('imageBand-------->>>>>>${imageBand}');
                                                                });
                                                              },
                                                              icon: Icon(
                                                                  Icons.clear))
                                                        ],
                                                      )
                                                    : Text(
                                                        "Take picture of number on band",
                                                        style: TextStyle(
                                                            color: PickColor
                                                                .hintColor,
                                                            fontSize: 14.sp)),
                                                Spacer(),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor: imageBand !=
                                                              ""
                                                          ? PickColor
                                                              .secondaryColor
                                                              .withOpacity(0.5)
                                                          : PickColor
                                                              .secondaryColor,
                                                      fixedSize:
                                                          Size(80.w, 40.h),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5)),
                                                  onPressed: () async {
                                                    if (imageBand == "") {
                                                      final ImagePicker picker =
                                                          ImagePicker();

                                                      final XFile? image =
                                                          await picker.pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);
                                                      // if (image!.path != "") {
                                                      //   setState(() {
                                                      //     imageBand = image.path;
                                                      //   });
                                                      // }

                                                      if (image!.path != "") {
                                                        imageBandFile = image;

                                                        var data = await image
                                                            .readAsBytes();
                                                        var data1 = data.buffer
                                                            .asByteData();
                                                        print(
                                                            '--data--${data.buffer}');
                                                        print(
                                                            '--data1--${data1.buffer}');

                                                        String tempPath =
                                                            (await getTemporaryDirectory())
                                                                .path;
                                                        File file = File(
                                                            '$tempPath/imageBandFile.png');
                                                        await file.writeAsBytes(
                                                            data.buffer
                                                                .asUint8List());

                                                        final encoded1 = base64
                                                            .encode(data1.buffer
                                                                .asUint8List());
                                                        setState(() {
                                                          imageBand = encoded1;
                                                        });

                                                        log("encoded====>${imageBand}");
                                                      }

                                                      //ByteData

                                                      ///
                                                      // final sign =
                                                      //     _sign.currentState;
                                                      // //retrieve image data, do whatever you want with it (send to server, save locally...)
                                                      // final image =
                                                      // await sign!.getData();
                                                      // var data =
                                                      // await image.toByteData(format: ui.ImageByteFormat.png);
                                                      // sign.clear();
                                                      // final encoded = base64.encode(data!
                                                      //     .buffer
                                                      //     .asUint8List());
                                                      // setState(
                                                      //         () {
                                                      //       signature1 =
                                                      //           encoded;
                                                      //       Navigator.pop(context);
                                                      //       log("encoded====>${signature1}");
                                                      //     });
                                                    }
                                                  },
                                                  child: Text(
                                                    'Choose',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 14.h),
                                        Container(
                                          height: Get.height * 0.06,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                              color: PickColor.fillColor,
                                              border: Border.all(
                                                  color:
                                                      PickColor.borderColor)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            child: Row(
                                              children: [
                                                signature1 != ""
                                                    ? Row(
                                                        children: [
                                                          Text("Selected",
                                                              style: TextStyle(
                                                                  color: PickColor
                                                                      .secondaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      16.sp)),
                                                          SizedBox(width: 5.w),
                                                          IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  signature1 =
                                                                      "";
                                                                });
                                                              },
                                                              icon: Icon(
                                                                  Icons.clear))
                                                        ],
                                                      )
                                                    : Text("SigNature",
                                                        style: TextStyle(
                                                            color: PickColor
                                                                .hintColor,
                                                            fontSize: 14.sp)),
                                                Spacer(),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          signature1 !=
                                                                  ""
                                                              ? PickColor
                                                                  .secondaryColor
                                                                  .withOpacity(
                                                                      0.5)
                                                              : PickColor
                                                                  .secondaryColor,
                                                      fixedSize:
                                                          Size(80.w, 40.h),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5)),
                                                  onPressed: () async {
                                                    if (signature1 == "") {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        40.w),
                                                            child: SimpleDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.r)),
                                                              backgroundColor:
                                                                  Colors.white,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              15.w),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        177.h,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .black12,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.r),
                                                                    ),
                                                                    child:
                                                                        Signature(
                                                                      color: PickColor
                                                                          .secondaryColor,
                                                                      key:
                                                                          _sign,
                                                                      onSign:
                                                                          () {
                                                                        final sign =
                                                                            _sign.currentState;
                                                                        debugPrint(
                                                                            '${sign?.points.length} points in the signature');
                                                                      },
                                                                      backgroundPainter: _WatermarkPaint(
                                                                          "2.0",
                                                                          "2.0"),
                                                                      strokeWidth:
                                                                          strokeWidth,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        27.h),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              80.w),
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        color: PickColor
                                                                            .secondaryColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(6.r)),
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          final sign =
                                                                              _sign.currentState;

                                                                          //retrieve image data, do whatever you want with it (send to server, save locally...)
                                                                          final image =
                                                                              await sign!.getData();
                                                                          var data =
                                                                              await image.toByteData(format: ui.ImageByteFormat.png);
                                                                          sign.clear();
                                                                          final encoded = base64.encode(data!
                                                                              .buffer
                                                                              .asUint8List());

                                                                          String
                                                                              tempPath =
                                                                              (await getTemporaryDirectory()).path;
                                                                          File
                                                                              file =
                                                                              File('$tempPath/signatureFile1.png');
                                                                          await file.writeAsBytes(data
                                                                              .buffer
                                                                              .asUint8List());
                                                                          signatureFile1 =
                                                                              file;
                                                                          setState(
                                                                              () {
                                                                            signature1 =
                                                                                encoded;
                                                                            Navigator.pop(context);
                                                                            log("encoded====>${signature1}");
                                                                          });
                                                                          debugPrint(
                                                                              '${sign.points.length} points in the signature');
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              56.h,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(6.r),
                                                                            // color: PickColor.secondaryColor,
                                                                          ),
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            'Save',
                                                                            style: TextStyle(
                                                                                fontSize: 14.sp,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w400),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Text(
                                                    'ESign',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        // SizedBox(height: 14.h),
                                        // CommonTextFormField(
                                        //   obscureText: false,
                                        //   controller: signatureForm1,
                                        //   validator: (value) {},
                                        //   hintText: 'SigNature',
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Form(
                                    key: _key2,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Name of Funeral/Other Representative Taking Custody of the Deceased',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 14.h),
                                        // CommonTextFormField(
                                        //   obscureText: false,
                                        //   controller: printedForm2,
                                        //   validator: (value) {},
                                        //   hintText: 'Printed',
                                        // ),
                                        SizedBox(height: 14.h),
                                        CommonTextFormField(
                                          obscureText: false,
                                          controller: directorName,
                                          validator: (value) {
                                            if (value!.trim().isEmpty) {
                                              return 'This field is required';
                                            }
                                            return null;
                                          },
                                          hintText: 'Director Name',
                                        ),
                                        SizedBox(height: 14.h),
                                        CommonTextFormField(
                                          obscureText: false,
                                          controller: addressController,
                                          validator: (value) {
                                            if (value!.trim().isEmpty) {
                                              return 'This field is required';
                                            }
                                            return null;
                                          },
                                          hintText: 'Address',
                                        ),
                                        SizedBox(height: 14.h),
                                        // CommonTextFormField(
                                        //   obscureText: false,
                                        //   controller: signatureForm2,
                                        //   validator: (value) {},
                                        //   hintText: 'SigNature',
                                        // ),
                                        Container(
                                          height: Get.height * 0.06,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                              color: PickColor.fillColor,
                                              border: Border.all(
                                                  color:
                                                      PickColor.borderColor)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            child: Row(
                                              children: [
                                                signature2 != ""
                                                    ? Row(
                                                        children: [
                                                          Text("Selected",
                                                              style: TextStyle(
                                                                  color: PickColor
                                                                      .secondaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      16.sp)),
                                                          SizedBox(width: 5.w),
                                                          IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  signature2 =
                                                                      "";
                                                                });
                                                              },
                                                              icon: Icon(
                                                                  Icons.clear))
                                                        ],
                                                      )
                                                    : Text("SigNature",
                                                        style: TextStyle(
                                                            color: PickColor
                                                                .hintColor,
                                                            fontSize: 14.sp)),
                                                Spacer(),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          signature2 !=
                                                                  ""
                                                              ? PickColor
                                                                  .secondaryColor
                                                                  .withOpacity(
                                                                      0.5)
                                                              : PickColor
                                                                  .secondaryColor,
                                                      fixedSize:
                                                          Size(80.w, 40.h),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5)),
                                                  onPressed: () async {
                                                    if (signature2 == "") {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        40.w),
                                                            child: SimpleDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.r)),
                                                              backgroundColor:
                                                                  Colors.white,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              15.w),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        177.h,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .black12,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.r),
                                                                    ),
                                                                    child:
                                                                        Signature(
                                                                      color: PickColor
                                                                          .secondaryColor,
                                                                      key:
                                                                          _sign,
                                                                      onSign:
                                                                          () {
                                                                        final sign =
                                                                            _sign.currentState;
                                                                        debugPrint(
                                                                            '${sign?.points.length} points in the signature');
                                                                      },
                                                                      backgroundPainter: _WatermarkPaint(
                                                                          "2.0",
                                                                          "2.0"),
                                                                      strokeWidth:
                                                                          strokeWidth,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        27.h),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              80.w),
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        color: PickColor
                                                                            .secondaryColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(6.r)),
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          final sign =
                                                                              _sign.currentState;
                                                                          //retrieve image data, do whatever you want with it (send to server, save locally...)
                                                                          final image =
                                                                              await sign!.getData();
                                                                          var data =
                                                                              await image.toByteData(format: ui.ImageByteFormat.png);
                                                                          sign.clear();
                                                                          final encoded = base64.encode(data!
                                                                              .buffer
                                                                              .asUint8List());
                                                                          String
                                                                              tempPath =
                                                                              (await getTemporaryDirectory()).path;
                                                                          File
                                                                              file =
                                                                              File('$tempPath/signatureFile2.png');
                                                                          await file.writeAsBytes(data
                                                                              .buffer
                                                                              .asUint8List());
                                                                          signatureFile2 =
                                                                              file;

                                                                          setState(
                                                                              () {
                                                                            signature2 =
                                                                                encoded;
                                                                            Navigator.pop(context);
                                                                            log("encoded====>${signature2}");
                                                                          });
                                                                          debugPrint(
                                                                              '${sign.points.length} points in the signature');
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              56.h,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(6.r),
                                                                            // color: PickColor.secondaryColor,
                                                                          ),
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            'Save',
                                                                            style: TextStyle(
                                                                                fontSize: 14.sp,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w400),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Text(
                                                    'ESign',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 14.h),
                                        GestureDetector(
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101));
                                            if (pickedDate != null) {
                                              print(pickedDate);
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                              print(formattedDate);

                                              setState(() {
                                                dateInputForm2.text =
                                                    formattedDate;
                                              });
                                            } else {
                                              print("Date is not selected");
                                            }
                                          },
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value!.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                            controller: dateInputForm2,
                                            enabled: false,
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                              disabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: PickColor
                                                              .borderColor)),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 15.h,
                                                      horizontal: 19.w),
                                              suffixIcon: const Icon(
                                                  Icons.calendar_today_outlined,
                                                  size: 20,
                                                  color: Color(0xff555555)),
                                              filled: true,
                                              fillColor: PickColor.fillColor,
                                              hintText: 'Date/Time',
                                              hintStyle: TextStyle(
                                                  color: PickColor.hintColor,
                                                  fontSize: 14.sp),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  borderSide: BorderSide(
                                                      color: PickColor
                                                          .borderColor)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  borderSide: BorderSide(
                                                      color: PickColor
                                                          .borderColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  borderSide: BorderSide(
                                                      color: Colors.red)),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.r),
                                                      borderSide: BorderSide(
                                                          color: Colors.red)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 14.h),
                                        Text(
                                          'Name of Crematory/Cemetery Representative Taking Custody of the Deceased',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 14.h),
                                        // CommonTextFormField(
                                        //   obscureText: false,
                                        //   controller: printedForm2Phase2,
                                        //   validator: (value) {},
                                        //   hintText: 'Printed',
                                        // ),
                                        SizedBox(height: 14.h),
                                        // CommonTextFormField(
                                        //   obscureText: false,
                                        //   controller: signatureForm2Phase2,
                                        //   validator: (value) {},
                                        //   hintText: 'SigNature',
                                        // ),

                                        Container(
                                          height: Get.height * 0.06,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                              color: PickColor.fillColor,
                                              border: Border.all(
                                                  color:
                                                      PickColor.borderColor)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            child: Row(
                                              children: [
                                                signature3 != ""
                                                    ? Row(
                                                        children: [
                                                          Text("Selected",
                                                              style: TextStyle(
                                                                  color: PickColor
                                                                      .secondaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      16.sp)),
                                                          SizedBox(width: 5.w),
                                                          IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  signature3 =
                                                                      "";
                                                                });
                                                              },
                                                              icon: Icon(
                                                                  Icons.clear))
                                                        ],
                                                      )
                                                    : Text("SigNature",
                                                        style: TextStyle(
                                                            color: PickColor
                                                                .hintColor,
                                                            fontSize: 14.sp)),
                                                Spacer(),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          signature3 !=
                                                                  ""
                                                              ? PickColor
                                                                  .secondaryColor
                                                                  .withOpacity(
                                                                      0.5)
                                                              : PickColor
                                                                  .secondaryColor,
                                                      fixedSize:
                                                          Size(80.w, 40.h),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5)),
                                                  onPressed: () async {
                                                    if (signature3 == "") {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        40.w),
                                                            child: SimpleDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.r)),
                                                              backgroundColor:
                                                                  Colors.white,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              15.w),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        177.h,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .black12,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.r),
                                                                    ),
                                                                    child:
                                                                        Signature(
                                                                      color: PickColor
                                                                          .secondaryColor,
                                                                      key:
                                                                          _sign,
                                                                      onSign:
                                                                          () {
                                                                        final sign =
                                                                            _sign.currentState;
                                                                        debugPrint(
                                                                            '${sign?.points.length} points in the signature');
                                                                      },
                                                                      backgroundPainter: _WatermarkPaint(
                                                                          "2.0",
                                                                          "2.0"),
                                                                      strokeWidth:
                                                                          strokeWidth,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        27.h),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              80.w),
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        color: PickColor
                                                                            .secondaryColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(6.r)),
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          final sign =
                                                                              _sign.currentState;
                                                                          //retrieve image data, do whatever you want with it (send to server, save locally...)
                                                                          final image =
                                                                              await sign!.getData();
                                                                          var data =
                                                                              await image.toByteData(format: ui.ImageByteFormat.png);
                                                                          sign.clear();
                                                                          final encoded = base64.encode(data!
                                                                              .buffer
                                                                              .asUint8List());

                                                                          String
                                                                              tempPath =
                                                                              (await getTemporaryDirectory()).path;
                                                                          File
                                                                              file =
                                                                              File('$tempPath/signatureFile3.png');
                                                                          await file.writeAsBytes(data
                                                                              .buffer
                                                                              .asUint8List());
                                                                          signatureFile3 =
                                                                              file;

                                                                          setState(
                                                                              () {
                                                                            signature3 =
                                                                                encoded;
                                                                            Navigator.pop(context);
                                                                            log("encoded====>${signature3}");
                                                                          });
                                                                          debugPrint(
                                                                              '${sign.points.length} points in the signature');
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              56.h,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(6.r),
                                                                            // color: PickColor.secondaryColor,
                                                                          ),
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            'Save',
                                                                            style: TextStyle(
                                                                                fontSize: 14.sp,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w400),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Text(
                                                    'ESign',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 14.h),
                                        GestureDetector(
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101));
                                            if (pickedDate != null) {
                                              print(pickedDate);
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                              print(formattedDate);

                                              setState(() {
                                                dateInputForm2Phase2.text =
                                                    formattedDate;
                                              });
                                            } else {
                                              print("Date is not selected");
                                            }
                                          },
                                          child: TextFormField(
                                            controller: dateInputForm2Phase2,
                                            validator: (value) {
                                              if (value!.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                            enabled: false,
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                              disabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: PickColor
                                                              .borderColor)),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 15.h,
                                                      horizontal: 19.w),
                                              suffixIcon: const Icon(
                                                  Icons.calendar_today_outlined,
                                                  size: 20,
                                                  color: Color(0xff555555)),
                                              filled: true,
                                              fillColor: PickColor.fillColor,
                                              hintText: 'Date/Time',
                                              hintStyle: TextStyle(
                                                  color: PickColor.hintColor,
                                                  fontSize: 14.sp),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  borderSide: BorderSide(
                                                      color: PickColor
                                                          .borderColor)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  borderSide: BorderSide(
                                                      color: PickColor
                                                          .borderColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  borderSide: BorderSide(
                                                      color: Colors.red)),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.r),
                                                      borderSide: BorderSide(
                                                          color: Colors.red)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Form(
                                    key: _key3,
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Name of person entitled to receive the cremated remalns',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        // SizedBox(height: 14.h),
                                        // CommonTextFormField(
                                        //   obscureText: false,
                                        //   controller: printedForm3,
                                        //   validator: (value) {},
                                        //   hintText: 'Printed',
                                        // ),
                                        SizedBox(height: 14.h),
                                        CommonTextFormField(
                                          obscureText: false,
                                          controller: relationShipForm3,
                                          validator: (value) {
                                            if (value!.trim().isEmpty) {
                                              return 'This field is required';
                                            }
                                            return null;
                                          },
                                          hintText: 'Relationship',
                                        ),
                                        SizedBox(height: 14.h),
                                        Container(
                                          height: Get.height * 0.06,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                              color: PickColor.fillColor,
                                              border: Border.all(
                                                  color:
                                                      PickColor.borderColor)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            child: Row(
                                              children: [
                                                signature4 != ""
                                                    ? Row(
                                                        children: [
                                                          Text("Selected",
                                                              style: TextStyle(
                                                                  color: PickColor
                                                                      .secondaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      16.sp)),
                                                          SizedBox(width: 5.w),
                                                          IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  signature4 =
                                                                      "";
                                                                });
                                                              },
                                                              icon: Icon(
                                                                  Icons.clear))
                                                        ],
                                                      )
                                                    : Text("SigNature",
                                                        style: TextStyle(
                                                            color: PickColor
                                                                .hintColor,
                                                            fontSize: 14.sp)),
                                                Spacer(),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          signature4 !=
                                                                  ""
                                                              ? PickColor
                                                                  .secondaryColor
                                                                  .withOpacity(
                                                                      0.5)
                                                              : PickColor
                                                                  .secondaryColor,
                                                      fixedSize:
                                                          Size(80.w, 40.h),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5)),
                                                  onPressed: () async {
                                                    if (signature4 == "") {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        40.w),
                                                            child: SimpleDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.r)),
                                                              backgroundColor:
                                                                  Colors.white,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              15.w),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        177.h,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .black12,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.r),
                                                                    ),
                                                                    child:
                                                                        Signature(
                                                                      color: PickColor
                                                                          .secondaryColor,
                                                                      key:
                                                                          _sign,
                                                                      onSign:
                                                                          () {
                                                                        final sign =
                                                                            _sign.currentState;
                                                                        debugPrint(
                                                                            '${sign?.points.length} points in the signature');
                                                                      },
                                                                      backgroundPainter: _WatermarkPaint(
                                                                          "2.0",
                                                                          "2.0"),
                                                                      strokeWidth:
                                                                          strokeWidth,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        27.h),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              80.w),
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        color: PickColor
                                                                            .secondaryColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(6.r)),
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          final sign =
                                                                              _sign.currentState;
                                                                          //retrieve image data, do whatever you want with it (send to server, save locally...)
                                                                          final image =
                                                                              await sign!.getData();
                                                                          var data =
                                                                              await image.toByteData(format: ui.ImageByteFormat.png);
                                                                          sign.clear();
                                                                          final encoded = base64.encode(data!
                                                                              .buffer
                                                                              .asUint8List());
                                                                          String
                                                                              tempPath =
                                                                              (await getTemporaryDirectory()).path;
                                                                          File
                                                                              file =
                                                                              File('$tempPath/signatureFile4.png');
                                                                          await file.writeAsBytes(data
                                                                              .buffer
                                                                              .asUint8List());
                                                                          signatureFile4 =
                                                                              file;
                                                                          setState(
                                                                              () {
                                                                            signature4 =
                                                                                encoded;
                                                                            Navigator.pop(context);
                                                                            log("encoded====>${signature4}");
                                                                          });
                                                                          debugPrint(
                                                                              '${sign.points.length} points in the signature');
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              56.h,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(6.r),
                                                                            // color: PickColor.secondaryColor,
                                                                          ),
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            'Save',
                                                                            style: TextStyle(
                                                                                fontSize: 14.sp,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w400),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Text(
                                                    'ESign',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 14.h),
                                        GestureDetector(
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101));
                                            if (pickedDate != null) {
                                              print(pickedDate);
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                              print(formattedDate);

                                              setState(() {
                                                dateInputForm3.text =
                                                    formattedDate;
                                              });
                                            } else {
                                              print("Date is not selected");
                                            }
                                          },
                                          child: TextFormField(
                                            controller: dateInputForm3,
                                            validator: (value) {
                                              if (value!.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                            enabled: false,
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                              disabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: PickColor
                                                              .borderColor)),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 15.h,
                                                      horizontal: 19.w),
                                              suffixIcon: const Icon(
                                                  Icons.calendar_today_outlined,
                                                  size: 20,
                                                  color: Color(0xff555555)),
                                              filled: true,
                                              fillColor: PickColor.fillColor,
                                              hintText: 'Date/Time',
                                              hintStyle: TextStyle(
                                                  color: PickColor.hintColor,
                                                  fontSize: 14.sp),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  borderSide: BorderSide(
                                                      color: PickColor
                                                          .borderColor)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  borderSide: BorderSide(
                                                      color: PickColor
                                                          .borderColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  borderSide: BorderSide(
                                                      color: Colors.red)),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.r),
                                                      borderSide: BorderSide(
                                                          color: Colors.red)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 14.h),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Name of person releasing cremated remains',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 14.h),
                                        // CommonTextFormField(
                                        //   obscureText: false,
                                        //   controller: printedForm3Phase3,
                                        //   validator: (value) {},
                                        //   hintText: 'Printed',
                                        // ),
                                        SizedBox(height: 14.h),
                                        Container(
                                          height: Get.height * 0.06,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                              color: PickColor.fillColor,
                                              border: Border.all(
                                                  color:
                                                      PickColor.borderColor)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            child: Row(
                                              children: [
                                                signature5 != ""
                                                    ? Row(
                                                        children: [
                                                          Text("Selected",
                                                              style: TextStyle(
                                                                  color: PickColor
                                                                      .secondaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      16.sp)),
                                                          SizedBox(width: 5.w),
                                                          IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  signature5 =
                                                                      "";
                                                                });
                                                              },
                                                              icon: Icon(
                                                                  Icons.clear))
                                                        ],
                                                      )
                                                    : Text("SigNature",
                                                        style: TextStyle(
                                                            color: PickColor
                                                                .hintColor,
                                                            fontSize: 14.sp)),
                                                Spacer(),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          signature5 !=
                                                                  ""
                                                              ? PickColor
                                                                  .secondaryColor
                                                                  .withOpacity(
                                                                      0.5)
                                                              : PickColor
                                                                  .secondaryColor,
                                                      fixedSize:
                                                          Size(80.w, 40.h),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5)),
                                                  onPressed: () async {
                                                    if (signature5 == "") {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        40.w),
                                                            child: SimpleDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.r)),
                                                              backgroundColor:
                                                                  Colors.white,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              15.w),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        177.h,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .black12,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.r),
                                                                    ),
                                                                    child:
                                                                        Signature(
                                                                      color: PickColor
                                                                          .secondaryColor,
                                                                      key:
                                                                          _sign,
                                                                      onSign:
                                                                          () {
                                                                        final sign =
                                                                            _sign.currentState;
                                                                        debugPrint(
                                                                            '${sign?.points.length} points in the signature');
                                                                      },
                                                                      backgroundPainter: _WatermarkPaint(
                                                                          "2.0",
                                                                          "2.0"),
                                                                      strokeWidth:
                                                                          strokeWidth,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        27.h),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              80.w),
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        color: PickColor
                                                                            .secondaryColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(6.r)),
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          final sign =
                                                                              _sign.currentState;
                                                                          //retrieve image data, do whatever you want with it (send to server, save locally...)
                                                                          final image =
                                                                              await sign!.getData();
                                                                          var data =
                                                                              await image.toByteData(format: ui.ImageByteFormat.png);
                                                                          sign.clear();
                                                                          final encoded = base64.encode(data!
                                                                              .buffer
                                                                              .asUint8List());
                                                                          String
                                                                              tempPath =
                                                                              (await getTemporaryDirectory()).path;
                                                                          File
                                                                              file =
                                                                              File('$tempPath/signatureFile5.png');
                                                                          await file.writeAsBytes(data
                                                                              .buffer
                                                                              .asUint8List());
                                                                          signatureFile5 =
                                                                              file;
                                                                          setState(
                                                                              () {
                                                                            signature5 =
                                                                                encoded;
                                                                            Navigator.pop(context);
                                                                            log("encoded====>${signature5}");
                                                                          });
                                                                          debugPrint(
                                                                              '${sign.points.length} points in the signature');
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              56.h,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(6.r),
                                                                            // color: PickColor.secondaryColor,
                                                                          ),
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            'Save',
                                                                            style: TextStyle(
                                                                                fontSize: 14.sp,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w400),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Text(
                                                    'ESign',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 14.h),
                                        GestureDetector(
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2101));
                                            if (pickedDate != null) {
                                              print(pickedDate);
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                              print(formattedDate);

                                              setState(() {
                                                dateInputForm3Phase3.text =
                                                    formattedDate;
                                              });
                                            } else {
                                              print("Date is not selected");
                                            }
                                          },
                                          child: TextFormField(
                                            controller: dateInputForm3Phase3,
                                            validator: (value) {
                                              if (value!.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                              return null;
                                            },
                                            enabled: false,
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                              disabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: PickColor
                                                              .borderColor)),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 15.h,
                                                      horizontal: 19.w),
                                              suffixIcon: const Icon(
                                                  Icons.calendar_today_outlined,
                                                  size: 20,
                                                  color: Color(0xff555555)),
                                              filled: true,
                                              fillColor: PickColor.fillColor,
                                              hintText: 'Date/Time',
                                              hintStyle: TextStyle(
                                                  color: PickColor.hintColor,
                                                  fontSize: 14.sp),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  borderSide: BorderSide(
                                                      color: PickColor
                                                          .borderColor)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  borderSide: BorderSide(
                                                      color: PickColor
                                                          .borderColor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  borderSide: BorderSide(
                                                      color: Colors.red)),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.r),
                                                      borderSide: BorderSide(
                                                          color: Colors.red)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20.h),
                                        // Align(
                                        //   alignment: Alignment.topLeft,
                                        //   child: Text(
                                        //     'Upload Photo',
                                        //     style: TextStyle(
                                        //       color: Colors.black,
                                        //       fontSize: 16.sp,
                                        //       fontWeight: FontWeight.w400,
                                        //     ),
                                        //   ),
                                        // ),
                                        SizedBox(height: 14.h),
                                        /*Container(
                                            height: 56.h,
                                            alignment: Alignment.topLeft,
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              color: PickColor.fillColor,
                                              border:
                                                  Border.all(color: PickColor.borderColor),
                                              borderRadius: BorderRadius.circular(6.r),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w, vertical: 12.h),
                                              child: Container(
                                                height: 31.h,
                                                width: 88.w,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  borderRadius: BorderRadius.circular(6.r),
                                                ),
                                                child: Text(
                                                  'Choose file',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 14.sp,
                                                      color: Color(0xff848484)),
                                                ),
                                              ),
                                            ),
                                          ),*/
                                        SizedBox(height: 14.h),
                                        // Align(
                                        //   alignment: Alignment.topLeft,
                                        //   child: Container(
                                        //     decoration: BoxDecoration(
                                        //         boxShadow: [
                                        //           BoxShadow(
                                        //             color: Colors.grey.shade300,
                                        //             offset: const Offset(
                                        //               1.0,
                                        //               1.0,
                                        //             ),
                                        //             blurRadius: 1.0,
                                        //             spreadRadius: 1.0,
                                        //           ), //BoxShadow
                                        //           const BoxShadow(
                                        //             color: Colors.white,
                                        //             offset: Offset(0.0, 0.0),
                                        //             blurRadius: 0.0,
                                        //             spreadRadius: 0.0,
                                        //           ), //BoxShadow
                                        //         ],
                                        //         color: Colors.white,
                                        //         borderRadius: BorderRadius.circular(6.r)),
                                        //     child: Material(
                                        //       color: Colors.transparent,
                                        //       child: InkWell(
                                        //         onTap: () {
                                        //           showDialog(
                                        //             context: context,
                                        //             builder: (BuildContext context) {
                                        //               return Padding(
                                        //                 padding: EdgeInsets.symmetric(
                                        //                     horizontal: 40.w),
                                        //                 child: SimpleDialog(
                                        //                   shape: RoundedRectangleBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius.circular(
                                        //                               16.r)),
                                        //                   backgroundColor: Colors.white,
                                        //                   children: [
                                        //                     Padding(
                                        //                       padding:
                                        //                           EdgeInsets.symmetric(
                                        //                               horizontal: 15.w),
                                        //                       child: Container(
                                        //                         height: 177.h,
                                        //                         width:
                                        //                             MediaQuery.of(context)
                                        //                                 .size
                                        //                                 .width,
                                        //                         decoration: BoxDecoration(
                                        //                           color: Colors.black12,
                                        //                           borderRadius:
                                        //                               BorderRadius
                                        //                                   .circular(10.r),
                                        //                         ),
                                        //                         child: Signature(
                                        //                           color: PickColor
                                        //                               .secondaryColor,
                                        //                           key: _sign,
                                        //                           onSign: () {
                                        //                             final sign = _sign
                                        //                                 .currentState;
                                        //                             debugPrint(
                                        //                                 '${sign?.points.length} points in the signature');
                                        //                           },
                                        //                           backgroundPainter:
                                        //                               _WatermarkPaint(
                                        //                                   "2.0", "2.0"),
                                        //                           strokeWidth:
                                        //                               strokeWidth,
                                        //                         ),
                                        //                       ),
                                        //                     ),
                                        //                     SizedBox(height: 27.h),
                                        //                     Padding(
                                        //                       padding:
                                        //                           EdgeInsets.symmetric(
                                        //                               horizontal: 80.w),
                                        //                       child: Container(
                                        //                         decoration: BoxDecoration(
                                        //                             color: PickColor
                                        //                                 .secondaryColor,
                                        //                             borderRadius:
                                        //                                 BorderRadius
                                        //                                     .circular(
                                        //                                         6.r)),
                                        //                         child: Material(
                                        //                           color:
                                        //                               Colors.transparent,
                                        //                           child: InkWell(
                                        //                             onTap: () {
                                        //                               Navigator.pop(
                                        //                                   context);
                                        //                             },
                                        //                             child: Container(
                                        //                               height: 56.h,
                                        //                               decoration:
                                        //                                   BoxDecoration(
                                        //                                 borderRadius:
                                        //                                     BorderRadius
                                        //                                         .circular(
                                        //                                             6.r),
                                        //                                 // color: PickColor.secondaryColor,
                                        //                               ),
                                        //                               alignment: Alignment
                                        //                                   .center,
                                        //                               child: Text(
                                        //                                 'Save',
                                        //                                 style: TextStyle(
                                        //                                     fontSize:
                                        //                                         14.sp,
                                        //                                     color: Colors
                                        //                                         .white,
                                        //                                     fontWeight:
                                        //                                         FontWeight
                                        //                                             .w400),
                                        //                               ),
                                        //                             ),
                                        //                           ),
                                        //                         ),
                                        //                       ),
                                        //                     )
                                        //                   ],
                                        //                 ),
                                        //               );
                                        //             },
                                        //           );
                                        //         },
                                        //         child: Container(
                                        //           height: 35.h,
                                        //           width: 98.w,
                                        //           decoration: BoxDecoration(
                                        //             borderRadius:
                                        //                 BorderRadius.circular(6.r),
                                        //             // color: PickColor.secondaryColor,
                                        //           ),
                                        //           alignment: Alignment.center,
                                        //           child: Text(
                                        //             'Esign',
                                        //             style: TextStyle(
                                        //                 fontSize: 14.sp,
                                        //                 color: PickColor.secondaryColor,
                                        //                 fontWeight: FontWeight.w400),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: selector == 0 ? 10.h : 30.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              selector == 0
                                  ? const SizedBox()
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          fixedSize: Size(121.w, 56.h),
                                          side: BorderSide(
                                              color: PickColor.secondaryColor)),
                                      onPressed: () {
                                        if (selector >= 2) {
                                          selector--;
                                          log('selector===>${selector}');
                                        } else {
                                          selector = 0;
                                        }

                                        pageController?.animateToPage(selector,
                                            duration: const Duration(
                                                microseconds: 100),
                                            curve: Curves.easeIn);
                                      },
                                      child: Text(
                                        'Previous',
                                        style: TextStyle(
                                          color: PickColor.secondaryColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                    ),
                              Spacer(),
                              GetBuilder<FormViewModel>(
                                builder: (controller) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: PickColor.secondaryColor,
                                      fixedSize: Size(121.w, 56.h),
                                    ),
                                    onPressed: () async {
                                      log('selector---78924-->$selector');
                                      if (selector == 1) {
                                        if (_key2.currentState!.validate()) {
                                          if (dateInputForm2.text.isEmpty) {
                                            CommonSnackBar.showSnackBar(
                                                title: 'Create form',
                                                message:
                                                    "Please enter date of death");
                                          } else if (directorName
                                              .text.isEmpty) {
                                            CommonSnackBar.showSnackBar(
                                                title: 'Create form',
                                                message:
                                                    "Please enter Director Name");
                                          } else if (dateInputForm2Phase2
                                              .text.isEmpty) {
                                            CommonSnackBar.showSnackBar(
                                                title: 'Create form',
                                                message:
                                                    "Please enter date of Birth");
                                          } else if (addressController
                                              .text.isEmpty) {
                                            CommonSnackBar.showSnackBar(
                                                title: 'Create form',
                                                message:
                                                    "Please enter Address");
                                          } else if (signature2 == "") {
                                            CommonSnackBar.showSnackBar(
                                                title: 'Create form',
                                                message:
                                                    "Please upload your sign");
                                          } else if (signature3 == "") {
                                            CommonSnackBar.showSnackBar(
                                                title: 'Create form',
                                                message:
                                                    "Please upload your sign");
                                          } else {
                                            selector++;
                                          }
                                        } else {
                                          CommonSnackBar.showSnackBar(
                                              title: 'Create form',
                                              message:
                                                  "Please enter all details");
                                          log('selector---rr-wdew->$selector');
                                        }
                                        log('selector---tt-->$selector');
                                      } else if (selector == 0) {
                                        if (_key1.currentState!.validate()) {
                                          if (dateInputForm1.text.isEmpty) {
                                            CommonSnackBar.showSnackBar(
                                                title: 'Create form',
                                                message:
                                                    "Please enter date of death");
                                          } else if (selectedCountryName ==
                                              null) {
                                            CommonSnackBar.showSnackBar(
                                                title: 'Create form',
                                                message:
                                                    "Please select country");
                                          } else if (selectedStateName ==
                                              null) {
                                            CommonSnackBar.showSnackBar(
                                                title: 'Create form',
                                                message: "Please select State");
                                          } else if (imageBand == "") {
                                            CommonSnackBar.showSnackBar(
                                                title: 'Create form',
                                                message:
                                                    "Please upload number of band image");
                                          } else if (signature1 == "") {
                                            CommonSnackBar.showSnackBar(
                                                title: 'Create form',
                                                message:
                                                    "Please upload your sign");
                                          } else {
                                            selector++;
                                          }
                                        } else {
                                          CommonSnackBar.showSnackBar(
                                              title: 'Create form',
                                              message:
                                                  "Please enter all details");
                                          log('selector---rr-wdew->$selector');
                                        }

                                        log('selector---rr-->$selector');
                                      } else if (selector == 2) {
                                        if (_key3.currentState!.validate()) {
                                          if (dateInputForm3.text.isEmpty) {
                                            CommonSnackBar.showSnackBar(
                                                title: 'Create form',
                                                message:
                                                    "Please enter date of death");
                                          } else if (relationShipForm3
                                              .text.isEmpty) {
                                            CommonSnackBar.showSnackBar(
                                                title: 'Create form',
                                                message:
                                                    "Please enter your relation");
                                          } else if (dateInputForm3Phase3
                                              .text.isEmpty) {
                                            CommonSnackBar.showSnackBar(
                                                title: 'Create form',
                                                message:
                                                    "Please enter date of death");
                                          } else if (signature4 == "") {
                                            CommonSnackBar.showSnackBar(
                                                title: 'Create form',
                                                message:
                                                    "Please upload your sign");
                                          } else if (signature5 == "") {
                                            CommonSnackBar.showSnackBar(
                                                title: 'Create form',
                                                message:
                                                    "Please upload your sign");
                                          } else {
                                            log('selector---sssss------->$selector');
                                            log('nameControllerForm1.text-------->>>>>>${nameControllerForm1.text}');
                                            log('dateInputForm1.text-------->>>>>>${dateInputForm1.text}');
                                            log('placeControllerForm1.text-------->>>>>>${placeControllerForm1.text}');
                                            log('phoneNumberController.text-------->>>>>>${phoneNumberController.text}');

                                            // var body = {
                                            //   "number_on_uis_band": "",
                                            //   "country_id": selectedCountryId,
                                            //   "state_id":
                                            //       stateController.text.trim(),
                                            //   "deceased_name":
                                            //       nameControllerForm1.text
                                            //           .trim(),
                                            //   "date_of_death":
                                            //       dateInputForm1.text.trim(),
                                            //   "place_of_death":
                                            //       placeControllerForm1.text
                                            //           .trim(),
                                            //   "phone_number":
                                            //       phoneNumberController.text
                                            //           .trim(),
                                            //   "picture_of_number_on_band":
                                            //       imageBand,
                                            //   "name_securing_band": "test",
                                            //   "date_time_attached":
                                            //       dateTimeAttachedControllerForm1
                                            //           .text
                                            //           .trim(),
                                            //   "name_of_funeral_director":
                                            //       directorName.text.trim(),
                                            //   "address_of_funeral_home":
                                            //       addressController.text.trim(),
                                            //   "name_funeral_director_other_representative_taking_custody_esign":
                                            //       signature2,
                                            //   "name_funeral_director_other_representative_taking_custody_dt":
                                            //       "2023-05-06 10:52:43",
                                            //   // dateInputForm2.text.trim(),
                                            //   "name_crematory_cemetery_representative_custody_deceased_esign":
                                            //       signature3,
                                            //   "name_crematory_cemetery_representative_custody_deceased_dt":
                                            //       "2023-05-06 10:52:43",
                                            //   // dateInputForm2Phase2.text
                                            //   //     .trim(),
                                            //   "name_of_person_entitled_to_receive_cremated_remains_esign":
                                            //       signature4,
                                            //   "name_of_person_entitled_to_receive_cremated_remains_relationship":
                                            //       relationShipForm3.text.trim(),
                                            //   "name_of_person_entitled_to_receive_cremated_remains_dt":
                                            //       "2023-05-06 10:52:43",
                                            //   // dateInputForm3.text.trim(),
                                            //   "name_of_person_releasing_cremated_remains_esign":
                                            //       signature5,
                                            //   "name_of_person_releasing_cremated_remains_dt":
                                            //       "2023-05-06 10:52:43",
                                            //   // dateInputForm3Phase3.text
                                            //   //     .trim(),
                                            // };

                                            var body = {
                                              "number_on_uis_band": "",
                                              "country_id": selectedCountryId,
                                              "state_id": selectedStateId,
                                              "deceased_name":
                                                  nameControllerForm1.text
                                                      .trim(),
                                              "date_of_death":
                                                  dateInputForm1.text.trim(),
                                              "place_of_death":
                                                  placeControllerForm1.text
                                                      .trim(),
                                              "phone_number":
                                                  phoneNumberController.text
                                                      .trim(),
                                              "picture_of_number_on_band":
                                                  await dio.MultipartFile.fromFile(
                                                      imageBandFile?.path ?? '',
                                                      filename:
                                                          'imageBandFile.png'),
                                              "name_securing_band": "test",
                                              "date_time_attached":
                                                  dateTimeAttachedControllerForm1
                                                      .text
                                                      .trim(),
                                              "name_of_funeral_director":
                                                  directorName.text.trim(),
                                              "address_of_funeral_home":
                                                  addressController.text.trim(),
                                              "name_funeral_director_other_representative_taking_custody_esign":
                                                  await dio.MultipartFile.fromFile(
                                                      signatureFile2?.path ??
                                                          '',
                                                      filename:
                                                          'signatureFile2.png'),
                                              "name_funeral_director_other_representative_taking_custody_dt":
                                                  dateInputForm2.text.trim(),
                                              "name_crematory_cemetery_representative_custody_deceased_esign":
                                                  await dio.MultipartFile.fromFile(
                                                      signatureFile3?.path ??
                                                          '',
                                                      filename:
                                                          'signatureFile3.png'),
                                              "name_crematory_cemetery_representative_custody_deceased_dt":
                                                  dateInputForm2Phase2.text
                                                      .trim(),
                                              "name_of_person_entitled_to_receive_cremated_remains_esign":
                                                  await dio.MultipartFile.fromFile(
                                                      signatureFile4?.path ??
                                                          '',
                                                      filename:
                                                          'signatureFile4.png'),
                                              "name_of_person_entitled_to_receive_cremated_remains_relationship":
                                                  relationShipForm3.text.trim(),
                                              "name_of_person_entitled_to_receive_cremated_remains_dt":
                                                  dateInputForm3.text.trim(),
                                              "name_of_person_releasing_cremated_remains_esign":
                                                  await dio.MultipartFile.fromFile(
                                                      signatureFile5?.path ??
                                                          '',
                                                      filename:
                                                          'signatureFile5.png'),
                                              "name_of_person_releasing_cremated_remains_dt":
                                                  dateInputForm3Phase3.text
                                                      .trim(),
                                            };

                                            ///
                                            controller
                                                .createFormModel(body: body)
                                                .then((value) {
                                              if (controller
                                                      .apiResponse.status ==
                                                  Status.COMPLETE) {
                                                Get.back();
                                                CommonSnackBar.showSnackBar(
                                                    title:
                                                        'Form Submitted SuccessFully');
                                              }
                                            });
                                            if (controller.apiResponse.status ==
                                                Status.ERROR) {
                                              CommonSnackBar.showSnackBar(
                                                  title:
                                                      'Something Went Wrong');
                                            }
                                          }
                                        } else {
                                          CommonSnackBar.showSnackBar(
                                              title: 'Create form',
                                              message:
                                                  "Please enter all details");
                                          log('selector---rr-wdew->$selector');
                                        }

                                        log('selector---hhj-->$selector');
                                      } else {
                                        log('selector--fgfohf[plfp===========$selector');
                                      }

                                      pageController?.animateToPage(selector,
                                          duration:
                                              const Duration(microseconds: 100),
                                          curve: Curves.easeIn);
                                    },
                                    child: Text(
                                      selector == 2 ? 'Submit' : 'Next',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  formController.apiResponse.status == Status.LOADING
                      ? Container(
                          width: Get.width,
                          height: Get.height,
                          color: Colors.black.withOpacity(0.2),
                          child: CommonCircular.showCircularIndicator())
                      : SizedBox()
                ],
              ),
            );
          }),
        );
      },
    );
  }
}

class _WatermarkPaint extends CustomPainter {
  final String price;
  final String watermark;

  _WatermarkPaint(this.price, this.watermark);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10.8,
        Paint()..color = Colors.grey.shade300);
  }

  @override
  bool shouldRepaint(_WatermarkPaint oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _WatermarkPaint &&
          runtimeType == other.runtimeType &&
          price == other.price &&
          watermark == other.watermark;

  @override
  int get hashCode => price.hashCode ^ watermark.hashCode;
}
