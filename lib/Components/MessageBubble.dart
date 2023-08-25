import 'package:ppp/Model/MessageModel.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class MessageBubble extends StatelessWidget {
  MessageModel message;
  bool isMe;
  bool isSameUser;
  MessageBubble({this.message, this.isMe, this.isSameUser});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: isMe ? Alignment.topRight : Alignment.topLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.80,
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isMe ? Colors.purple : Colors.white,
              borderRadius: isMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )
                  : BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Text(
              message.content,
              style: TextStyle(color: isMe ? Colors.white : Colors.purple),
            ),
          ),
        ),
        !isSameUser
            ? Row(
                mainAxisAlignment:
                    isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: <Widget>[
                  isMe
                      ? Text(
                          message.dateOfSent.substring(11, 16),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black45,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage: Image.network(
                              MyApp.mainURL +
                                  message.sender.getImage
                                      .toString()
                                      .replaceAll("\\", "/"),
                              headers: {
                                "Authorization":
                                    "Bearer " + MyApp.currentUser.getToken
                              },
                            ).image,
                          ),
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  isMe
                      ? Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage: Image.network(
                              MyApp.mainURL +
                                  message.sender.getImage
                                      .toString()
                                      .replaceAll("\\", "/"),
                              headers: {
                                "Authorization":
                                    "Bearer " + MyApp.currentUser.getToken
                              },
                            ).image,
                          ),
                        )
                      : Text(
                          message.dateOfSent.substring(11, 16),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black45,
                          ),
                        )
                ],
              )
            : Container(
                child: null,
              ),
      ],
    );
  }
}
