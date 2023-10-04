import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/blog_model.dart';
import 'package:get/get.dart';

class BlogFetchService {
  Future<List<BlogModel>> fetchBlogs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    final String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });
      print(response.body);
      print(
          "*************************************************@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      final parsed =
          await jsonDecode(response.body)["blogs"].cast<Map<String, dynamic>>();
      Set<String> savedBlogs = prefs.getKeys();
      List<BlogModel> blogModelList =
          parsed.map<BlogModel>((json) => BlogModel.fromJson(json)).toList();

      blogModelList.forEach((e) => {
            savedBlogs.forEach((element) {
              if (e.id == element && prefs.getBool(element) == true)
                e.is_liked = true;
            })
          });
      return blogModelList;
    } catch (e) {
      // Handle any errors that occurred during the request
      print(e);
      return [];
    }
  }
}
