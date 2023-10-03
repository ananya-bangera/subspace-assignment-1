// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api
import 'package:blog_naut/common/subspace_store.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../blogs/view_blogs_list.dart';
import '../settings/profile.dart';
import 'models/verified-user-model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  SubspaceStore store = SubspaceStore();
  bool loader = false;
  late VerifiedUser user;

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  getUserDetails() {
    setState(() {
      loader = true;
    });
    store.getUserDetails().then((value) {
      setState(() {
        loader = false;
      });
      user = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (loader) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: SubspaceTheme.backGroundColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: SubspaceTheme.getMobileWidth(context) / 15,
                    width: SubspaceTheme.getMobileWidth(context) / 15,
                    child: const CircularProgressIndicator(
                        strokeWidth: 3, color: SubspaceTheme.nearlyBlue),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text("Rolling In",
                        style: SubspaceTheme.titleText(
                            size: SubspaceTheme.getMobileWidth(context) / 18,
                            color: SubspaceTheme.nearlyGrey,
                            weight: FontWeight.bold)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text("Gathering stuffs!",
                        style: SubspaceTheme.titleText(
                            size: SubspaceTheme.getMobileWidth(context) / 28,
                            color: SubspaceTheme.nearlyGrey.withOpacity(0.8),
                            weight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return buildWidget(context);
      }
    });
  }

  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: PersistentTabView(
        context,
        backgroundColor: SubspaceTheme.backGroundColor,
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.easeIn,
        ),
        decoration: NavBarDecoration(
            border:
                Border(top: BorderSide(color: Colors.grey.withOpacity(0.2)))),
        screens: [
          BlogsPage(),
          Profile(
            user: user,
          ),
        ],
        items: [
          PersistentBottomNavBarItem(
              icon: Icon(CupertinoIcons.house,
                  size: SubspaceTheme.getMobileWidth(context) / 17),
              inactiveColorPrimary: Colors.grey,
              activeColorSecondary: Colors.white,
              activeColorPrimary: SubspaceTheme.nearlyBlue,
              title: "Blogs",
              textStyle: SubspaceTheme.subtitleText(
                  size: SubspaceTheme.getMobileWidth(context) / 30,
                  weight: FontWeight.w600)),
          PersistentBottomNavBarItem(
              icon: Icon(
                CupertinoIcons.settings,
                size: SubspaceTheme.getMobileWidth(context) / 17,
              ),
              inactiveColorPrimary: Colors.grey,
              activeColorSecondary: Colors.white,
              activeColorPrimary: SubspaceTheme.nearlyBlue,
              title: "Settings",
              textStyle: SubspaceTheme.subtitleText(
                  size: SubspaceTheme.getMobileWidth(context) / 30,
                  weight: FontWeight.w600)),
        ],
        controller: _controller,
        confineInSafeArea: true,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: false,
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        navBarStyle: NavBarStyle.style10,
      ),
    );
  }
}
