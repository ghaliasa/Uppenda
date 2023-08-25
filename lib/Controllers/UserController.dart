import 'package:ppp/Model/AuthRequest.dart';
import 'package:ppp/Model/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:ppp/controllers/UploadController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../main.dart';

class UserController {
  UserModel userModel;
  UploadController uploadController = UploadController();
  String currentUri = MyApp.mainURL + "/users";

  Future<List<UserModel>> search(String word) async {
    var response = await http.get(
      Uri.parse(currentUri + "/search/word=$word"),
      headers: {"Authorization": "Bearer " + MyApp.currentUser.getToken},
    );
    List<dynamic> sss = json.decode(response.body);
    List<UserModel> list = List();
    for (int i = 0; i < sss.length; i++) {
      if (sss.isNotEmpty) {
        list.add(UserModel.fromJson(sss[i]));
      }
    }
    return list;
  }

  Future<UserModel> getUserByID(String id) async {
    int a = int.parse(id);
    final response = await http.get(
      Uri.parse(currentUri + '/getUser/Id=$a'),
      headers: {"Authorization": "Bearer " + MyApp.currentUser.getToken},
    );
    userModel = UserModel.fromJson(json.decode(response.body));
    return userModel;
  }

  Future<UserModel> addUser1(UserModel userModel) async {
    final body = json.encode(userModel.toJson());
    final response = await http
        .post(Uri.parse(currentUri + "/addUser"), body: body, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + MyApp.currentUser.getToken
    });

    userModel = UserModel.fromJson(json.decode(response.body));

    if (userModel.getImage != null) {
      uploadController.uploadFile(userModel, "users");
    }
    return userModel;
  }

  Future<String> sharePost(String u_id, String p_id) async {
    int u = int.parse(u_id);
    int p = int.parse(p_id);
    final response = await http.get(
      Uri.parse(currentUri + '/sharePost/userId=$u,postId=$p'),
      headers: {"Authorization": "Bearer " + MyApp.currentUser.getToken},
    );
    print("\n***************\n");
    print(response.body);
    print("\n***************\n");
    if (response.statusCode == 200) return response.body;
    return 'Connection error';
  }

  Future<String> savePost(String u_id, String p_id) async {
    int u = int.parse(u_id);
    int p = int.parse(p_id);
    final response = await http.get(
      Uri.parse(currentUri + '/savePost/userId=$u,postId=$p'),
      headers: {"Authorization": "Bearer " + MyApp.currentUser.getToken},
    );
    print("\n***************\n");
    print(response.body);
    print("\n***************\n");
    if (response.statusCode == 200) return response.body;
    return 'Connection error';
  }

  Future<String> unSharePost(String u_id, String p_id) async {
    int u = int.parse(u_id);
    int p = int.parse(p_id);
    final response = await http.get(
      Uri.parse(currentUri + '/unSharePost/userId=$u,postId=$p'),
      headers: {"Authorization": "Bearer " + MyApp.currentUser.getToken},
    );
    print("\n***************\n");
    print(response.body);
    print("\n***************\n");
    if (response.statusCode == 200) return response.body;
    return 'Connection error';
  }

  Future<String> unSavePost(String u_id, String p_id) async {
    int u = int.parse(u_id);
    int p = int.parse(p_id);
    final response = await http.get(
      Uri.parse(currentUri + '/unSavePost/userId=$u,postId=$p'),
      headers: {"Authorization": "Bearer " + MyApp.currentUser.getToken},
    );
    print("\n***************\n");
    print(response.body);
    print("\n***************\n");
    if (response.statusCode == 200) return response.body;
    return 'Connection error';
  }

  Future<UserModel> update(UserModel userModel) async {
    var response = await http.post(Uri.parse(currentUri + "/updateUser"),
        body: json.encode(userModel.toJson()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + MyApp.currentUser.getToken
        });
    userModel = UserModel.fromJson(json.decode(response.body));

    return userModel;
  }

  Future<UserModel> addFriend(String me_id, String friend_id) async {
    int m = int.parse(me_id);
    int f = int.parse(friend_id);
    final response = await http.get(
      Uri.parse(currentUri + "/addFriend/userId=$m,friendId=$f"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + MyApp.currentUser.getToken
      },
    );

    this.userModel = UserModel.fromJson(json.decode(response.body));

    print("\n***************\n");
    print(response.body);
    print("\n***************\n");

    return this.userModel;
  }

  Future<UserModel> unFriend(String me_id, String friend_id) async {
    int m = int.parse(me_id);
    int f = int.parse(friend_id);
    final response = await http.get(
      Uri.parse(currentUri + "/unFriend/userId=$m,friendId=$f"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + MyApp.currentUser.getToken
      },
    );

    this.userModel = UserModel.fromJson(json.decode(response.body));

    print("\n***************\n");
    print(response.body);
    print("\n***************\n");

    return this.userModel;
  }

  /////////////////////mahmoood
  void clearCache() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    cache.clear();
  }

  Future<Map> addUser(UserModel user) async {
    var path = currentUri + '/addUser';
    Uri uri = Uri.parse(path);
    var t = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode(user),
    );
    // var test = json.decode(t.body);
    // clearCache();
    // saveUserAndTokenInCache(test);
    // userModel = UserModel.fromJson(test['userModel']);
    // MyApp.currentUser = UserModel.fromJson(test["userModel"]);

    // if (userModel.getImage != null) {
    //   uploadController.uploadFile(userModel, "users");
    // }
    // return json.decode(t.body);
  }

  Future<Map> deleteUser() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    var path = currentUri + '/deleteById';
    Uri uri = Uri.parse(path);
    Map<String, String> map = {"id": cache.getString("id")};
    var t = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + MyApp.currentUser.getToken
        },
        body: json.encode(map));
    clearCache();
    return json.decode(t.body);
  }

  Future<Map> signIn(AuthRequest authRequest) async {
    var path = currentUri + '/signIn';
    Uri uri = Uri.parse(path);
    print(uri);
    var t = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: json.encode(authRequest));
    print(t.body);
    var test = json.decode(t.body);
    print("body is : " + t.body);
    print("token is: " + test['token'].toString());
    print("userModel is: " + test['userModel'].toString());
    MyApp.currentUser = UserModel.fromJson(test["userModel"]);
    clearCache();
    saveUserAndTokenInCache(test);
    return json.decode(t.body);
  }

  Future<UserModel> getUserById(String id) async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    var path = currentUri + '/getUser/Id=' + id;
    Uri uri = Uri.parse(path);
    var t = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + cache.getString("token")
      },
    );
    return UserModel.fromJson(json.decode(t.body));
  }

  Future<UserModel> getUserByIdFromCache() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    var path = currentUri + '/getUser/Id=' + cache.getString("id");
    Uri uri = Uri.parse(path);
    print(uri);
    var t = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + cache.getString("token")
      },
    );
    return UserModel.fromJson(json.decode(t.body));
  }

  void saveUserAndTokenInCache(Map<String, dynamic> json) async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    print(json['token']);
    print("\n\n____________________________\n\n");
    print(json['userModel']);
    print("\n\n____________________________\n\n");
    if (json['token'] != null) {
      cache.setString("token", json['token']);
    }
    if (json['userModel'] != null)
      cache.setString("id", UserModel.fromJson(json['userModel']).getId);
  }

  Future<UserModel> updateUser(UserModel user, bool updateImage) async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    user.setId = cache.getString('id').toString();
    var path = currentUri + '/updateUser';
    Uri uri = Uri.parse(path);
    var t = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + cache.getString("token")
        },
        body: json.encode(user));
    var test = json.decode(t.body);
    clearCache();
    saveUserAndTokenInCache(test);
    userModel = UserModel.fromJson(test['userModel']);
    print("\n\n\n\t\t");
    // print(">>>>>>>>>>>>>>>>     image path " + user.getImage);
    print(">>>>>>>>>>>>>>>>     boolean    " + updateImage.toString());
    print("\n\n\n\t\t");
    if (updateImage) {
      if (userModel.getImage != null) {
        uploadController.uploadFile(user, "users");
      }
    }
    return UserModel.fromJson(json.decode(t.body));
  }
}
