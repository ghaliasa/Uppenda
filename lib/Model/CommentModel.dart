import 'dart:core';
import 'package:ppp/Model/UserModel.dart';
import 'package:ppp/main.dart';

import 'PostModel.dart';

class CommentModel {
  String id;
  String content;
  String imagePath;
  String createdAt;
  UserModel userModel;
  PostModel postModel;

  CommentModel({
    this.id,
    this.userModel,
    this.postModel,
    this.imagePath,
    this.content,
    this.createdAt,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    this.id = json["id"].toString();
    this.content = json["content"];
    this.createdAt = json["createdAt"];
    if (json["imagePath"] != null) this.imagePath = json["imagePath"];
    if (json["postModel"] != null)
      this.postModel = PostModel.fromJson(json["postModel"]);
    if (json["userModel"] != null)
      this.userModel = UserModel.fromJson(json["userModel"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    if (this.imagePath != null) data['imagePath'] = this.imagePath;
    if (this.postModel != null) data['postModel'] = this.postModel.toJson();
    if (this.userModel != null) data['userModel'] = this.userModel.toJson();
    return data;
  }

  get getId => this.id;

  set setId(id) => this.id = id;

  get getUserModel => this.userModel;

  set setUserModel(userModel) => this.userModel = userModel;

  get getPostModel => this.postModel;

  set setPostModel(postModel) => this.postModel = postModel;

  get getContent => this.content;

  set setContent(content) => this.content = content;

  get getImage => this.imagePath;

  set setImage(imagePath) => this.imagePath = imagePath;

  get getCreatedAt => this.createdAt;

  set setCreatedAt(createdAt) => this.createdAt = createdAt;

  static List<CommentModel> comments = [
    new CommentModel(
      id: "1",
      userModel: MyApp.currentUser,
      imagePath: 'images/photo1.jpg',
      content:
          " My name is ghalia sabbagh , I have one sisterhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh and three brothers , I live in Damascus , I am studying IT",
      createdAt: "1/1/2001",
    ),
    new CommentModel(
      id: "2",
      userModel: UserModel.users[4],
      imagePath: null,
      content:
          "Sunday\nMonday\nTuesday\nWednesday\nThursday\nFridady\nSaturday",
      createdAt: "1/1/2001",
    ),
    new CommentModel(
        id: "3",
        userModel: MyApp.currentUser,
        imagePath: null,
        content: "can i help you \n can i help you \n can i help you \n ",
        createdAt: "1/1/2001"),
    new CommentModel(
      id: "4",
      userModel: MyApp.currentUser,
      imagePath: 'images/photo1.jpg',
      content: null,
      createdAt: "1/1/2001",
    ),
    new CommentModel(
      id: "5",
      userModel: UserModel.users[2],
      imagePath: 'images/photo1.jpg',
      content: "lloly",
      createdAt: "1/1/2001",
    ),
    new CommentModel(
      id: "6",
      userModel: UserModel.users[3],
      imagePath: null,
      content:
          "Listen to the audio without reading the text. Just listen and try to hear how much you can understand.\n\n Do you recognise any words or phrases? Can you understand what they are talking about?",
      createdAt: "1/1/2001",
    ),
  ];
}
