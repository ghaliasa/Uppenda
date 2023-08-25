import 'package:flutter/material.dart';
import 'package:ppp/Model/AuthRequest.dart';
import 'package:ppp/Model/UserModel.dart';
import 'package:ppp/Pages/Signup.dart';
import 'package:ppp/Social/Social_Home.dart';
import 'package:ppp/controllers/UserController.dart';
import 'package:ppp/main.dart';

import '../Widgets/Header.dart';
import '../Widgets/Logo.dart';
import '../Widgets/TextFieldCustom.dart';

class LogInPage extends StatelessWidget {
  UserController _userController = new UserController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.only(top: 0),
      physics: BouncingScrollPhysics(),
      children: [
        Stack(
          children: [HeaderLogin(), LogoHeader()],
        ),
        Title(),
        SizedBox(height: 20),
        // EmailAndPassword()
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              TextFieldCustom(
                icono: Icons.mail_outline,
                type: TextInputType.emailAddress,
                texto: 'Email',
                controller: emailController,
              ),
              SizedBox(height: 20),
              TextFieldCustom(
                icono: Icons.visibility_off,
                type: TextInputType.text,
                pass: true,
                texto: 'Password',
                controller: passwordController,
              ),
            ],
          ),
        ),

        ForgetPassword(),

        SizedBox(height: 10),

        // ButtonSignIn()
        Container(
          margin: EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: Colors.purple, borderRadius: BorderRadius.circular(50)),
          child: FlatButton(
              onPressed: () {
                if (emailController.text.length == 0 ||
                    passwordController.text.length == 0)
                  showAlertDialog(context, "complete all field please");
                AuthRequest authRequest = new AuthRequest(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim());
                if (emailController.text.length != 0 &&
                    passwordController.text.length != 0) {
                  _userController.signIn(authRequest).then((value) {
                    print('>>>>>>>>>>>>   ' + value['userModel'].toString());
                    if (value['userModel'] == null) {
                      showAlertDialog(context, "invalid email or password");
                    } else {
                      MyApp.currentUser =
                          UserModel.fromJson(value['userModel']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SocialHome(),
                        ),
                      );
                    }
                  });
                }
                // Navigator.pushNamed(context  , '');
                // if(== null)
                //   showAlertDialog(context);
              },
              child: Text(
                'SIGN IN',
                style: TextStyle(
                    fontFamily: 'Merienda', color: Colors.white, fontSize: 18),
              )),
        )
      ],
    ));
  }
}

void showAlertDialog(BuildContext context, String message) {
  // Widget cancelButton = TextButton(
  //   child: Text(
  //     "OK",
  //     style: TextStyle(color: Colors.purple),
  //   ),
  //   onPressed: () {
  //     Navigator.pop(context);
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
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            '/',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Merienda',
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ForgetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 25, top: 20),
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => Navigator.pushNamed(context, 'ForgetPassword'),
        child: Text(
          'Forget Password?',
          style: TextStyle(
            fontFamily: 'Merienda',
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
