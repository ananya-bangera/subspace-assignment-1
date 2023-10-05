import 'package:blog_naut/helpers/initial_bindings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentication/login/login.dart';
import 'home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget home = const Scaffold();

  @override
  void initState() {
    switchPage();
    super.initState();
  }

  void switchPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? session = await prefs.getString("session");

    if (session == null) {
      setState(() {
        home = Login();
      });
    } else {
      setState(() {
        home = HomePage();
      });
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBindings(),
      title: 'BlogNaut',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: home,
    );
  }
}
