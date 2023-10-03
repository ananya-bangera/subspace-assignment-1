import 'package:blog_naut/blogs/services/blog_fetch_service.dart';
import 'package:blog_naut/common/subspace_store.dart';
import 'package:blog_naut/controllers/blog_list_controller.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/material.dart';
import 'models/blog_model.dart';
import 'package:get/get.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({Key? key}) : super(key: key);

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  SubspaceStore store = SubspaceStore();
  final BlogFetchService blogFetchService = BlogFetchService();

  // @override
  // void initState() {
  //   blogsListController.fetchBlogs();
  // }

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
              // GestureDetector(
              //   onTap: () {
              //     print(blogsListController.listOfBlogs);
              //   },
              //   child: Text("Get Blogs"),
              // ),
              Expanded(
                  child: FutureBuilder<List<BlogModel>>(
                future: blogFetchService.fetchBlogs(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<BlogModel>? posts = snapshot.data;
                    print("***********************" + posts.toString());
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: 40, left: 0, right: 0),
                        itemCount: posts!.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              horizontalOffset: 80,
                              child: FadeInAnimation(
                                child: Text(posts[index].title ?? ""),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
