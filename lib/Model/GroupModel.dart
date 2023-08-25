import 'dart:core';
import 'package:ppp/Model/UserModel.dart';
import 'package:ppp/main.dart';

import 'PostModel.dart';

class GroupModel {
  String id;
  String name;
  String imgPath;
  String description;
  DateTime createdAt;
  UserModel admin;
  List<PostModel> postModels;
  List<UserModel> members;

  GroupModel(
      {this.name,
      this.id,
      this.admin,
      this.postModels,
      this.members,
      this.imgPath,
      this.createdAt,
      this.description});

  GroupModel.fromJson(Map<String, dynamic> json) {
    this.id = json["id"].toString();
    this.name = json["name"];
    this.description = json["description"];
    this.createdAt = DateTime.parse(json["createdAt"]);
    if (json["imgPath"] != null) this.imgPath = json["imgPath"];
    if (json["admin"] != null) this.admin = UserModel.fromJson(json["admin"]);
    if (json['members'] != null) {
      this.members = new List<UserModel>();
      json['members'].forEach((v) {
        this.members.add(new UserModel.fromJson(v));
      });
    }
    if (json['postModels'] != null) {
      this.postModels = new List<PostModel>();
      json['postModels'].forEach((v) {
        this.postModels.add(new PostModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt.toString();
    if (this.imgPath != null) data['imgPath'] = this.imgPath;
    if (this.admin != null) data['admin'] = this.admin.toJson();
    if (this.members != null) {
      data['members'] = this.members.map((v) => v.toJson()).toList();
    }
    if (this.postModels != null) {
      data['postModels'] = this.postModels.map((v) => v.toJson()).toList();
    }
    return data;
  }

  get getId => this.id;

  set setId(String id) => this.id = id;

  get getName => this.name;

  set setName(name) => this.name = name;

  get getAdmin => this.admin;

  set setAdmin(admin) => this.admin = admin;

  get getImage => this.imgPath;

  set setImage(imgPath) => this.imgPath = imgPath;

  get getCreatedAt => this.createdAt;

  set setCreatedAt(createdAt) => this.createdAt = createdAt;

  get getDescription => this.description;

  set setDescription(description) => this.description = description;

  get getPostModels => this.postModels;

  set setPostModels(postModels) => this.postModels = postModels;

  get getMembers => this.members;

  set setMembers(members) => this.members = members;

  static List<GroupModel> groups = [
    GroupModel(
        id: "1",
        name: "drama news",
        admin: MyApp.currentUser,
        members: UserModel.users,
        imgPath: "images/photo1.jpg"),
    GroupModel(
        id: "2",
        name: "drama news",
        admin: MyApp.currentUser,
        members: UserModel.users,
        imgPath: "images/photo1.jpg"),
    GroupModel(
        id: "3",
        name: "drama news",
        admin: MyApp.currentUser,
        members: UserModel.users,
        imgPath: "images/photo1.jpg"),
    GroupModel(
        id: "4",
        name: "drama news",
        admin: MyApp.currentUser,
        members: UserModel.users,
        imgPath: "images/photo1.jpg"),
    GroupModel(
        id: "5",
        name: "drama news",
        admin: UserModel.users[3],
        members: UserModel.users,
        imgPath: "images/photo1.jpg"),
    GroupModel(
        id: "6",
        name: "drama news",
        admin: MyApp.currentUser,
        members: UserModel.users,
        imgPath: null),
    GroupModel(
        id: "7",
        name: "drama news",
        admin: UserModel.users[3],
        members: UserModel.users,
        imgPath: "images/photo1.jpg"),
    GroupModel(
        id: "8",
        name: "drama news",
        admin: UserModel.users[3],
        members: UserModel.users,
        imgPath: "images/photo1.jpg"),
  ];
}
