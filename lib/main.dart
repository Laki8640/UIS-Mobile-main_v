import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:universal_identification_system/constant/preference_manager.dart';
import 'package:universal_identification_system/controller/selector_controller.dart';
import 'package:universal_identification_system/views/Api/view_model/form_view_model.dart';
import 'package:universal_identification_system/views/Api/view_model/sign_up_viewmodel.dart';
import 'package:universal_identification_system/views/bottom_screen.dart';
import 'package:universal_identification_system/views/form.dart';
import 'package:universal_identification_system/views/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
            title: 'UIS',
            theme: ThemeData(
              fontFamily: 'Poly',
            ),
            debugShowCheckedModeBanner: false,
            initialBinding: BaseBindings(),
            home: BottomBarScreen());
      },
    );
  }
}

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SignUpViewModel(), fenix: true);
    Get.lazyPut(() => SelectorController(), fenix: true);
    Get.lazyPut(() => FormViewModel(), fenix: true);
  }
}
