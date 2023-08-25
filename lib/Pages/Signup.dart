import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:image_picker/image_picker.dart';
import 'package:ppp/Model/UserModel.dart';
import 'package:ppp/Pages/Login.dart';
import 'package:ppp/Social/Social_Home.dart';
import 'package:ppp/controllers/UserController.dart';
import 'package:ppp/main.dart';
import '../Widgets/Header.dart';
import '../Widgets/Logo.dart';
import '../Widgets/TextFieldCustom.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool male = false;
  bool female = false;
  UserController _userController = new UserController();
  UserModel _userModel;
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController configPasswordController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController studyLevelController = new TextEditingController();
  File _image = null;
  DateTime _dateTime = null;
  String userIp = "";
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    NetworkInterface.list().then((value) {
      setState(() {
        userIp = "/" + value.first.addresses.first.address;
      });
    });
  }

  Future getImagefromCamera() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, maxHeight: 480, maxWidth: 640);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
      print(' ////////////////////' + _image.path);
    });
  }

  Future getImagefromGallery() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 480, maxWidth: 640);

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
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.only(top: 0),
      physics: BouncingScrollPhysics(),
      children: [
        Stack(
          children: [HeaderSignUp(), LogoHeader()],
        ),
        Title(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Container(
                child: CircleAvatar(
                  backgroundImage: _image == null
                      ? AssetImage("images/profile.png")
                      : FileImage(_image),
                  backgroundColor: Colors.purple[100],
                  // minRadius: 50,
                  maxRadius: 80,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.purple[600],
                    width: 4,
                  ),
                ),
              ),
              Divider(
                height: 20,
                color: Colors.purple,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                    onPressed: getImagefromGallery,
                    child: Icon(Icons.wallpaper, size: 35, color: Colors.grey),
                  ),
                  FlatButton(
                    onPressed: getImagefromCamera,
                    child: Icon(Icons.camera_alt, size: 35, color: Colors.grey),
                  )
                ],
              ),
              Divider(
                height: 20,
                color: Colors.purple,
              ),
              TextFieldCustom(
                icono: Icons.person,
                type: TextInputType.text,
                texto: 'Fist name',
                controller: firstNameController,
              ),
              SizedBox(height: 20),
              TextFieldCustom(
                icono: Icons.person,
                type: TextInputType.text,
                texto: 'Last name',
                controller: lastNameController,
              ),
              SizedBox(height: 20),
              TextFieldCustom(
                icono: Icons.mail_outline,
                type: TextInputType.emailAddress,
                texto: 'Email',
                controller: emailController,
              ),
              SizedBox(height: 20),
              TextFieldCustom(
                icono: Icons.phone,
                type: TextInputType.text,
                texto: 'Mobile',
                controller: mobileController,
              ),
              SizedBox(height: 20),
              TextFieldCustom(
                icono: Icons.location_on,
                type: TextInputType.text,
                pass: false,
                texto: 'Location',
                controller: locationController,
              ),
              SizedBox(height: 20),
              TextFieldCustom(
                icono: Icons.school,
                type: TextInputType.text,
                pass: false,
                texto: 'Study level',
                controller: studyLevelController,
              ),
              SizedBox(height: 20),
              TextFieldCustom(
                icono: Icons.visibility_off,
                type: TextInputType.text,
                pass: true,
                texto: 'Password',
                controller: passwordController,
              ),
              SizedBox(height: 20),
              TextFieldCustom(
                icono: Icons.visibility_off,
                type: TextInputType.text,
                pass: true,
                texto: 'Confirm Password',
                controller: configPasswordController,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        Divider(
          height: 20,
          color: Colors.purple,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              (_dateTime == null)
                  ? "no selected date"
                  : "selected date :             " +
                      _dateTime.year.toString() +
                      "/" +
                      _dateTime.month.toString() +
                      "/" +
                      _dateTime.day.toString(),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            FlatButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(1990, 1, 1),
                      maxTime: DateTime.now(), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    setState(() {
                      print('confirm $date');
                      _dateTime = date;
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Icon(Icons.date_range, size: 35, color: Colors.grey)),
          ],
        ),
        Divider(
          height: 20,
          color: Colors.purple,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('male',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
            Checkbox(
              value: male,
              onChanged: (bool value) {
                setState(() {
                  this.male = value;
                  this.female = !value;
                });
              },
            ),
            SizedBox(
              width: 70,
            ),
            Checkbox(
              value: female,
              onChanged: (bool value) {
                setState(() {
                  this.female = value;
                  this.male = !value;
                });
              },
            ),
            Text('female',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
          ],
        ),
        Divider(
          height: 20,
          color: Colors.purple,
        ),
        Container(
          margin: EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: Colors.purple, borderRadius: BorderRadius.circular(50)),
          child: FlatButton(
              onPressed: () {
                _userModel = new UserModel(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    email: emailController.text,
                    mobile: mobileController.text,
                    password: passwordController.text,
                    age: _dateTime,
                    createdAt: null,
                    ip: userIp,
                    gender:
                        (male == true && female == false) ? "male" : "female",
                    friends: null,
                    answerModels: null,
                    chats: null,
                    groups: null,
                    location: locationController.text,
                    messages: null,
                    pages: null,
                    onLine: true,
                    postModels: null,
                    savedPost: null,
                    sharedPost: null,
                    studyLevel: studyLevelController.text,
                    imagePath: _image == null ? null : _image.path);
                if (firstNameController.text.length != 0 &&
                    lastNameController.text.length != 0 &&
                    emailController.text.length != 0 &&
                    mobileController.text.length != 0 &&
                    locationController.text.length != 0 &&
                    studyLevelController.text.length != 0)
                // showAlertDialog(context, "complete all fields pleas");
                {
                  if (passwordController.text != configPasswordController.text)
                    showAlertDialog(context, "password doesnot match");
                  if (passwordController.text ==
                      configPasswordController.text) {
                    _userController.addUser(_userModel).then((value) {
                      if (value['userModel'] != null) {
                        print("  in singup");
                        setState(() {
                          MyApp.currentUser =
                              UserModel.fromJson(value["userModel"]);
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SocialHome(),
                          ),
                        );
                      }
                      // else
                      //   showAlertDialog(context, "there is no contection");
                    });
                  }
                } else
                  showAlertDialog(context, "complete all fields pleas");
              },
              child: Text(
                'SIGN UP',
                style: TextStyle(
                  fontFamily: 'Merienda',
                  color: Colors.white,
                  fontSize: 18,
                ),
              )),
        ),
      ],
    ));
  }
}

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: [
          FlatButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LogInPage(),
              ),
            ),
            child: Text(
              'SIGN IN',
              style: TextStyle(
                fontFamily: 'Merienda',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Text(
            '/',
            style: TextStyle(
              fontFamily: 'Merienda',
              fontSize: 25,
              color: Colors.grey,
            ),
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SignUp(),
              ),
            ),
            child: Text(
              'SIGN UP',
              style: TextStyle(
                fontFamily: 'Merienda',
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showAlertDialog(BuildContext context, String message) {
  // Widget cancelButton = TextButton(
  //   child: Text(
  //     "OK",
  //     style: TextStyle(color: Colors.purple),
  //   ),
  //   onPressed: () {
  //     // Navigator.pop(context);
  //   },
  // );
  AlertDialog alert = AlertDialog(
    content: Text(
      message,
      style: TextStyle(
        color: Colors.purple,
      ),
    ),
    // actions: [
    //   cancelButton,
    // ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
