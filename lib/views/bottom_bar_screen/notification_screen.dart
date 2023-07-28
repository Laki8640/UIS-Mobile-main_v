import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:universal_identification_system/constant/image_path.dart';
import 'package:universal_identification_system/controller/selector_controller.dart';

class NotiFicationScreen extends StatefulWidget {
  const NotiFicationScreen({Key? key}) : super(key: key);

  @override
  State<NotiFicationScreen> createState() => _NotiFicationScreenState();
}

class _NotiFicationScreenState extends State<NotiFicationScreen> {
  SelectorController selectorController = Get.put(SelectorController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectorController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
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
              'Notifications',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.grey.shade100,
          ),
          body: Column(
            children: [
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.builder(physics: BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              //color of shadow
                              spreadRadius: 7,
                              //spread radius
                              blurRadius: 7,
                              // blur radius
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(6.r)),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 10.h),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              ImagePath.noti,
                              height: 40.h,
                              width: 40.w,
                            ),
                            SizedBox(
                              width: 9.w,
                            ),
                            Text(
                              'Lorem Ipsum is simply dummy text of the ext\nof theext of the ',
                              style: TextStyle(
                                  color: const Color(0xff959595),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            ),const Spacer(),Text(
                              '2 min',
                              style: TextStyle(
                                  color: const Color(0xff959595),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
