import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ppp/Controllers/UserController.dart';
import 'package:ppp/Model/UserModel.dart';
import 'package:ppp/Pages/profile.dart';
import 'package:ppp/Social/Social_Home.dart';
import 'package:ppp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  final UserModel userModel;
  EditProfile({this.userModel});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DateTime _dateTime = null;
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController studyLevelController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  UserController _userController = new UserController();

  File _image;
  bool isSwitched = false;
  String selectedImage;
  final picker = ImagePicker();
  TextEditingController textEditingControllerName;

  String profileId;
  Future<String> getUserFromCache() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    return cache.getString('id');
  }

  @override
  void initState() {
    super.initState();
    getUserFromCache().then((idFromChash) {
      setState(() {
        profileId = idFromChash;
      });
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        selectedImage = _image.path;
      } else {
        print('No image selected.');
      }
      print(' ////////////////////' + _image.path);
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: widget.userModel == null
            ? Center(child: Center(child: CircularProgressIndicator()))
            : Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.purple,
                    Colors.deepPurple,
                  ],
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter,
                )),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Profile(
                                            user_id: profileId,
                                          )));
                                },
                                child: Icon(
                                  Icons.chevron_left,
                                  color: Colors.white,
                                  size: 22,
                                )),
                            CircleAvatar(
                              maxRadius: 60,
                              backgroundColor: Colors.transparent,
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontFamily: 'DancingScript',
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ),
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SocialHome()));
                                },
                                child: Icon(
                                  Icons.home,
                                  color: Colors.white,
                                  size: 22,
                                ))
                          ],
                        ),
                      ),
                    ),

                    Card(
                      margin: EdgeInsets.only(
                        left: 14,
                        right: 14,
                        bottom: 10,
                      ),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50)),
                      child: Container(
                          height: ((3 * height) / 4) + ((height / 4) - 145),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                                topRight: Radius.circular(30),
                              )),
                          child: ListView(
                            children: [
                              Center(
                                  child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.purple[600], width: 4)),
                                child: CircleAvatar(
                                  // backgroundColor: Colors.purple[100],
                                  backgroundImage: _image == null &&
                                          widget.userModel.getImage != null
                                      ? NetworkImage(MyApp.mainURL +
                                          widget.userModel.getImage
                                              .toString()
                                              .replaceAll("\\", "/"),headers: {
                            "Authorization":
                                "Bearer " + MyApp.currentUser.getToken
                          },)
                                      : (_image == null
                                          ? AssetImage("images/download.jpg")
                                          : FileImage(_image)),
                                  maxRadius: 80,
                                ),
                              )),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    FlatButton(
                                        onPressed: getImageFromCamera,
                                        child: Icon(
                                          Icons.add_a_photo,
                                          color: Colors.deepPurple,
                                        )),
                                    FlatButton(
                                        onPressed: getImageFromGallery,
                                        child: Icon(
                                          Icons.photo,
                                          color: Colors.deepPurple,
                                        )),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.deepPurple,
                                thickness: 0.8,
                              ),
                              Center(
                                  child: Text(
                                "Edit Your Name:",
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontFamily: 'Merienda'),
                              )),
                              ListTile(
                                title: new TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: firstNameController,
                                    decoration: new InputDecoration(
                                        hintText: widget.userModel.getFirstName,
                                        hintStyle: TextStyle(
                                            color: Colors.purple,
                                            fontFamily: 'Merienda'),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0)),
                                            borderSide: BorderSide(
                                                color: Colors.purple[100],
                                                width: 1.0)))),
                              ),
                              Divider(
                                color: Colors.deepPurple,
                                thickness: 0.8,
                              ),
                              Center(
                                  child: Text(
                                "Edit your last name",
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontFamily: 'Merienda'),
                              )),
                              ListTile(
                                title: new TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: lastNameController,
                                    decoration: new InputDecoration(
                                        hintText: widget.userModel.getLastName,
                                        hintStyle: TextStyle(
                                            color: Colors.purple,
                                            fontFamily: 'Merienda'),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0)),
                                            borderSide: BorderSide(
                                                color: Colors.purple[100],
                                                width: 1.0)))),
                              ),
                              Divider(
                                color: Colors.deepPurple,
                                thickness: 0.8,
                              ),
                              Center(
                                  child: Text(
                                "Edit Your Gender:",
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontFamily: 'Merienda'),
                              )),
                              ListTile(
                                title: new TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: genderController,
                                    decoration: new InputDecoration(
                                        hintText: widget.userModel.getGender,
                                        hintStyle: TextStyle(
                                            color: Colors.purple,
                                            fontFamily: 'Merienda'),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0)),
                                            borderSide: BorderSide(
                                                color: Colors.purple[100],
                                                width: 1.0)))),
                              ),
                              Divider(
                                color: Colors.deepPurple,
                                thickness: 0.8,
                              ),
                              Center(
                                  child: Text(
                                "Edit Your Date:",
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontFamily: 'Merienda'),
                              )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                      _dateTime != null
                                          ? "your age :                " +
                                              _dateTime.year.toString() +
                                              "/" +
                                              _dateTime.month.toString() +
                                              "/" +
                                              _dateTime.day.toString()
                                          : "your age :                " +
                                              widget.userModel.age.year
                                                  .toString() +
                                              "/" +
                                              widget.userModel.age.month
                                                  .toString() +
                                              "/" +
                                              widget.userModel.age.day
                                                  .toString(),
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontFamily: 'Merienda',
                                      )),
                                  FlatButton(
                                      onPressed: () {
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime(1990, 1, 1),
                                            maxTime: DateTime.now(),
                                            onChanged: (date) {
                                          print('change $date');
                                        }, onConfirm: (date) {
                                          setState(() {
                                            print('confirm $date');
                                            _dateTime = date;
                                          });
                                        },
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.en);
                                      },
                                      child: Icon(
                                        Icons.date_range,
                                        size: 35,
                                        color: Colors.deepPurple,
                                      ))
                                ],
                              ),
                              Divider(
                                color: Colors.deepPurple,
                                thickness: 0.8,
                              ),
                              Center(
                                  child: Text(
                                "Edit Your Study Level:",
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontFamily: 'Merienda'),
                              )),
                              ListTile(
                                title: new TextField(
                                    textAlign: TextAlign.center,
                                    controller: studyLevelController,
                                    decoration: new InputDecoration(
                                        hintText:
                                            widget.userModel.getStudyLevel,
                                        hintStyle: TextStyle(
                                            color: Colors.purple,
                                            fontFamily: 'Merienda'),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0)),
                                            borderSide:
                                                BorderSide(color: Colors.purple[100], width: 1.0)))),
                              ),
                              Divider(
                                color: Colors.deepPurple,
                                thickness: 0.8,
                              ),
                              Center(
                                  child: Text(
                                "Edit Your Location:",
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontFamily: 'Merienda'),
                              )),
                              ListTile(
                                title: new TextField(
                                    textAlign: TextAlign.center,
                                    controller: locationController,
                                    decoration: new InputDecoration(
                                        hintText: widget.userModel.getLocation == null
                                            ? "city , country"
                                            : widget.userModel.getLocation,
                                        hintStyle: TextStyle(
                                            color: Colors.purple,
                                            fontFamily: 'Merienda'),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                                            borderSide: BorderSide(color: Colors.purple[100], width: 1.0)))),
                              ),
                              Divider(
                                color: Colors.deepPurple,
                                thickness: 0.8,
                              ),
                              Center(
                                  child: Text(
                                "Edit Your Email:",
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontFamily: 'Merienda'),
                              )),
                              ListTile(
                                title: new TextField(
                                    textAlign: TextAlign.center,
                                    controller: emailController,
                                    decoration: new InputDecoration(
                                        hintText: widget.userModel.getEmail,
                                        hintStyle: TextStyle(
                                            color: Colors.purple,
                                            fontFamily: 'Merienda'),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0)),
                                            borderSide: BorderSide(
                                                color: Colors.purple[100],
                                                width: 1.0)))),
                              ),
                              Divider(
                                color: Colors.deepPurple,
                                thickness: 0.8,
                              ),
                              Center(
                                  child: Text(
                                "Edit Your mobile:",
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontFamily: 'Merienda'),
                              )),
                              ListTile(
                                title: new TextField(
                                    textAlign: TextAlign.center,
                                    controller: mobileController,
                                    decoration: new InputDecoration(
                                        hintText:
                                            widget.userModel.getMobile == null
                                                ? "09**********"
                                                : widget.userModel.getMobile,
                                        hintStyle: TextStyle(
                                            color: Colors.purple,
                                            fontFamily: 'Merienda'),
                                        prefixStyle: TextStyle(
                                            color: Colors.purple[100],
                                            fontFamily: 'Merienda'),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0))),
                                        focusedBorder:
                                            OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(32.0)), borderSide: BorderSide(color: Colors.purple[100], width: 1.0)))),
                              ),
                              Divider(
                                color: Colors.deepPurple,
                                thickness: 0.8,
                              ),
                              Center(
                                  child: Text(
                                "PassWord:",
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontFamily: 'Merienda'),
                              )),
                              ListTile(
                                title: new TextFormField(
                                    obscureText: true,
                                    //maxLength: 8,
                                    textAlign: TextAlign.center,
                                    controller: passwordController,
                                    decoration: new InputDecoration(
                                        hintText:
                                            widget.userModel.getPassword == null
                                                ? "**********"
                                                : widget.userModel.getPassword,
                                        hintStyle: TextStyle(
                                            color: Colors.purple,
                                            fontFamily: 'Merienda'),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.purple,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(32.0)),
                                            borderSide: BorderSide(color: Colors.purple[100], width: 1.0))
                                        //minVerticalPadding: double.negativeInfinity,
                                        /*
                              leading: Icon(
                              Icons.edit,
                              size: 30,
                              color: Colors.purple,
                              ),*/
                                        )),
                              ),
                              Divider(
                                color: Colors.deepPurple,
                                thickness: 0.8,
                              ),
                              Center(
                                child: Card(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Container(
                                      height: 40,
                                      width: width / 5,
                                      decoration: BoxDecoration(
                                          color: Colors.white70,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(40),
                                              topRight: Radius.circular(40),
                                              bottomLeft: Radius.circular(40),
                                              bottomRight: Radius.circular(40)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromRGBO(
                                                    233, 177, 236, 1),
                                                spreadRadius: 4,
                                                blurRadius: 8,
                                                offset: Offset(0, 0)),
                                          ]),
                                      child: Center(
                                          child: IconButton(
                                              icon: Text(
                                                "Save",
                                                style: TextStyle(
                                                    color: Colors.purple,
                                                    fontSize: 14),
                                              ),
                                              onPressed: () {
                                                UserModel user = new UserModel(
                                                    ip: widget.userModel.getIp,
                                                    password: passwordController.text.length == 0
                                                        ? widget.userModel
                                                            .getPassword
                                                        : passwordController
                                                            .text,
                                                    email: emailController.text.length == 0
                                                        ? widget
                                                            .userModel.getEmail
                                                        : emailController.text,
                                                    studyLevel:
                                                        studyLevelController.text.length == 0
                                                            ? widget.userModel
                                                                .getStudyLevel
                                                            : studyLevelController
                                                                .text,
                                                    location: locationController.text.length == 0
                                                        ? widget.userModel
                                                            .getLocation
                                                        : locationController
                                                            .text,
                                                    gender: genderController.text.length == 0
                                                        ? widget
                                                            .userModel.getGender
                                                        : genderController.text,
                                                    firstName: firstNameController.text.length == 0
                                                        ? widget
                                                            .userModel.firstName
                                                        : firstNameController.text,
                                                    lastName: lastNameController.text.length == 0 ? widget.userModel.lastName : lastNameController.text,
                                                    mobile: mobileController.text.length == 0 ? widget.userModel.getMobile : mobileController.text,
                                                    age: _dateTime == null ? widget.userModel.getAge : _dateTime,
                                                    imagePath:  selectedImage );
                                                print(
                                                    ">>>>>>>>>>>>>>>>>>>>>>>>>    " +
                                                        selectedImage
                                                            .toString());
                                                _userController.updateUser(
                                                    user,
                                                    selectedImage != null
                                                        ? true
                                                        : false);
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Profile(
                                                      user_id: profileId,
                                                    ),
                                                  ),
                                                );
                                              })),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.deepPurple,
                                thickness: 0.8,
                              ),
                              Center(
                                child: Card(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Container(
                                      height: 40,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.white70,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(40),
                                              topRight: Radius.circular(40),
                                              bottomLeft: Radius.circular(40),
                                              bottomRight: Radius.circular(40)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromRGBO(
                                                    233, 177, 236, 1),
                                                spreadRadius: 4,
                                                blurRadius: 8,
                                                offset: Offset(0, 0)),
                                          ]),
                                      child: Center(
                                          child: IconButton(
                                              icon: Text(
                                                "delete account",
                                                style: TextStyle(
                                                    color: Colors.purple,
                                                    fontSize: 14),
                                              ),
                                              onPressed: () {
                                                _userController.deleteUser();
                                                Navigator.pushNamed(
                                                    context, 'Login');
                                              })),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 220,
                              ),
                            ],
                          )),
                    ),
                    //),
                  ],
                ),
              ));

    ;
  }
}
