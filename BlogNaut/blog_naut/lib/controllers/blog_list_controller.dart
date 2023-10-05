import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blogs/models/blog_model.dart';

class BlogListController extends GetxController {
  var likedBlogsMap = {};
  Future<void> addBlogToFav(String? id, BlogModel? blogModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(id ?? "", true);

    likedBlogsMap[id] = blogModel;
    blogModel?.is_liked = true;

    update();
  }

  Future<bool?> isLiked(String? id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(id ?? "");
  }

  Future<void> removeBlogFromFav(String? id, BlogModel? blogModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(id ?? "", false);
    likedBlogsMap[id] = null;
    blogModel?.is_liked = false;
    update();
  }
}
