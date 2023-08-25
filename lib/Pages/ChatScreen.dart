import 'dart:async';
import 'dart:convert';

import 'package:ppp/Controllers/MessageController.dart';
import 'package:ppp/Model/ChatModel.dart';
import 'package:ppp/Model/MessageModel.dart';
import 'package:ppp/Components/MessageList.dart';
import 'package:flutter/material.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../main.dart';
import 'MainPage.dart';

//////////////////////Mouayad
class ChatScreen extends StatefulWidget {
  final WebSocketChannel channel;

  ChatModel chatModel;

  ChatScreen({this.chatModel, this.channel});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  MessageController messageController = MessageController();
  TextEditingController messageText = new TextEditingController();
  MessageModel messageModel;
  Future<List<dynamic>> listBack;
  List listFront = new List();
  var curentSnapShot;

  void addMessageTolistFront(dynamic value) {
    print("\n\nlololloloo\n\n");
    setState(() {
      listFront.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    listBack =
        messageController.getAllMessagesByCID(widget.chatModel.id.toString());

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.purple,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => ChatPage()));
          },
        ),
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.chatModel.getTittleGroup != null
                    ? widget.chatModel.getTittleGroup
                    : widget.chatModel.receiver.getFirstName +
                        " " +
                        widget.chatModel.receiver.getLastName,
                style: TextStyle(
                  fontFamily: 'Merienda',
                  color: Colors.purple,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(text: '\n'),
              widget.chatModel.getTittleGroup != null
                  ? TextSpan()
                  : widget.chatModel.receiver.getOnLine
                      ? TextSpan(
                          text: 'Online',
                          style: TextStyle(
                            fontFamily: 'Merienda',
                            color: Colors.purple,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : TextSpan(
                          text: 'Offline',
                          style: TextStyle(
                            fontFamily: 'Merienda',
                            color: Colors.purple,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List>(
              future: listBack,
              builder: (context, snapshot) {
                if (snapshot.data == null) return SizedBox();
                if (snapshot.hasError) print(snapshot.error);
                if (snapshot.hasData) {
                  listFront = snapshot.data;
                  if (listFront.isEmpty)
                    return Center(
                      child: Text(
                        "There are no messages yet...",
                        style: TextStyle(
                            letterSpacing: 1,
                            fontFamily: 'Merienda',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.purple),
                      ),
                    );

                  if (listFront.isNotEmpty)
                    return MessageList(
                      list: listFront,
                    );
                } else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              },
            ),
          ),
          new StreamBuilder(
            stream: widget.channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(">>>>  snap  " + snapshot.hasData.toString());
                messageModel =
                    MessageModel.fromJson(json.decode(snapshot.data));
                if (curentSnapShot != snapshot.data) {
                  curentSnapShot = snapshot.data;
                  Timer(Duration(microseconds: 1), () {
                    addMessageTolistFront(messageModel.toJson());
                  });

                  return Container();
                }
                return Container();
              } else {
                return Container();
              }
            },
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Colors.purple,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Send a message..',
              ),
              controller: messageText,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Colors.purple,
            onPressed: () {
              if (messageText.text.isNotEmpty) {
                print("\n\t   Onpressed   \n");
                MessageModel sendedMessage = MessageModel(
                  content: messageText.text.trim(),
                  s_id: MyApp.currentUser.id.toString(),
                  c_id: widget.chatModel.id,
                );
                print("\t\t\t" + messageText.text);
                sendedMessage.setUnread = true;
                // sendedMessage.setSender = MyApp.currentUser;
                messageText.clear();
                addMessageTolistFront(sendedMessage.toJson());
                widget.channel.sink.add(json.encode(sendedMessage.toJson()));
              }
            },
          ),
        ],
      ),
    );
  }

  // @override
  // void dispose() {
  //   widget.channel.sink.close();
  //   super.dispose();
  // }
}
