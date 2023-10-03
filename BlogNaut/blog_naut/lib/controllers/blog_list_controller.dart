import 'package:get/get.dart';

import '../blogs/models/blog_model.dart';

class BlogListController extends GetxController {
  var likedBlogsMap = {};
  void addBlogToFav(String? id, BlogModel? blogModel) {
    likedBlogsMap[id] = blogModel;
    update();
  }

  void removeBlogFromFav(String? id) {
    likedBlogsMap[id] = null;
    update();
  }
}
