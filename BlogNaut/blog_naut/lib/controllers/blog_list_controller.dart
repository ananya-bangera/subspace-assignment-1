import 'package:get/get.dart';

import '../blogs/models/blog_model.dart';

class BlogListController extends GetxController {
  List<BlogModel> listOfBlogs = [];
  List<BlogModel> get _listOfBlogs => listOfBlogs;
}
