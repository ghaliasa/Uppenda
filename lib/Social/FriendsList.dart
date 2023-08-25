import 'package:flutter/material.dart';
import 'package:ppp/Controllers/ChatController.dart';
import 'package:ppp/Model/ChatModel.dart';
import 'package:ppp/Model/UserModel.dart';
import 'package:ppp/Pages/ChatScreen.dart';
import 'package:ppp/Pages/profile.dart';
import 'package:ppp/main.dart';
import 'package:web_socket_channel/io.dart';

class FriendsList extends StatefulWidget {
  UserModel friend;
  FriendsList({this.friend});

  @override
  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 35,
      child: Row(
        children: [
          if (widget.friend.getImage == null)
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
                      widget.friend.imagePath.toString().replaceAll("\\", "/"),
                  headers: {
                    "Authorization": "Bearer " + MyApp.currentUser.getToken
                  },
                ).image,
              ),
            ),
          TextButton(
            child: Text(
              widget.friend.getFirstName + ' ' + widget.friend.getLastName,
              style: TextStyle(
                fontSize: 15,
                color: Colors.purple,
                fontFamily: 'Merienda',
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Profile(
                      user_id: widget.friend.getId,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
