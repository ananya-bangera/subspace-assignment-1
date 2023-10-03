import 'package:blog_naut/common/subspace_store.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/blog_model.dart';
import 'dart:async';
import 'dart:convert';

class BlogsPage extends StatefulWidget {
  const BlogsPage({Key? key}) : super(key: key);

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  SubspaceStore store = SubspaceStore();
  Future<List<BlogModel>> fetchBlogs() async {
    final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    final String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<BlogModel>((json) => BlogModel.fromJson(json)).toList();
    } catch (e) {
      // Handle any errors that occurred during the request
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SubspaceTheme.backGroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 10),
                    child: Text("Bill History",
                        style: SubspaceTheme.titleText(
                            size: SubspaceTheme.getMobileWidth(context) / 11,
                            color: SubspaceTheme.darkishGrey,
                            weight: FontWeight.bold)),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("View all your Decentralized bills instantly",
                        style: SubspaceTheme.subtitleText(
                            size: SubspaceTheme.getMobileWidth(context) / 27,
                            color: SubspaceTheme.nearlyGrey,
                            weight: FontWeight.w500)),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 40, left: 0, right: 0),
                    itemCount: 6,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          horizontalOffset: 80,
                          child: FadeInAnimation(
                            child: Text("Style"),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
