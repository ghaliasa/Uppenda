import 'package:ppp/Model/CommentModel.dart';
import 'package:ppp/Model/GroupModel.dart';
import 'package:ppp/Model/LikeModel.dart';
import 'package:ppp/Model/MediaModel.dart';
import 'package:ppp/Model/PageModel.dart';
import 'package:ppp/Model/TypeModel.dart';
import 'package:ppp/Model/UserModel.dart';
import 'package:ppp/main.dart';

class PostModel {
  String id;
  String content;
  DateTime createdAt;
  UserModel userModel;
  GroupModel groupModel;
  PageModel pageModel;
  TypeModel type;
  List<LikeModel> likeModels;
  List<CommentModel> commentModels;
  List<MediaModel> media = [];
  List<UserModel> savers;
  List<UserModel> participants;

////// for delete
  String imagePost;
  String videoPost;
  // List<ShareModel> share;

///////

  PostModel(
      {this.id,
      this.userModel,
      this.createdAt,
      this.pageModel,
      this.groupModel,
      this.imagePost,
      this.videoPost,
      this.content,
      this.type,
      this.commentModels,
      this.likeModels,
      this.media,
      this.savers,
      this.participants});

  PostModel.fromJson(Map<String, dynamic> json) {
    this.id = json["id"].toString();
    this.content = json["content"];
    this.createdAt = DateTime.parse(json["createdAt"]);
    if (json["userModel"] != null)
      this.userModel = UserModel.fromJson(json["userModel"]);
    if (json["groupModel"] != null)
      this.groupModel = GroupModel.fromJson(json["groupModel"]);
    if (json["pageModel"] != null)
      this.pageModel = PageModel.fromJson(json["pageModel"]);
    if (json["type"] != null) this.type = TypeModel.fromJson(json["type"]);
    if (json['likeModels'] != null) {
      this.likeModels = new List<LikeModel>();
      json['likeModels'].forEach((v) {
        this.likeModels.add(new LikeModel.fromJson(v));
      });
    }
    if (json['commentModels'] != null) {
      this.commentModels = new List<CommentModel>();
      json['commentModels'].forEach((v) {
        this.commentModels.add(new CommentModel.fromJson(v));
      });
    }
    if (json['media'] != null) {
      this.media = new List<MediaModel>();
      json['media'].forEach((v) {
        this.media.add(new MediaModel.fromJson(v));
      });
    }
    if (json['savers'] != null) {
      this.savers = new List<UserModel>();
      json['savers'].forEach((v) {
        this.savers.add(new UserModel.fromJson(v));
      });
    }
    if (json['participants'] != null) {
      this.participants = new List<UserModel>();
      json['participants'].forEach((v) {
        this.participants.add(new UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt.toString();
    if (this.userModel != null) data['userModel'] = this.userModel.toJson();
    if (this.groupModel != null) data['groupModel'] = this.groupModel.toJson();
    if (this.pageModel != null) data['pageModel'] = this.pageModel.toJson();
    if (this.type != null) data['type'] = this.type.toJson();
    if (this.likeModels != null) {
      data['likeModels'] = this.likeModels.map((v) => v.toJson()).toList();
    }
    if (this.commentModels != null) {
      data['commentModels'] =
          this.commentModels.map((v) => v.toJson()).toList();
    }
    if (this.media != null) {
      data['media'] = this.media.map((v) => v.toJson()).toList();
    }
    if (this.savers != null) {
      data['savers'] = this.savers.map((v) => v.toJson()).toList();
    }
    if (this.participants != null) {
      data['participants'] = this.participants.map((v) => v.toJson()).toList();
    }

    return data;
  }

  String get getId => this.id;

  set setId(String id) => this.id = id;

  get getUserModel => this.userModel;

  set setUserModel(userModel) => this.userModel = userModel;

  get getPageModel => this.pageModel;

  set setPageModel(pageModel) => this.pageModel = pageModel;

  get getCreatedAt => this.createdAt;

  set setCreatedAt(createdAt) => this.createdAt = createdAt;

  get getContent => this.content;

  set setContent(content) => this.content = content;

  get getImagePost => this.imagePost;

  set setImagePost(imagePost) => this.imagePost = imagePost;

  get getVideoPost => this.videoPost;

  set setVideoPost(videoPost) => this.videoPost = videoPost;

  get getGroupModel => this.groupModel;

  set setGroupModel(groupModel) => this.groupModel = groupModel;

  get getType => this.type;

  set setType(type) => this.type = type;

  get getCommentModels => this.commentModels;

  set setCommentModels(commentModels) => this.commentModels = commentModels;

  get getLikeModels => this.likeModels;

  set setLikeModels(likeModels) => this.likeModels = likeModels;

  get getMedia => this.media;

  set setMedia(media) => this.media = media;

  get getSavers => this.savers;

  set setSavers(savers) => this.savers = savers;

  get getParticipants => this.participants;

  set setParticipants(participants) => this.participants = participants;

  // static List<PostModel> posts = [
  //   PostModel(
  //     id: "1",
  //     // createdAt: "28/7/2021",
  //     content:
  //         "Love the design of all the products at an affordable price. Everything is so easy to put together. Ordering and shipping \n is easy and very professionally\n handled, and all customer service has been timely and helpful.together. Ordering and shipping \n is easy and very professionally\n handled, and all customer service has been timely and helpfultogether. Ordering and shipping \n is easy and very professionally\n handled, and all customer service has been timely and helpfultogether. Ordering and shipping \n is easy and very professionally\n handled, and all customer service has been timely and helpfultogether. Ordering and shipping \n is easy and very professionally\n handled, and all customer service has been timely and helpfultogether. Ordering and shipping \n is easy and very professionally\n handled, and all customer service has been timely and helpful",
  //     commentModels: CommentModel.comments,
  //     likeModels: LikeModel.likes,
  //     userModel: MyApp.currentUser,
  //     share: ShareModel.shares,
  //     type: TypeModel(id: "1", typename: "Sport"),
  //   ),
  //   PostModel(
  //     id: "2",
  //     // createdAt: "5/7/2021",
  //     imagePost: "images/LongTermMemory.jpg",
  //     commentModels: CommentModel.comments,
  //     likeModels: LikeModel.likes,
  //     userModel: MyApp.currentUser,
  //     share: ShareModel.shares,
  //     type: TypeModel(id: "2", typename: "Historical"),
  //   ),
  //   PostModel(
  //     id: "15",
  //     // createdAt: "12/7/2021",
  //     videoPost: "images/videoo.mp4",
  //     commentModels: CommentModel.comments,
  //     likeModels: LikeModel.likes,
  //     userModel: MyApp.currentUser,
  //     groupModel: GroupModel.groups[2],
  //     share: ShareModel.shares,
  //     type: TypeModel(id: "2", typename: "Historical"),
  //   ),
  //   PostModel(
  //     id: "4",
  //     // createdAt: "2/5/2021",
  //     imagePost: "images/logo.jpg",
  //     content:
  //         "Love the design of all the products at an affordable price. Everything is so easy to put together. Ordering and shipping\n is easy and very professionally\n handled, and all customer service has been timely and helpful.",
  //     commentModels: CommentModel.comments,
  //     likeModels: LikeModel.likes,
  //     userModel: UserModel.users[8],
  //     share: ShareModel.shares,
  //     type: TypeModel(id: "5", typename: "Fashoin"),
  //   ),
  //   PostModel(
  //     id: "15",
  //     // createdAt: "2/9/2021",
  //     videoPost: "images/videoo.mp4",
  //     content:
  //         "Love the design of all the products at an affordable price. Everything is so easy to put together. Ordering and shipping\n is easy and very professionally\n handled, and all customer service has been timely and helpful.",
  //     commentModels: CommentModel.comments,
  //     likeModels: LikeModel.likes,
  //     share: ShareModel.shares,
  //     pageModel: PageModel.pages[2],
  //     type: TypeModel(id: "5", typename: "Fashoin"),
  //   ),
  // ];

}
