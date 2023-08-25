import 'package:ppp/Model/ChatModel.dart';
import 'package:flutter/material.dart';

import 'ChatBlocke.dart';

class ChatList extends StatelessWidget {
  final List list;
  ChatList({this.list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return ChatBlocke(chatModel: list[i]);
      },
    );
  }
}
