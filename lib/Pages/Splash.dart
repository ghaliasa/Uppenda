import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:ppp/Controllers/UserController.dart';
import 'package:ppp/Pages/Login.dart';
import 'package:ppp/Social/Social_Home.dart';
import 'package:ppp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 7),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SecoundScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      radius: 50,
      child: TextLiquidFill(
        text: 'Uppenda',
        waveColor: Colors.purple,
        boxBackgroundColor: Colors.white,
        boxHeight: 800.0,
        loadDuration: Duration(
          seconds: 6,
        ),
        textStyle: TextStyle(
          fontSize: 80.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 6,
          fontFamily: 'DancingScript',
        ),
      ),
    );
  }
}

class SecoundScreen extends StatefulWidget {
  @override
  _SecoundScreenState createState() => _SecoundScreenState();
}

class _SecoundScreenState extends State<SecoundScreen> {
  UserController userController = UserController();
  Future<String> getUserFromCache() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    return cache.getString('id');
  }

  Future<String> getTokenFromCache() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    return cache.getString('token');
  }

  bool mimo;

  @override
  void initState() {
    super.initState();
    getUserFromCache().then((value1) {
      setState(() {
        if (value1 != null) {
          setState(() {
            getTokenFromCache().then((tkn) {
              setState(() {
                MyApp.currentUser.setToken = tkn;
              });
            });
            userController.getUserById(value1).then((value) {
              setState(() {
                MyApp.currentUser = value;
                mimo = true;
                NetworkInterface.list().then((value2) {
                  setState(() {
                    MyApp.currentUser.setIp =
                        "/" + value2.first.addresses.first.address;
                    MyApp.currentUser.setOnLine = true;
                    userController
                        .updateUser(MyApp.currentUser, false)
                        .then((value3) {
                      setState(() {
                        if (value3 != null) {
                          MyApp.currentUser = value3;
                        }
                      });
                    });
                  });
                });
              });
            });
          });
        } else {
          setState(() {
            mimo = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SocialApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.white,
        primaryIconTheme: IconThemeData(
          color: Colors.purple,
        ),
        primaryTextTheme: TextTheme(
          subtitle1: TextStyle(
            color: Colors.purple,
          ),
        ),
        textTheme: TextTheme(
          subtitle1: TextStyle(
            color: Colors.purple,
          ),
        ),
      ),
      home: Scaffold(
        body: mimo == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : mimo
                ? SocialHome()
                : LogInPage(),
      ),
    );
  }
}
