import 'MessageModel.dart';
import 'UserModel.dart';

class ChatModel {
  String id;
  String tittleGroup;
  String imageGroup;
  MessageModel lastMessage;
  UserModel receiver;
  List<UserModel> users;
  List<MessageModel> messages;

  bool unread = true;

  ChatModel(
      {this.id,
      this.receiver,
      this.imageGroup,
      this.tittleGroup,
      this.users,
      this.messages,
      this.lastMessage,
      this.unread});

  ChatModel.fromJson(Map<String, dynamic> json) {
    this.id = json["id"].toString();
    this.tittleGroup = json["tittleGroup"];
    if (this.imageGroup != null) this.imageGroup = json["imageGroup"];
    if (json["lastMessage"] != null)
      this.lastMessage = MessageModel.fromJson(json["lastMessage"]);
    if (json["receiver"] != null)
      this.receiver = UserModel.fromJson(json["receiver"]);
    if (json['users'] != null) {
      this.users = new List<UserModel>();
      json['users'].forEach((v) {
        this.users.add(new UserModel.fromJson(v));
      });
    }
    if (json['messages'] != null) {
      this.messages = new List<MessageModel>();
      json['messages'].forEach((v) {
        this.messages.add(new MessageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["tittleGroup"] = this.tittleGroup;
    if (this.imageGroup != null) data["imageGroup"] = this.imageGroup;
    if (this.lastMessage != null)
      data['lastMessage'] = this.lastMessage.toJson();
    if (this.receiver != null) data['receiver'] = this.receiver.toJson();
    if (this.users != null) {
      data['users'] = this.users.map((v) => v.toJson()).toList();
    }
    if (this.messages != null) {
      data['messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    return data;
  }

  get getId => this.id;

  set setId(id) => this.id = id;

  get getTittleGroup => this.tittleGroup;

  set setTittleGroup(tittleGroup) => this.tittleGroup = tittleGroup;

  get getImageGroup => this.imageGroup;

  set setImageGroup(imageGroup) => this.imageGroup = imageGroup;

  get getLastMessage => this.lastMessage;

  set setLastMessage(lastMessage) => this.lastMessage = lastMessage;

  get getReceiver => this.receiver;

  set setReceiver(receiver) => this.receiver = receiver;

  get getUnread => this.unread;

  set setUnread(unread) => this.unread = unread;

  get getUsers => this.users;

  set setUsers(users) => this.users = users;

  get getMessages => this.messages;

  set setMessages(messages) => this.messages = messages;
}
