import 'package:firebase_chat/pages/application/controller.dart';
import 'package:get/get.dart';

class ApplicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
  }
}
