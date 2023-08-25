import 'package:flutter/material.dart';
import 'package:ppp/Model/GroupModel.dart';
import 'package:ppp/Model/UserModel.dart';
import 'package:ppp/Social/CreateGroup.dart';

import '../main.dart';

class UserFriend extends StatefulWidget {
  UserModel friend;
  static List<UserModel> listUsers = [];
  UserFriend({this.friend});
  @override
  UserFriendState createState() => UserFriendState();
}

class UserFriendState extends State<UserFriend> {
  bool press = false;
  _pressed() {
    setState(
      () {
        press = !press;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    UserFriend.listUsers = new List();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.transparent,
      height: 35,
      child: Padding(
        padding: const EdgeInsets.only(left: 7),
        child: Row(
          children: [
            if (widget.friend.imagePath == null)
              Container(
                height: 30.0,
                width: 30.0,
                color: Colors.transparent,
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(233, 207, 236, 1),
                  foregroundColor: Colors.purple,
                  child: Icon(Icons.person),
                ),
              ),
            if (widget.friend.imagePath != null)
              Container(
                height: 30.0,
                width: 30.0,
                color: Colors.transparent,
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(233, 207, 236, 1),
                  backgroundImage: Image.network(
                    MyApp.mainURL +
                        widget.friend.imagePath
                            .toString()
                            .replaceAll("\\", "/"),
                    headers: {
                      "Authorization": "Bearer " + MyApp.currentUser.getToken
                    },
                  ).image,
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 4.0),
              child: Text(
                widget.friend.firstName + ' ' + widget.friend.lastName,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.purple,
                  fontFamily: 'Merienda',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            press
                ? TextButton(
                    child: Text("remove"),
                    style: TextButton.styleFrom(primary: Colors.red[300]),
                    onPressed: () {
                      _pressed();
                      UserFriend.listUsers.remove(widget.friend);
                    },
                  )
                : TextButton(
                    child: Text("add"),
                    style: TextButton.styleFrom(primary: Colors.blue[500]),
                    onPressed: () {
                      _pressed();
                      UserFriend.listUsers.add(widget.friend);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
