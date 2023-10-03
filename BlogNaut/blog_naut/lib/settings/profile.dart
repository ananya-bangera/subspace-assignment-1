// ignore_for_file: must_be_immutable

import 'package:blog_naut/settings/widgets/profile_menu_widget.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authentication/login/login.dart';
import '../home/models/verified-user-model.dart';

class Profile extends StatefulWidget {
  Profile({super.key, required this.user});
  VerifiedUser user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: SubspaceTheme.backGroundColor,
      appBar: AppBar(
        backgroundColor: SubspaceTheme.backGroundColor,
        foregroundColor: SubspaceTheme.darkishGrey,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: SubspaceTheme.titleText(
              size: size / 15,
              weight: FontWeight.bold,
              color: SubspaceTheme.darkishGrey),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 20),
                  height: size / 3.5,
                  width: size / 3.5,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      color: SubspaceTheme.nearlyBlue.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(size / 7)),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.person_solid,
                      size: size / 5.5,
                      color: SubspaceTheme.darkishGrey,
                    ),
                  )),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 0),
                child: Text(
                  widget.user.name!,
                  style: SubspaceTheme.titleText(
                      size: size / 18,
                      weight: FontWeight.bold,
                      color: SubspaceTheme.darkishGrey),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 20),
                child: Text(
                  widget.user.email!,
                  style: SubspaceTheme.subtitleText(
                      size: size / 25,
                      weight: FontWeight.w600,
                      color: SubspaceTheme.nearlyGrey.withOpacity(0.5)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Divider(),
                    ProfileMenuWidget(
                      onTap: () {},
                      size: size,
                      title: "Settings",
                      titleColor: SubspaceTheme.darkishGrey,
                      iconData: CupertinoIcons.settings,
                    ),
                    ProfileMenuWidget(
                      onTap: () {},
                      size: size,
                      title: "Profile Management",
                      titleColor: SubspaceTheme.darkishGrey,
                      iconData:
                          CupertinoIcons.person_crop_circle_badge_checkmark,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    ProfileMenuWidget(
                      onTap: () {},
                      size: size,
                      title: "Information",
                      titleColor: SubspaceTheme.darkishGrey,
                      iconData: CupertinoIcons.info,
                    ),
                    ProfileMenuWidget(
                      onTap: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.remove("session").then((value) {
                          PersistentNavBarNavigator.pushNewScreen(context,
                              screen: const Login(),
                              withNavBar: false,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.scale);
                        });
                      },
                      size: size,
                      endIcon: false,
                      title: "Logout",
                      titleColor: Colors.redAccent,
                      iconData: CupertinoIcons.power,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
