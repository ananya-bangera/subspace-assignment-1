import 'package:blog_naut/authentication/login/login.dart';
import 'package:blog_naut/authentication/register/services/register_service.dart';
import 'package:blog_naut/home/home.dart';
import 'package:blog_naut/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  RegisterService service = RegisterService();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: SubspaceTheme.backGroundColor,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Already have an Account?",
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
                    return const Login();
                  }));
                },
                child: Text(
                  "Login",
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
                height: SubspaceTheme.getMobileWidth(context) * 0.4,
                width: SubspaceTheme.getMobileWidth(context) * 0.4,
                alignment: Alignment.topLeft,
                child: Image.asset("assets/images/register.png"),
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Get On Board!",
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
                      "Create your profile to start your Journey.",
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
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter full name";
                          }
                          return null;
                        },
                        cursorColor: SubspaceTheme.nearlyBlue,
                        style: SubspaceTheme.subtitleText(
                            size: SubspaceTheme.getMobileWidth(context) / 24,
                            weight: FontWeight.normal,
                            color: SubspaceTheme.nearlyGrey),
                        decoration: SubspaceTheme.waInputDecoration(
                            hint: "Name",
                            fontSize:
                                SubspaceTheme.getMobileWidth(context) / 24,
                            prefixIcon: Icons.person_4_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: SubspaceTheme.getMobileWidth(context),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
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
                            prefixIcon: CupertinoIcons.mail),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: SubspaceTheme.getMobileWidth(context),
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter phone number";
                          }
                          return null;
                        },
                        cursorColor: SubspaceTheme.nearlyBlue,
                        style: SubspaceTheme.subtitleText(
                            size: SubspaceTheme.getMobileWidth(context) / 24,
                            weight: FontWeight.normal,
                            color: SubspaceTheme.nearlyGrey),
                        decoration: SubspaceTheme.waInputDecoration(
                            hint: "Phone No",
                            fontSize:
                                SubspaceTheme.getMobileWidth(context) / 24,
                            prefixIcon: Icons.phone_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
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
                        obscureText: true,
                        cursorColor: SubspaceTheme.nearlyBlue,
                        style: SubspaceTheme.subtitleText(
                            size: SubspaceTheme.getMobileWidth(context) / 24,
                            weight: FontWeight.normal,
                            color: SubspaceTheme.nearlyGrey),
                        decoration: SubspaceTheme.waInputDecoration(
                            hint: "Password",
                            fontSize:
                                SubspaceTheme.getMobileWidth(context) / 24,
                            prefixIcon: Icons.fingerprint),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: SubspaceTheme.getMobileWidth(context) / 7,
                width: SubspaceTheme.getMobileWidth(context),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        service
                            .createUser(
                                name: _nameController.text.trim(),
                                phone: _phoneController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                                context: context)
                            .then((value) {
                          setState(() {
                            isLoading = false;
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
                    child: isLoading
                        ? SizedBox(
                            height: SubspaceTheme.getMobileWidth(context) / 20,
                            width: SubspaceTheme.getMobileWidth(context) / 20,
                            child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: SubspaceTheme.backGroundColor),
                          )
                        : Text("SIGNUP",
                            style: SubspaceTheme.subtitleText(
                                color: SubspaceTheme.backGroundColor,
                                size:
                                    SubspaceTheme.getMobileWidth(context) / 25,
                                weight: FontWeight.bold))),
              )
            ],
          ),
        )),
      ),
    );
  }
}
