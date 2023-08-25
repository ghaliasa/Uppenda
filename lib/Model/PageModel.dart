import 'dart:core';
import 'package:ppp/Model/UserModel.dart';
import 'package:ppp/main.dart';

import 'PostModel.dart';

class PageModel {
  String id;
  String name;
  String description;
  String imgPath;
  DateTime createdAt;
  UserModel admin;
  List<UserModel> members;
  List<PostModel> postModels;

  PageModel(
      {this.id,
      this.name,
      this.admin,
      this.members,
      this.imgPath,
      this.description,
      this.createdAt,
      this.postModels});

  PageModel.fromJson(Map<String, dynamic> json) {
    this.id = json["id"].toString();
    this.name = json["name"];
    this.description = json["description"];
    if (json["createdAt"] != null)
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

  set setName(pageName) => this.name = name;

  get getAdmin => this.admin;

  set setAdmin(admin) => this.admin = admin;

  get getMembers => this.members;

  set setMembers(members) => this.members = members;

  get getImage => this.imgPath;

  set setImage(imgPath) => this.imgPath = imgPath;

  get getDescription => this.description;

  set setDescription(description) => this.description = description;

  get getCreatedAt => this.createdAt;

  set setCreatedAt(createdAt) => this.createdAt = createdAt;

  get getPostModels => this.postModels;

  set setPostModels(postModels) => this.postModels = postModels;

  static List<PageModel> pages = [
    PageModel(
        id: "1",
        name: "drama news",
        admin: UserModel.users[2],
        members: UserModel.users,
        imgPath: null),
    PageModel(
        id: "2",
        name: "drama news",
        admin: MyApp.currentUser,
        members: UserModel.users,
        imgPath: "images/photo.jpg"),
    PageModel(
        id: "3",
        name: "drama news",
        admin: UserModel.users[4],
        members: UserModel.users,
        imgPath: null),
    PageModel(
        id: "4",
        name: "drama news",
        admin: UserModel.users[2],
        members: UserModel.users,
        imgPath: "images/photo.jpg"),
    PageModel(
        id: "5",
        name: "drama news",
        admin: MyApp.currentUser,
        members: UserModel.users,
        imgPath: "images/photo.jpg"),
    PageModel(
        id: "6",
        name: "drama news",
        admin: UserModel.users[3],
        members: UserModel.users,
        imgPath: "images/photo.jpg"),
    PageModel(
        id: "7",
        name: "drama news",
        admin: UserModel.users[2],
        members: UserModel.users,
        imgPath: "images/photo.jpg"),
  ];
}
