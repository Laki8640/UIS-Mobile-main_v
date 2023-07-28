import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:universal_identification_system/constant/image_path.dart';
import 'package:universal_identification_system/views/form.dart';

import '../../constant/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final drawerKey = GlobalKey<ScaffoldState>();
  var getResult = 'QR Code Result';

  // scanQRCode() async {
  //   try {
  //     final qrCode = await FlutterBarcodeScanner.scanBarcode(
  //       '#ff6666',
  //       'Cancel',
  //       true,
  //       ScanMode.DEFAULT,
  //     );
  //
  //     if (!mounted) return;
  //
  //     setState(() {
  //       getResult = qrCode;
  //     });
  //     print("QRCode_Result:--");
  //     print(qrCode);
  //
  //     Navigator.push(context,
  //         MaterialPageRoute(builder: (BuildContext context) {
  //       return const FormScreen();
  //     }));
  //   } on PlatformException {
  //     getResult = 'Failed to scan QR Code.';
  //   }
  // }

  @override
  void initState() {
    // Container(child: scanQRCode(),height: 200,width: 300,color: Colors.red,);
    // scanQRCode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      backgroundColor: Colors.grey.shade100,
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        centerTitle: true,
        title: Image.asset(
          ImagePath.logoImage,
          height: 34.h,
          width: 65.w,
        ),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            drawerKey.currentState!.openDrawer();
          },
          child: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ElevatedButton(
              //     onPressed: () async {
              //       scanQRCode();
              //     },
              //     child: const Text('Scanner')),
              // Text(getResult),
              SizedBox(height: 15.h),
              GestureDetector(onTap: () {
                Get.to(FormScreen());
              },
                child: Center(
                  child: Image.asset(
                    'assets/images/qr.png',
                    height: 291.h,
                    width: 291.w,
                  ),
                ),
              ),
              SizedBox(height: 60.h),
              Text(
                'Notice',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20.h),
              Container(

                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), //color of shadow
                        spreadRadius: 7, //spread radius
                        blurRadius: 7, // blur radius
                        offset: const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(6.r)),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 17.w,vertical: 18.h),
                  child: Text(
                    'Lorem Ipsum is simply dummy text of the ',
                    style: TextStyle(
                        color: Color(0xff959595),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(height: 13.h),
              Container(

                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1), //color of shadow
                        spreadRadius: 5, //spread radius
                        blurRadius: 7, // blur radius
                        offset: const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(6.r)),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 17.w,vertical: 18.h),
                  child: Text(
                    'Lorem Ipsum is simply dummy text of the ',
                    style: TextStyle(
                        color: Color(0xff959595),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
