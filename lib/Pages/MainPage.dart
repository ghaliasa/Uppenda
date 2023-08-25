import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:ppp/Controllers/ChatController.dart';
import 'package:ppp/Components/ChatList.dart';
import 'package:flutter/material.dart';
import 'package:ppp/Model/ChatModel.dart';
import 'package:ppp/Model/UserModel.dart';
import 'package:ppp/Social/Social_Home.dart';
import 'package:web_socket_channel/io.dart';

import '../main.dart';
import 'ChatScreen.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatController chatController = ChatController();

  bool isSoso = false;

  List<ChatModel> chatsList = [];
  List<ChatModel> tempChatsList = [];
  List<UserModel> listUsers = [];

  @override
  void initState() {
    chatController.getAllChatByUID(MyApp.currentUser.id).then((value) {
      setState(() {
        chatsList = value;
        listUsers = MyApp.currentUser.getFriends;
        if (chatsList.isNotEmpty) {
          for (var i = 0; i < MyApp.currentUser.getFriends.length; i++) {
            for (var j = 0; j < chatsList.length; j++) {
              print("for");
              if (MyApp.currentUser.getFriends[i].getId ==
                  chatsList[j].getReceiver.getId) {
                print("iffffffffffff");
                setState(() {
                  listUsers.remove(MyApp.currentUser.getFriends[i]);
                });
              }
            }
          }
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Chats",
              style: TextStyle(
                  letterSpacing: 4,
                  fontFamily: 'DancingScript',
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.purple),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.purple,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SocialHome()));
              },
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: chatsList.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ChatList(
                  list: chatsList,
                ),
        ),
        Positioned(
          bottom: 30,
          right: 25,
          child: Container(
            width: 60,
            height: 60,
            child: FloatingActionButton(
              heroTag: 3,
              child: Icon(
                Icons.add,
                size: 30,
                color: Color.fromRGBO(233, 207, 236, 1),
              ),
              onPressed: () {
                getButtomSheetFriend();
              },
              backgroundColor: Colors.purple,
            ),
          ),
        ),
      ],
    );
  }

  getButtomSheetFriend() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoActionSheet(
          title: listUsers.length == 0
              ? Text(
                  "No friends yet",
                  style: TextStyle(
                    letterSpacing: 3,
                    color: Colors.purple,
                    fontSize: 30,
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.w600,
                  ),
                )
              : Text(
                  "friends",
                  style: TextStyle(
                    letterSpacing: 2,
                    color: Colors.purple,
                    fontSize: 30,
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.w600,
                  ),
                ),
          actions: List.generate(
            listUsers.length,
            (index) {
              return CupertinoActionSheetAction(
                child: Container(
                  color: Colors.transparent,
                  height: 35,
                  child: Row(
                    children: [
                      if (listUsers[index].getImage == null)
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
                      if (listUsers[index].imagePath != null)
                        Container(
                          height: 30.0,
                          width: 30.0,
                          color: Colors.transparent,
                          child: CircleAvatar(
                            backgroundColor: Color.fromRGBO(233, 207, 236, 1),
                            backgroundImage: Image.network(
                              MyApp.mainURL +
                                  listUsers[index]
                                      .imagePath
                                      .toString()
                                      .replaceAll("\\", "/"),
                              headers: {
                                "Authorization":
                                    "Bearer " + MyApp.currentUser.getToken
                              },
                            ).image,
                          ),
                        ),
                      TextButton(
                        child: Text(
                          listUsers[index].getFirstName +
                              ' ' +
                              listUsers[index].getLastName,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.purple,
                            fontFamily: 'Merienda',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          List<UserModel> list = [];
                          list.add(MyApp.currentUser);
                          list.add(listUsers[index]);
                          ChatModel chatModel = ChatModel();
                          chatModel.setReceiver = listUsers[index];
                          chatModel.messages = [];
                          chatModel.setUsers = list;

                          chatController.addChat(chatModel).then((value) {
                            setState(() {
                              chatModel = value;
                            });
                          });

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatScreen(
                                chatModel: chatModel,
                                channel: new IOWebSocketChannel.connect(
                                  "ws://" + MyApp.ip + "/chat",
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                onPressed: () {},
              );
            },
          ),
        ),
      ),
    );
  }
}
