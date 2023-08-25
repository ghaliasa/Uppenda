import 'package:flutter/material.dart';
import 'package:ppp/Model/UserModel.dart';
import 'package:ppp/main.dart';

class ShareBody extends StatefulWidget {
  UserModel participantsmodel;
  ShareBody({this.participantsmodel});

  @override
  _ShareBodyState createState() => _ShareBodyState();
}

class _ShareBodyState extends State<ShareBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 35,
      child: Row(
        children: [
          if (widget.participantsmodel.getImage == null)
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
          if (widget.participantsmodel.imagePath != null)
            Container(
              height: 30.0,
              width: 30.0,
              color: Colors.transparent,
              child: CircleAvatar(
                backgroundColor: Color.fromRGBO(233, 207, 236, 1),
                backgroundImage: Image.network(
                  MyApp.mainURL +
                      widget.participantsmodel.imagePath
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
              widget.participantsmodel.getFirstName +
                  ' ' +
                  widget.participantsmodel.getLastName,
              style: TextStyle(
                fontSize: 15,
                color: Colors.purple,
                fontFamily: 'Merienda',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
