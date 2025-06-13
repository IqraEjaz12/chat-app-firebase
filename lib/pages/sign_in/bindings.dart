import 'package:firebase_chat/pages/sign_in/controller.dart';
import 'package:get/get.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SiginInController>(() => SiginInController());
  }
}
