// ignore_for_file: unused_field
import 'package:blog_naut/home/home.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../register/register.dart';
import '../../register/services/register_service.dart';
import '../widgets/forgot_password_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading1 = false;
  bool isLoading2 = false;
  bool obscureText = true;
  RegisterService service = RegisterService();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: SubspaceTheme.backGroundColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Don't have an Account?",
                style: SubspaceTheme.subtitleText(
                    size: SubspaceTheme.getMobileWidth(context) / 28,
                    weight: FontWeight.w500,
                    color: SubspaceTheme.darkishGrey),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const Register();
                  }));
                },
                child: Text(
                  "Sign-up",
                  style: SubspaceTheme.subtitleText(
                      size: SubspaceTheme.getMobileWidth(context) / 28,
                      weight: FontWeight.bold,
                      color: SubspaceTheme.nearlyBlue),
                ),
              )
            ],
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SubspaceTheme.getMobileWidth(context) * 0.55,
                width: SubspaceTheme.getMobileWidth(context) * 0.55,
                alignment: Alignment.topLeft,
                child: Image.asset("assets/images/login.png"),
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome Back,",
                      textDirection: TextDirection.ltr,
                      style: SubspaceTheme.titleText(
                          letterSpacing: -1,
                          size: SubspaceTheme.getMobileWidth(context) / 12.5,
                          weight: FontWeight.bold,
                          color: SubspaceTheme.darkishGrey),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Make it work, make it right, make it fast.",
                      textDirection: TextDirection.ltr,
                      style: SubspaceTheme.titleText(
                          size: SubspaceTheme.getMobileWidth(context) / 24,
                          weight: FontWeight.w500,
                          color: SubspaceTheme.nearlyGrey),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: SubspaceTheme.getMobileWidth(context),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter email";
                          } else if (!RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(value.trim())) {
                            return "Email is not valid";
                          }
                          return null;
                        },
                        cursorColor: SubspaceTheme.nearlyBlue,
                        style: SubspaceTheme.subtitleText(
                            size: SubspaceTheme.getMobileWidth(context) / 24,
                            weight: FontWeight.normal,
                            color: SubspaceTheme.nearlyGrey),
                        decoration: SubspaceTheme.waInputDecoration(
                            hint: "Email",
                            fontSize:
                                SubspaceTheme.getMobileWidth(context) / 24,
                            prefixIcon: CupertinoIcons.person),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: SubspaceTheme.getMobileWidth(context),
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password";
                          }
                          return null;
                        },
                        obscureText: obscureText,
                        cursorColor: SubspaceTheme.nearlyBlue,
                        style: SubspaceTheme.subtitleText(
                            size: SubspaceTheme.getMobileWidth(context) / 24,
                            weight: FontWeight.normal,
                            color: SubspaceTheme.nearlyGrey),
                        decoration: SubspaceTheme.waInputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              child: Icon(
                                  obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: SubspaceTheme.nearlyGrey
                                      .withOpacity(0.5)),
                            ),
                            hint: "Password",
                            fontSize:
                                SubspaceTheme.getMobileWidth(context) / 24,
                            prefixIcon: Icons.fingerprint),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  buildShowModalBottomSheet(
                      context, SubspaceTheme.getMobileWidth(context));
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(bottom: 20, top: 10),
                  child: Text(
                    "Forgot Password?",
                    style: SubspaceTheme.titleText(
                        size: SubspaceTheme.getMobileWidth(context) / 28,
                        weight: FontWeight.w600,
                        color: SubspaceTheme.nearlyBlue),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: SubspaceTheme.getMobileWidth(context) / 7,
                    width: SubspaceTheme.getMobileWidth(context),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading1 = true;
                            });
                            service
                                .loginUser(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    context: context)
                                .then((value) {
                              setState(() {
                                isLoading1 = false;
                              });
                              if (value is UserCredential) {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomePage();
                                }));
                              }
                            });
                          }
                        },
                        style: SubspaceTheme.buttonStyle(
                            backColor: SubspaceTheme.nearlyBlue),
                        child: isLoading1
                            ? SizedBox(
                                height:
                                    SubspaceTheme.getMobileWidth(context) / 20,
                                width:
                                    SubspaceTheme.getMobileWidth(context) / 20,
                                child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: SubspaceTheme.backGroundColor),
                              )
                            : Text("LOGIN",
                                style: SubspaceTheme.subtitleText(
                                    color: SubspaceTheme.backGroundColor,
                                    size:
                                        SubspaceTheme.getMobileWidth(context) /
                                            25,
                                    weight: FontWeight.bold))),
                  ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(
      BuildContext context, double width) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Make Selection!",
                  style: SubspaceTheme.titleText(
                      size: width / 15,
                      weight: FontWeight.w600,
                      color: SubspaceTheme.darkishGrey),
                ),
                Text(
                  "Select one of the options given below to reset your password.",
                  style: SubspaceTheme.subtitleText(
                      size: width / 25,
                      weight: FontWeight.w500,
                      color: SubspaceTheme.darkishGrey),
                ),
                SizedBox(
                  height: width / 10,
                ),
                ForgotPassWidget(
                  width: width,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  data: Icons.mail_outline_rounded,
                  description: "Reset via E-mail Verification.",
                  title: "E-mail",
                ),
              ],
            ),
          );
        });
  }
}
