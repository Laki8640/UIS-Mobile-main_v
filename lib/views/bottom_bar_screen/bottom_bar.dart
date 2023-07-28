// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:universal_identification_system/constant/color.dart';
// import 'package:universal_identification_system/constant/image_path.dart';
// import 'package:universal_identification_system/constant/text_style.dart';
// import 'package:universal_identification_system/controller/selector_controller.dart';
// import 'package:universal_identification_system/views/bottom_bar_screen/history_screen.dart';
// import 'package:universal_identification_system/views/bottom_bar_screen/home_screen.dart';
// import 'package:universal_identification_system/views/bottom_bar_screen/notification_screen.dart';
// import 'package:universal_identification_system/views/bottom_bar_screen/profile_screen.dart';
//
// class BottomBarScreen extends StatefulWidget {
//   const BottomBarScreen({Key? key}) : super(key: key);
//
//   @override
//   State<BottomBarScreen> createState() => _BottomBarScreenState();
// }
//
// class _BottomBarScreenState extends State<BottomBarScreen> {
//   List<Map<String, dynamic>> bottomIcon = [
//     {'icon': ImagePath.homeIcon, 'name': 'Home'},
//     {'icon': ImagePath.notiFicationIcon, 'name': 'Notification'},
//     {'icon': ImagePath.historyIcon, 'name': 'History'},
//     {'icon': ImagePath.profileIcon, 'name': 'Profile'},
//   ];
//
//   List screen = [
//     const HomeScreen(),
//     const NotiFicationScreen(),
//     const HistoryScreen(),
//     const ProfileScreen(),
//   ];
//   SelectorController selectorController = Get.put(SelectorController());
//
//   @override
//   Widget build(BuildContext context) {
//     print('refresh');
//     return GetBuilder<SelectorController>(
//       builder: (controller) {
//         return Scaffold(
//           backgroundColor: Colors.grey.shade100,
//           body: screen[controller.selector],
//           bottomNavigationBar: Container(
//             height: 75.h,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 6,
//                   blurRadius: 8,
//                   offset: const Offset(0, 3), // changes position of shadow
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: List.generate(
//                 bottomIcon.length,
//                 (index) => GestureDetector(
//                   onTap: () {
//                     controller.selected(index);
//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(
//                         bottomIcon[index]['icon'],
//                         height: 23.h,
//                         width: 23.w,
//                         color: controller.selector == index
//                             ? PickColor.secondaryColor
//                             : PickColor.primaryColor,
//                       ),
//                       SizedBox(height: 4.h),
//                       Text(
//                         '${bottomIcon[index]['name']}',
//                         style: TextStyle(
//                           color: controller.selector == index
//                               ? PickColor.secondaryColor
//                               : PickColor.primaryColor,
//                           fontWeight: FontWeight.w400,
//                           fontSize: 12.sp,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
