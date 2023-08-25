import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ppp/Model/LikeModel.dart';
import 'package:ppp/Pages/profile.dart';

import '../main.dart';

class LikeBody extends StatefulWidget {
  LikeModel likemodel;
  LikeBody({this.likemodel});
  @override
  LikeBodyState createState() => LikeBodyState();
}

class LikeBodyState extends State<LikeBody> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.transparent,
      height: 35,
      child: Row(
        children: [
          if (widget.likemodel.userModel.getImage == null)
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
          if (widget.likemodel.userModel.imagePath != null)
            Container(
              height: 30.0,
              width: 30.0,
              color: Colors.transparent,
              child: CircleAvatar(
                backgroundColor: Color.fromRGBO(233, 207, 236, 1),
                backgroundImage: Image.network(
                  MyApp.mainURL +
                      widget.likemodel.userModel.imagePath
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
              widget.likemodel.userModel.getFirstName +
                  ' ' +
                  widget.likemodel.userModel.getLastName,
              style: TextStyle(
                fontSize: 15,
                color: Colors.purple,
                fontFamily: 'Merienda',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Icon(
            MdiIcons.heart,
            color: Color(int.parse(widget.likemodel.reactionModel.colorName)),
          )
        ],
      ),
    );
  }
}
