import 'dart:math';
import 'package:get/get.dart';
import 'package:blog_naut/blogs/models/blog_model.dart';
import 'package:blog_naut/controllers/blog_list_controller.dart';
import 'package:blog_naut/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:like_button/like_button.dart';

class BlogCard extends StatefulWidget {
  BlogCard(this.post, {Key? key}) : super(key: key);
  BlogModel post;
  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  String date = "";
  BlogListController blogListController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Get.to(),
      child: Container(
        height: SubspaceTheme.getMobileHeight(context) / 4.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: SubspaceTheme.darkishGrey.withOpacity(0.3),
            )),
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Container(
                height: SubspaceTheme.getMobileHeight(context) / 6,
                margin: const EdgeInsets.only(bottom: 10),
                // padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.post.img_url ?? ""),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    border: Border.all(
                      color: SubspaceTheme.darkishGrey.withOpacity(0.3),
                    )),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.all(20),
                          child: GetBuilder<BlogListController>(
                            builder: (_) {
                              return LikeButton(
                                  onTap: (_) {
                                    blogListController.likedBlogsMap[
                                                widget.post.id] !=
                                            null
                                        ? blogListController.removeBlogFromFav(
                                            widget.post.id, widget.post)
                                        : blogListController.addBlogToFav(
                                            widget.post.id, widget.post);
                                    return blogListController
                                        .isLiked(widget.post.id);
                                  },
                                  isLiked: (widget.post.is_liked ?? false) ||
                                      !(blogListController
                                              .likedBlogsMap[widget.post.id] ==
                                          null));
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )),
            Text(
                widget.post.title.toString().substring(
                        0, min(widget.post.title.toString().length, 15)) +
                    " . . . ",
                style: SubspaceTheme.subtitleText(
                    size: SubspaceTheme.getMobileWidth(context) / 27,
                    color: SubspaceTheme.darkishGrey,
                    weight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}
