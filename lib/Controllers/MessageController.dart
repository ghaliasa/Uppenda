import 'package:ppp/Model/MessageModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class MessageController {
  MessageModel messageModel;
  List data;
  /////////////////////////////////////////
  Future<List> getAllMessagesByCID(String id) async {
    int a = int.parse(id);
    final response = await http.get(
      Uri.parse(MyApp.mainURL + '/message/getAllMessageFromChat/chat_id=$a'),
      headers: {"Authorization": "Bearer " + MyApp.currentUser.getToken},
    );
    // print("\n===>  getAllMessagesByCID : \n\t\t\t" + response.body);
    List k = json.decode(response.body);
    return k;
  }

  //////////////////////////////////////////
  Future<MessageModel> getLAstMessageByChatId(String chatId) async {
    int cId = int.parse(chatId);
    final response = await http.get(
      Uri.parse(MyApp.mainURL + '/message/getLastMessage/chatId=$cId'),
      headers: {"Authorization": "Bearer " + MyApp.currentUser.getToken},
    );
    // print("\n===>  getLAstMessageByChatId \n");
    return json.decode(response.body);
  }
}
