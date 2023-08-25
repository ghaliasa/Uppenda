import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget implements PreferredSizeWidget {
  BottomBar({Key key}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar>{

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 55.0,
      child: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 2.0, 0.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "Profile");
                },
                icon: Icon(
                  Icons.account_box,
                  size: 30,
                  color: Colors.purple,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 2.0, 0.0),
              child: IconButton(
                icon: Icon(Icons.supervised_user_circle,
                    color: Colors.purple, size: 30),
                onPressed: () {
                  Navigator.pushNamed(context, "Group");
                },
              ),
            ),
            FloatingActionButton(
                child: Icon(Icons.add_circle_sharp,
                    size: 40,
                    color: Color.fromRGBO(233, 207, 236, 1)),
                onPressed: () {
                },
                backgroundColor: Colors.purple),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 0.0),
              child: IconButton(
                icon: Icon(
                  Icons.description,
                  color: Colors.purple,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "Page");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 3.0, 0.0),
              child: IconButton(
                icon:
                Icon(Icons.home, color: Colors.purple, size: 30),
                onPressed: () {
                  Navigator.pushNamed(context, "Home");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}