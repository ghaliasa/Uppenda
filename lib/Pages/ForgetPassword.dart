import 'package:flutter/material.dart';
import 'package:ppp/Model/QuestionModel.dart';
import '../Widgets/Header.dart';
import '../Widgets/Logo.dart';
import '../Widgets/TextFieldCustom.dart';

class ForgetPasswordPage extends StatelessWidget {
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
            SizedBox(height: 30),
            Check(),
            SizedBox(height: 10),
            ButtonOk()
          ]),
    );
  }
}

class Check extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          TextFieldCustom(
              icono: Icons.person,
              type: TextInputType.text,
              texto: 'Please Enter Your Firstname '),
          SizedBox(height: 20),
          TextFieldCustom(
              icono: Icons.person,
              type: TextInputType.text,
              texto: 'Please Enter Your Lastname'),
          SizedBox(height: 20),
          TextFieldCustom(
              icono: Icons.phone,
              type: TextInputType.text,
              texto: 'Please Enter Your Number'),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ButtonOk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Colors.purple, borderRadius: BorderRadius.circular(50)),
      child: FlatButton(
          onPressed: () => Navigator.pushNamed(context, 'Login'),
          child: Text(
            'OK',
            style: TextStyle(color: Colors.white, fontSize: 18),
          )),
    );
  }
}
