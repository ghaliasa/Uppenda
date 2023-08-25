import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget {
  double width, height;

  @override
  Widget build(BuildContext context) {
    width = height = 110;
    return Positioned(
      top: 80,
      left: MediaQuery.of(context).size.width / 2 - (height / 2),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)]),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Uppenda',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }
}
