import 'package:flutter/material.dart';
import 'package:ppp/Model/GroupModel.dart';
import 'package:ppp/Pages/Group.dart';
import 'package:ppp/main.dart';

class BodyGroupButton extends StatefulWidget {
  GroupModel groupmodel;
  BodyGroupButton({this.groupmodel});

  @override
  _BodyGroupButtonState createState() => _BodyGroupButtonState();
}

class _BodyGroupButtonState extends State<BodyGroupButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: 48,
      width: width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 0.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0, right: 2.0),
          child: Container(
            child: Row(
              children: [
                if (widget.groupmodel.getImage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 32.0,
                      width: 32.0,
                      child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(233, 207, 236, 1),
                        backgroundImage: Image.network(
                          MyApp.mainURL +
                              widget.groupmodel.getImage
                                  .toString()
                                  .replaceAll("\\", "/"),
                          headers: {
                            "Authorization":
                                "Bearer " + MyApp.currentUser.getToken
                          },
                        ).image,
                      ),
                    ),
                  ),
                if (widget.groupmodel.getImage == null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 32.0,
                      width: 32.0,
                      child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(233, 207, 236, 1),
                        foregroundColor: Colors.purple,
                        child: Icon(
                          Icons.group,
                          size: 17,
                        ),
                      ),
                    ),
                  ),
                if (widget.groupmodel.getAdmin.id == MyApp.currentUser.id)
                  Row(
                    children: [
                      Container(
                        child: TextButton(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: widget.groupmodel.getName,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.purple,
                                      fontFamily: 'Merienda',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Group1(
                                      group_id: widget.groupmodel.getId,
                                    );
                                  },
                                ),
                              );
                            } //
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 45.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Admin",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Color.fromRGBO(233, 207, 236, 1),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.purple[200],
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(22.0),
                                  topLeft: Radius.circular(22.0),
                                  bottomRight: Radius.circular(22.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (widget.groupmodel.getAdmin.id != MyApp.currentUser.id)
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0, left: 3.0),
                    child: Row(
                      children: [
                        Container(
                          child: TextButton(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: widget.groupmodel.getName,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.purple,
                                      fontFamily: 'Merienda',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Group1(
                                      group_id: widget.groupmodel.getId,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
