import 'package:ppp/Model/ChatModel.dart';
import 'package:ppp/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatController {
  String currentUri = MyApp.mainURL + "/chat";
  ChatModel chatModel;
  List data;

  Future<ChatModel> addChat(ChatModel chatModel) async {
    final body = json.encode(chatModel.toJson());
    final response =
        await http.post(Uri.parse(currentUri + "/add"), body: body, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + MyApp.currentUser.getToken
    });

    if (response.body != null) {
      this.chatModel = ChatModel.fromJson(json.decode(response.body));
    }

    return chatModel;
  }

  Future<List<ChatModel>> getAllChatByUID(String id) async {
    int a = int.parse(id);
    final response = await http.get(
      Uri.parse(MyApp.mainURL + '/chat/getAllChatByUserID/user_id=$a'),
      headers: {"Authorization": "Bearer " + MyApp.currentUser.getToken},
    );
    List<dynamic> k = json.decode(response.body);
    List<ChatModel> list = List();
    if (k.isNotEmpty) {
      for (int i = 0; i < k.length; i++) {
        print("ccccccccccccccccccccccccccccccccccccccccccccccc");
        list.add(ChatModel.fromJson(k[i]));
      }
    }
    return list;
  }
}
