import 'package:get/get.dart';

class SelectorController extends GetxController {
  int selector = 0;
  bool obs=true;
  bool obss=true;

  selected(int index) {
    selector = index;
    update();
  }

  isObscure(){
    obs=!obs;
    update();
  }
  isObscures(){
    obss=!obss;
    update();
  }

}
