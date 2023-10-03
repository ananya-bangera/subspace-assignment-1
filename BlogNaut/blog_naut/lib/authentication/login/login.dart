import 'package:blog_naut/utils/theme.dart';
import 'package:flutter/material.dart';

import '../register/register.dart';
import 'layout/login_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: SubspaceTheme.backGroundColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 50, right: 10, left: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                height: SubspaceTheme.getMobileWidth(context) / 8,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                    },
                    style: SubspaceTheme.buttonStyle(
                        backColor: SubspaceTheme.nearlyBlue),
                    child: Text("LOGIN",
                        style: SubspaceTheme.subtitleText(
                            color: SubspaceTheme.backGroundColor,
                            size: SubspaceTheme.getMobileWidth(context) / 25,
                            weight: FontWeight.bold))),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                height: SubspaceTheme.getMobileWidth(context) / 8,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Register();
                      }));
                    },
                    style: SubspaceTheme.buttonStyle(
                        backColor: SubspaceTheme.backGroundColor,
                        borderColor: SubspaceTheme.nearlyBlue),
                    child: Text("SIGNUP",
                        style: SubspaceTheme.subtitleText(
                            color: SubspaceTheme.nearlyBlue,
                            size: SubspaceTheme.getMobileWidth(context) / 25,
                            weight: FontWeight.bold))),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ]),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: SizedBox(
                  width: SubspaceTheme.getMobileWidth(context),
                  height: SubspaceTheme.getMobileHeight(context) * 0.6,
                  child: Image.asset('assets/images/welcome.png'),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Text(
                        "Reliable and Fast to use",
                        style: SubspaceTheme.titleText(
                            size: SubspaceTheme.getMobileWidth(context) / 15,
                            weight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "Embark on a cosmic journey through the blogosphere with BlogNaut!",
                          textAlign: TextAlign.center,
                          style: SubspaceTheme.subtitleText(
                              size: SubspaceTheme.getMobileWidth(context) / 27,
                              weight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
