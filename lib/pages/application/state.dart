import 'package:get/get.dart';

class ApplicationState {
  final page = 0.obs;
  int get currentPage => page.value;
}
