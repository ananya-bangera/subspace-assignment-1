import 'dart:async';
import 'dart:convert';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
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

      var cacheExits = await APICacheManager().isAPICacheKeyExist("blog_data");

      if (response.statusCode != 200) {
        var cacheData = await APICacheManager().getCacheData("blog_data");
        if (!cacheExits) return [];

        final parsed = await jsonDecode(cacheData.syncData)["blogs"]
            .cast<Map<String, dynamic>>();
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
      } else {
        APICacheDBModel cacheDBModel = new APICacheDBModel(
            key: "blog_data", syncData: response.body.toString());
        await APICacheManager().addCacheData(cacheDBModel);
        var cacheData = await APICacheManager().getCacheData("blog_data");

        final parsed = await jsonDecode(response.body)["blogs"]
            .cast<Map<String, dynamic>>();
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
      }
    } catch (e) {
      {
        var cacheExits =
            await APICacheManager().isAPICacheKeyExist("blog_data");
        var cacheData = await APICacheManager().getCacheData("blog_data");
        if (!cacheExits) return [];

        final parsed = await jsonDecode(cacheData.syncData)["blogs"]
            .cast<Map<String, dynamic>>();
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
      }
    }
  }
}
