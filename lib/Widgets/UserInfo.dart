import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppp/Model/UserModel.dart';

import '../main.dart';

class UserInfo extends StatelessWidget {
  UserModel userModel;
  UserInfo({this.userModel});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              child: CircleAvatar(
                backgroundImage: userModel.getImage == null
                    ? AssetImage("images/download.jpg")
                    : Image.network(
                        MyApp.mainURL +
                            userModel.getImage.toString().replaceAll("\\", "/"),
                        headers: {
                          "Authorization":
                              "Bearer " + MyApp.currentUser.getToken
                        },
                      ).image,
                backgroundColor: Colors.purple[100],
                // minRadius: 50,
                maxRadius: 20,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.purple[600],
                  width: 2,
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              userModel.getFirstName + " " + userModel.getLastName,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.purple,
                fontSize: 13,
                fontFamily: 'Merienda',
              ),
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.purple,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
