import 'package:blog_naut/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget(
      {super.key,
      required this.size,
      required this.title,
      required this.onTap,
      this.endIcon = true,
      required this.titleColor,
      required this.iconData});

  final double size;
  final String title;
  final IconData iconData;
  final Color titleColor;
  final bool endIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: size / 8,
        height: size / 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 16),
          color: SubspaceTheme.nearlyBlue.withOpacity(0.4),
        ),
        child: Center(
            child: Icon(
          iconData,
          color: SubspaceTheme.darkishGrey,
        )),
      ),
      trailing: endIcon
          ? Container(
              width: size / 11,
              height: size / 11,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size / 22),
                  color: SubspaceTheme.darkishGrey.withOpacity(0.4)),
              child: Center(
                  child: Icon(
                CupertinoIcons.forward,
                color: SubspaceTheme.darkishGrey.withOpacity(0.8),
              )),
            )
          : null,
      title: Text(title,
          style: SubspaceTheme.titleText(
              size: size / 22, weight: FontWeight.w600, color: titleColor)),
    );
  }
}
