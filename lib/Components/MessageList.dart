import 'package:ppp/Model/MessageModel.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'MessageBubble.dart';

class MessageList extends StatelessWidget {
  final List list;

  MessageList({this.list});
  @override
  Widget build(BuildContext context) {
    int prevUserId;
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            reverse: true,
            padding: EdgeInsets.all(20),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              // print("\n\n_________________________\n\n");
              // print(list);
              // print("\n\n_________________________\n\n");
              // print("\n\n\n    >>>>>>>>>>>>>>>>>>>>    \n" +
              //     list[index].toString());
              final MessageModel message = MessageModel.fromJson(list[index]);
              // print("\n________________________\n");
              // print("\n" + message.content);
              final bool isMe = message.s_id == MyApp.currentUser.id;
              final bool isSameUser = prevUserId == message.s_id;
              prevUserId = int.parse(message.s_id.toString());
              return MessageBubble(
                message: message,
                isMe: isMe,
                isSameUser: isSameUser,
              );
            },
          ),
        ),
      ],
    );
  }
}
