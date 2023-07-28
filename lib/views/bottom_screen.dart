import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:universal_identification_system/constant/color.dart';
import 'package:universal_identification_system/constant/preference_manager.dart';
import 'package:universal_identification_system/controller/selector_controller.dart';
import 'package:universal_identification_system/views/Api/api_response.dart';
import 'package:universal_identification_system/views/Api/model/response_model/get_country_response_model.dart';
import 'package:universal_identification_system/views/Api/model/response_model/get_state_response_model.dart';
import 'package:universal_identification_system/views/Api/view_model/sign_up_viewmodel.dart';

import 'bottom_bar_screen/history_screen.dart';
import 'bottom_bar_screen/home_screen.dart';
import 'bottom_bar_screen/notification_screen.dart';
import 'bottom_bar_screen/profile_screen.dart';

class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    NotiFicationScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];
  SignUpViewModel signUpViewModel = Get.find();
  @override
  void initState() {
    log('PreferenceManager.getId() ==> ${PreferenceManager.getId()}');

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCountry();
    });

    super.initState();
  }

  getCountry() async {
    await signUpViewModel.getCountryViewModel(body: {
      "email": "${PreferenceManager.getEmail()}",
      "password": PreferenceManager.getPassword()
    });
    signUpViewModel.country.clear();
    if (signUpViewModel.apiResponseCountries.status == Status.COMPLETE) {
      CountryResponseModel countryResponseModel =
          signUpViewModel.apiResponseCountries.data;
      countryResponseModel.data.forEach((element) {
        signUpViewModel.setCountry(element);
      });
      log('signUpViewModel---->${signUpViewModel.country}');
    }
  }

  getStates({String countryCode = ''}) async {
    await signUpViewModel.getStateViewModel(
      body: {
        "email": "${PreferenceManager.getEmail()}",
        "password": PreferenceManager.getPassword()
      },
      countryCode: countryCode,
    );
    signUpViewModel.country.clear();
    if (signUpViewModel.apiResponseCountries.status == Status.COMPLETE) {
      StateResponseModel stateResponseModel =
          signUpViewModel.apiResponseCountries.data;
      stateResponseModel.data.forEach((element) {
        signUpViewModel.setStates(element);
      });
      log('signUpViewModel---->${signUpViewModel.country}');
    }
  }

  SelectorController selectorController = Get.put(SelectorController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectorController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey[100]!,
          body: Center(
            child: _widgetOptions.elementAt(controller.selector),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: PickColor.secondaryColor,
                  iconSize: 35.sp,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: Color(0xffE5EEF5),
                  color: PickColor.primaryColor,
                  tabs: const [
                    GButton(
                      icon: CupertinoIcons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.notifications_none_sharp,
                      text: 'Notification',
                    ),
                    GButton(
                      icon: Icons.history,
                      text: 'History',
                    ),
                    GButton(
                      icon: CupertinoIcons.person_circle,
                      text: 'Profile',
                    ),
                  ],
                  selectedIndex: controller.selector,
                  onTabChange: (index) {
                    setState(() {
                      controller.selected(index);
                    });
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
