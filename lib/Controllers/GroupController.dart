import 'dart:convert';

import 'package:ppp/Model/GroupModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'UploadController.dart';

class GroupController {
  GroupModel groupModel;
  UploadController uploadController = UploadController();
  String currentUri = MyApp.mainURL + "/groups";

  Future<List<GroupModel>> search(String word) async {
    var response = await http.get(
      Uri.parse(currentUri + "/search/word=$word"),
      headers: {"Authorization": "Bearer " + MyApp.currentUser.getToken},
    );
    List<dynamic> sss = json.decode(response.body);
    List<GroupModel> list = List();
    for (int i = 0; i < sss.length; i++) {
      if (sss.isNotEmpty) {
        list.add(GroupModel.fromJson(sss[i]));
      }
    }
    return list;
  }

  Future<GroupModel> addGroup(GroupModel groupModel, String admin_id) async {
    int ad = int.parse(admin_id);
    final body = json.encode(groupModel.toJson());
    final response = await http.post(
        Uri.parse(currentUri + "/addGroup/adminId=$ad"),
        body: body,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + MyApp.currentUser.getToken
        });

    this.groupModel = GroupModel.fromJson(json.decode(response.body));

    if (groupModel.getImage != null) {
      uploadController.uploadFile(this.groupModel, "groups");
    }

    print("\n^^^^^^^^^^^^^^^^^^^^^\n");
    print(response.body);
    print("\n^^^^^^^^^^^^^^^^^^^^^\n");

    return groupModel;
  }

  Future<GroupModel> updateInformation(GroupModel groupModel) async {
    var response = await http.post(Uri.parse(currentUri + "/updateInformation"),
        body: json.encode(groupModel.toJson()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + MyApp.currentUser.getToken
        });
  }

  Future<GroupModel> getGroupById1(String id) async {
    int g = int.parse(id);
    final response = await http.get(
      Uri.parse(currentUri + '/getGroup/Id=$g'),
      headers: {"Authorization": "Bearer " + MyApp.currentUser.getToken},
    );
    groupModel = GroupModel.fromJson(json.decode(response.body));
    print("\n^^^^^^^^^^getGroupId^^^^^^^^^^^\n");
    print(response.body);
    print("\n^^^^^^^^^ggg^^^^^^^^^^^^\n");
    return groupModel;
  }

  ////////////////////// mahmood
  Future<GroupModel> getGroupById(String id) async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    int i = int.parse(id);
    var path = currentUri + '/findById/$i';
    Uri uri = Uri.parse(path);
    print(">>>>>>>>>>>>>>>>" + uri.toString());
    var t = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + cache.getString("token")
    });

    GroupModel group = GroupModel.fromJson(json.decode(t.body));
    // print("!!!!!!!!!!!!!!!!!!!"+group.toString());
    return group;
  }

  Future<bool> isUserAdmin(GroupModel groupModel) async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    print(groupModel.getName);
    print(cache.getString('id'));
    return MyApp.currentUser.getId == groupModel.getAdmin.getId;
  }

  void leaveGroup(String u_id, String g_id) async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    int g = int.parse(g_id);
    int u = int.parse(u_id);
    var path = currentUri + "/leaveMember/group_id=$g,user_id=$u";
    Uri uri = Uri.parse(path);
    print(uri);
    var t = await http.post(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + cache.getString("token")
    });
    print("\n^^^^^^^^^^leaveGroup1^^^^^^^^^^^\n");
    print(t.body);
    print("\n^^^^^^^^^leaveGroup2^^^^^^^^^^^^\n");
  }

  void joinToGroup(String u_id, String groupId) async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    int u = int.parse(u_id);
    int g = int.parse(groupId);
    var path = currentUri + "/addMember/group_id=$g,user_id=$u";
    Uri uri = Uri.parse(path);
    // print(uri);
    var t = await http.post(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + cache.getString("token")
    });
    print("\n^^^^^^^^^^joinGroup1^^^^^^^^^^^\n");
    print(t.body);
    print("\n^^^^^^^^^joinGroup2^^^^^^^^^^^^\n");
  }

  void deleteGroup(GroupModel groupModel) async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    var path = currentUri + '/deleteGroup/Id=' + groupModel.getId.toString();
    Uri uri = Uri.parse(path);
    // print(uri);
    var t = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + cache.getString("token")
    });
  }
}
