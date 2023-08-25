import 'package:flutter/material.dart';
import 'package:ppp/Pages/Splash.dart';
import 'Model/UserModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static String ip = '192.168.43.251:8089';
  static var mainURL = "http://" + ip;
  static UserModel currentUser = null;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
    );
  }
}
