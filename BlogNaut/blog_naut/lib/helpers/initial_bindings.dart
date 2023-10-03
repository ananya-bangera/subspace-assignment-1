import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '../controllers/blog_list_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BlogListController());
  }
}
