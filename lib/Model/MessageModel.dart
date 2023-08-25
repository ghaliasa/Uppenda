import 'ChatModel.dart';
import 'UserModel.dart';

class MessageModel {
  String id;
  String content;
  String dateOfSent;
  String s_id;
  String c_id;
  bool unread;
  ChatModel chatModel;
  UserModel sender;

  MessageModel({
    this.id,
    this.content,
    this.dateOfSent,
    this.chatModel,
    this.sender,
    this.s_id,
    this.c_id,
    this.unread,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    this.id = json["id"].toString();
    this.content = json["content"];
    this.dateOfSent = json["dateOfSent"].toString();
    this.s_id = json["s_id"].toString();
    this.c_id = json["c_id"].toString();
    if (json["chatModel"] != null)
      this.chatModel = ChatModel.fromJson(json["chatModel"]);
    if (json["sender"] != null)
      this.sender = UserModel.fromJson(json["sender"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['dateOfSent'] = this.dateOfSent;
    data['s_id'] = this.s_id;
    data['c_id'] = this.c_id;
    if (this.chatModel != null) data['chatModel'] = this.chatModel.toJson();
    if (this.sender != null) data['sender'] = this.sender.toJson();
    return data;
  }

  get getId => this.id;

  set setId(String id) => this.id = id;

  get getContent => this.content;

  set setContent(content) => this.content = content;

  get getDateOfSent => this.dateOfSent;

  set setDateOfSent(dateOfSent) => this.dateOfSent = dateOfSent;

  get getChatModel => this.chatModel;

  set setChatModel(chatModel) => this.chatModel = chatModel;

  get getSender => this.sender;

  set setSender(sender) => this.sender = sender;

  get sid => this.s_id;

  set sid(value) => this.s_id = value;

  get cid => this.c_id;

  set cid(value) => this.c_id = value;

  get getUnread => this.unread;

  set setUnread(unread) => this.unread = unread;
}
