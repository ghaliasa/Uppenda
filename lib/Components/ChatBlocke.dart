import 'package:ppp/Model/ChatModel.dart';
import 'package:ppp/Pages/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import '../main.dart';

class ChatBlocke extends StatelessWidget {
  ChatModel chatModel;

  ChatBlocke({this.chatModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // chatModel.unread = false;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(
              chatModel: chatModel,
              channel:
                  new IOWebSocketChannel.connect("ws://" + MyApp.ip + "/chat"),
            ),
          ),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(233, 207, 236, 1),
                    spreadRadius: 4,
                    blurRadius: 7,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              width: double.infinity,
              height: 110,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: chatModel.getUnread //// unred set from frontEnd
                        ? BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            border: Border.all(
                              width: 2,
                              color: Theme.of(context).primaryColor,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          )
                        : BoxDecoration(
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
                      radius: 30,
                      backgroundImage: chatModel.tittleGroup == null
                          ? Image.network(
                              MyApp.mainURL +
                                  chatModel.receiver.getImage
                                      .toString()
                                      .replaceAll("\\", "/"),
                              headers: {
                                "Authorization":
                                    "Bearer " + MyApp.currentUser.getToken
                              },
                            ).image
                          : Image.network(
                              MyApp.mainURL +
                                  chatModel.imageGroup
                                      .toString()
                                      .replaceAll("\\", "/"),
                              headers: {
                                "Authorization":
                                    "Bearer " + MyApp.currentUser.getToken
                              },
                            ).image,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    padding: EdgeInsets.only(left: 20, top: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  chatModel.tittleGroup != null
                                      ? chatModel.tittleGroup
                                      : chatModel.receiver.getFirstName +
                                          " " +
                                          chatModel.receiver.getLastName,
                                  style: TextStyle(
                                    fontFamily: 'Merienda',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                chatModel.tittleGroup == null
                                    ? chatModel.receiver.getOnLine
                                        ? Container(
                                            margin:
                                                const EdgeInsets.only(left: 5),
                                            width: 7,
                                            height: 7,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          )
                                        : Container()
                                    : Container()
                              ],
                            ),
                            Text(
                              chatModel.lastMessage.dateOfSent,
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w300,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            chatModel.tittleGroup != null
                                ? chatModel.lastMessage.sender == null
                                    ? " " + chatModel.lastMessage.getContent
                                    : chatModel
                                            .lastMessage.sender.getFirstName +
                                        " : " +
                                        chatModel.lastMessage.getContent
                                : chatModel.lastMessage.getContent,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 3,
          )
        ],
      ),
    );
  }
}
