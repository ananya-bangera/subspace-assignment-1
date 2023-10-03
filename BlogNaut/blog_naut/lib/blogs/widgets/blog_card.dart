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
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.post.img_url ?? ""),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: SubspaceTheme.darkishGrey.withOpacity(0.3),
            )),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: SubspaceTheme.getMobileWidth(context) / 2.5,
                    height: SubspaceTheme.getMobileHeight(context) / 8,
                    decoration: BoxDecoration(
                        // image: DecorationImage(
                        //   image: NetworkImage(widget.post.img_url ?? ""),
                        //   fit: BoxFit.fill,
                        // ),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: SubspaceTheme.darkishGrey.withOpacity(0.3),
                        ))),
                // const SizedBox(
                //   width: 5,
                // ),
                GestureDetector(
                  onTap: () {
                    blogListController.likedBlogsMap[widget.post.id] != null
                        ? blogListController.removeBlogFromFav(widget.post.id)
                        : blogListController.addBlogToFav(
                            widget.post.id, widget.post);
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: GetBuilder<BlogListController>(
                      builder: (_) {
                        // bool IsLiked = blogListController
                        //             .likedBlogsMap[widget.post.id ?? ""] ==
                        //         null
                        //     ? false
                        //     : blogListController
                        //         .likedBlogsMap[widget.post.id ?? ""];
                        // print(IsLiked);
                        // return LikeButton(
                        //   isLiked: IsLiked,
                        // );

                        return (blogListController
                                    .likedBlogsMap[widget.post.id] ==
                                null)
                            ? Icon(CupertinoIcons.heart)
                            : Icon(CupertinoIcons.heart_fill,
                                color: SubspaceTheme.iconColorRed);
                      },
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
                widget.post.title.toString().substring(
                        0, min(widget.post.title.toString().length, 15)) +
                    " . . . ",
                style: SubspaceTheme.subtitleText(
                    size: SubspaceTheme.getMobileWidth(context) / 27,
                    color: SubspaceTheme.backGroundColor,
                    weight: FontWeight.w500))
          ],
        ));
  }
}
