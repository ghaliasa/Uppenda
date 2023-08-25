import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ppp/Model/UserModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ppp/controllers/CommentController.dart';
import 'package:ppp/controllers/PostController.dart';
import 'package:ppp/controllers/ReactionController.dart';
import 'package:ppp/controllers/TypeController.dart';
import 'package:ppp/controllers/UserController.dart';
import 'package:ppp/main.dart';
import 'package:http/http.dart' as http;

import 'Social_Home.dart';

class Enter extends StatefulWidget {
  UserModel userModel;

  Enter({this.userModel});

  @override
  _EnterState createState() => _EnterState();
}

class _EnterState extends State<Enter> {
  UserController userController = UserController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController studyLevelController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController ipController = TextEditingController();
  File _image;
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          padding: const EdgeInsets.only(
              top: 62, left: 12.0, right: 12.0, bottom: 12.0),
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple[100],
                            spreadRadius: 4,
                            blurRadius: 0,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      width: 250,
                      height: 190,
                      child: _image == null
                          ? Icon(
                              Icons.description,
                              size: 80,
                              color: Colors.purple,
                            )
                          : Image(
                              image: FileImage(_image),
                              fit: BoxFit.fill,
                            ),
                    ),
                    Positioned(
                      left: 200,
                      top: 140,
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.purple,
                        ),
                        onPressed: () async {
                          PickedFile pickedFile = await picker.getImage(
                              source: ImageSource.gallery, imageQuality: 50);

                          File image = File(pickedFile.path);

                          setState(
                            () {
                              _image = image;
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              child: TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: 'getFirstName',
                  hintText: 'getFirstName',
                  icon: new Icon(Icons.person),
                ),
              ),
            ),
            Container(
              height: 50,
              child: TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'getLastName',
                  hintText: 'getLastName',
                  icon: new Icon(Icons.email),
                ),
              ),
            ),
            Container(
              height: 50,
              child: TextField(
                controller: mobileController,
                decoration: InputDecoration(
                  labelText: 'getMobile',
                  hintText: 'getMobile',
                  icon: new Icon(Icons.place),
                ),
              ),
            ),
            Container(
              height: 50,
              child: TextField(
                controller: genderController,
                decoration: InputDecoration(
                  labelText: 'getGender',
                  hintText: 'getGender',
                  icon: new Icon(Icons.place),
                ),
              ),
            ),
            Container(
              height: 50,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'getPassword',
                  hintText: 'getPassword',
                  icon: new Icon(Icons.place),
                ),
              ),
            ),
            Container(
              height: 50,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'getEmail',
                  hintText: 'getEmail',
                  icon: new Icon(Icons.place),
                ),
              ),
            ),
            Container(
              height: 50,
              child: TextField(
                controller: studyLevelController,
                decoration: InputDecoration(
                  labelText: 'getStudyLevel',
                  hintText: 'getStudyLevel',
                  icon: new Icon(Icons.place),
                ),
              ),
            ),
            Container(
              height: 50,
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'getLocation',
                  hintText: 'getLocation',
                  icon: new Icon(Icons.place),
                ),
              ),
            ),
            Container(
              height: 50,
              child: TextField(
                controller: ipController,
                decoration: InputDecoration(
                  labelText: 'getIp',
                  hintText: 'getIp',
                  icon: new Icon(Icons.place),
                ),
              ),
            ),
            Padding(
              padding: new EdgeInsets.only(top: 44.0),
            ),
            Container(
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  widget.userModel = UserModel(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      mobile: mobileController.text,
                      gender: genderController.text,
                      password: passwordController.text,
                      email: emailController.text,
                      studyLevel: studyLevelController.text,
                      location: locationController.text,
                      ip: ipController.text,
                      imagePath: _image == null ? null : _image.path);
                  userController.addUser(widget.userModel);
                },
                color: Colors.green,
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.pink,
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.backpack),
              iconSize: 50,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SocialHome(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
