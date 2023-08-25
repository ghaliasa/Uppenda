import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppp/Widgets/BottomBar.dart';
import 'package:ppp/Widgets/TopBar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      bottomNavigationBar: BottomBar(),
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
