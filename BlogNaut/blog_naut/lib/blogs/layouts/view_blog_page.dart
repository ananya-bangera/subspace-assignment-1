import 'dart:math';

import 'package:blog_naut/blogs/models/blog_model.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  BlogPage(this.blogModel, {Key? key}) : super(key: key);
  BlogModel? blogModel;
  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: SubspaceTheme.darkishGrey,
          elevation: 0.0,
          automaticallyImplyLeading: true,
          title: Text(
            (widget.blogModel?.title.toString().substring(
                        0,
                        min(widget.blogModel?.title.toString().length ?? 16,
                            15)) ??
                    "") +
                " . . . ",
            style: SubspaceTheme.titleText(
                color: SubspaceTheme.darkishGrey,
                size: SubspaceTheme.getMobileWidth(context) / 20,
                weight: FontWeight.bold),
          ),
        ),
        body: Builder(builder: (context) {
          return Container(
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.all(10),
                    height: SubspaceTheme.getMobileHeight(context) / 4.5,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.blogModel?.img_url ?? ""),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: SubspaceTheme.darkishGrey.withOpacity(0.3),
                        )),
                    child: Container()),
                Container(
                  child: Text(widget.blogModel?.title ?? "",
                      style: SubspaceTheme.subtitleText(
                          size: SubspaceTheme.getMobileWidth(context) / 27,
                          color: SubspaceTheme.darkishGrey,
                          weight: FontWeight.w500)),
                )
              ],
            ),
          );
        }));
  }
}
