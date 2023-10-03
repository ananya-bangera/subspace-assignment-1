import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blogs/models/blog_model.dart';

class BlogListController extends GetxController {
  var likedBlogsMap = {};
  void addBlogToFav(String? id, BlogModel? blogModel) {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool(id ?? "", true);
    likedBlogsMap[id] = blogModel;
    // print("*******************************************");
    // print(likedBlogsMap);
    update();
  }

  // bool isLiked(String? id) async {
  //   return prefs.getBool(id ?? "");
  // }

  void removeBlogFromFav(String? id) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool(id ?? "", false);
    likedBlogsMap[id] = null;
    update();
  }
}
