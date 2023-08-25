import 'dart:core';
import 'package:ppp/Model/ReactionModel.dart';
import 'package:ppp/Model/UserModel.dart';
import 'package:ppp/main.dart';

import 'PostModel.dart';

class LikeModel {

  String id;
  PostModel postModel;
  UserModel userModel;
  ReactionModel reactionModel;

  LikeModel({this.id,this.postModel, this.userModel, this.reactionModel});

  LikeModel.fromJson(Map<String, dynamic> json){
    this.id     = json["id"].toString();
    if (json["postModel"] != null)
      this.postModel = PostModel.fromJson(json["postModel"]);
    if (json["userModel"] != null)
      this.userModel = UserModel.fromJson(json["userModel"]);
    if (json["reactionModel"] != null)
      this.reactionModel = ReactionModel.fromJson(json["reactionModel"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.postModel != null) data['postModel'] = this.postModel.toJson();
    if (this.userModel != null) data['userModel'] = this.userModel.toJson();
    if (this.reactionModel != null) data['reactionModel'] = this.reactionModel.toJson();
    return data;
  }


  get getId => this.id;

  set setId(String id) => this.id = id;

  get getPostModel => this.postModel;

  set setPostModel(postModel) => this.postModel = postModel;

  get getUserModel => this.userModel;

  set setUserModel(userModel) => this.userModel = userModel;

  get getReaction => this.reactionModel;

  set setReaction(reactionModel) => this.reactionModel = reactionModel;

  static List<LikeModel> likes = [
    LikeModel(
      id: "1",
      userModel: UserModel.users[0],
      reactionModel:
          ReactionModel(id: "1", reactionType: "Love", colorName: "0xFFFB71C1C"),
    ),
    LikeModel(
      id: "2",
      userModel: UserModel.users[1],
      reactionModel:
          ReactionModel(id: "5", reactionType: "Fun", colorName: "0xFFF06292"),
    ),
    LikeModel(
      id: "3",
      userModel: UserModel.users[2],
      reactionModel:
          ReactionModel(id: "3", reactionType: "Sad", colorName: "0xFFF9A825"),
    ),
    LikeModel(
      id: "4",
      userModel: MyApp.currentUser,
      reactionModel:
          ReactionModel(id: "1", reactionType: "Love", colorName: "0xFFFB71C1C"),
    ),
    LikeModel(
      id: "5",
      userModel: UserModel.users[4],
      reactionModel:
          ReactionModel(id: "2", reactionType: "Angry", colorName: "0xFF000000"),
    ),
    LikeModel(
      id: "6",
      userModel: UserModel.users[5],
      reactionModel:
          ReactionModel(id: "4", reactionType: "Like", colorName: "0xFF9C27B0"),
    ),
    LikeModel(
      id: "7",
      userModel: UserModel.users[6],
      reactionModel:
          ReactionModel(id: "2", reactionType: "Angry", colorName: "0xFF000000"),
    ),
    LikeModel(
      id: "8",
      userModel: UserModel.users[7],
      reactionModel:
          ReactionModel(id: "3", reactionType: "Sad", colorName: "0xFFF9A825"),
    ),
    LikeModel(
      id: "9",
      userModel: UserModel.users[8],
      reactionModel:
          ReactionModel(id: "1", reactionType: "Love", colorName: "0xFFFB71C1C"),
    ),
    LikeModel(
      id: "10",
      userModel: UserModel.users[9],
      reactionModel:
          ReactionModel(id: "5", reactionType: "Fun", colorName: "0xFFF06292"),
    ),
    LikeModel(
      id: "11",
      userModel: UserModel.users[10],
      reactionModel:
          ReactionModel(id: "4", reactionType: "Like", colorName: "0xFF9C27B0"),
    ),
    LikeModel(
      id: "12",
      userModel: UserModel.users[11],
      reactionModel:
          ReactionModel(id: "1", reactionType: "Love", colorName: "0xFFFB71C1C"),
    ),
  ];

  static List<LikeModel> likes2 = [
    LikeModel(
      id: "1",
      userModel: UserModel.users[0],
      reactionModel:
          ReactionModel(id: "1", reactionType: "Love", colorName: "0xFFFB71C1C"),
    ),
    LikeModel(
      id: "2",
      userModel: UserModel.users[1],
      reactionModel:
          ReactionModel(id: "5", reactionType: "Fun", colorName: "0xFFF06292"),
    ),
    LikeModel(
      id: "3",
      userModel: UserModel.users[2],
      reactionModel:
          ReactionModel(id: "3", reactionType: "Sad", colorName: "0xFFF9A825"),
    ),
    // LikeModel(
    //   id: "4",
    //   userModel: MyApp.currentUser,
    //   reactionModel:
    //       ReactionModel(id: "1", reactionType: "Love", colorName: "0xFFFB71C1C"),
    // ),
    LikeModel(
      id: "5",
      userModel: UserModel.users[4],
      reactionModel:
          ReactionModel(id: "2", reactionType: "Angry", colorName: "0xFF000000"),
    ),
    LikeModel(
      id: "6",
      userModel: UserModel.users[5],
      reactionModel:
          ReactionModel(id: "4", reactionType: "Like", colorName: "0xFF9C27B0"),
    ),
    LikeModel(
      id: "7",
      userModel: UserModel.users[6],
      reactionModel:
          ReactionModel(id: "2", reactionType: "Angry", colorName: "0xFF000000"),
    ),
    LikeModel(
      id: "8",
      userModel: UserModel.users[7],
      reactionModel:
          ReactionModel(id: "3", reactionType: "Sad", colorName: "0xFFF9A825"),
    ),
    LikeModel(
      id: "9",
      userModel: UserModel.users[8],
      reactionModel:
          ReactionModel(id: "1", reactionType: "Love", colorName: "0xFFFB71C1C"),
    ),
    LikeModel(
      id: "10",
      userModel: UserModel.users[9],
      reactionModel:
          ReactionModel(id: "5", reactionType: "Fun", colorName: "0xFFF06292"),
    ),
    LikeModel(
      id: "11",
      userModel: UserModel.users[10],
      reactionModel:
          ReactionModel(id: "4", reactionType: "Like", colorName: "0xFF9C27B0"),
    ),
    LikeModel(
      id: "12",
      userModel: UserModel.users[11],
      reactionModel:
          ReactionModel(id: "1", reactionType: "Love", colorName: "0xFFFB71C1C"),
    ),
  ];

}
