import 'dart:convert';

import 'package:ppp/Model/PageModel.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'UploadController.dart';
import 'UserController.dart';

class PageControler {
  PageModel pageModel;
  UploadController uploadController = UploadController();
  String currentUri = MyApp.mainURL + "/pages";
  Future<List<PageModel>> search(String word) async {
    var response = await http.get(
      Uri.parse(currentUri + "/search/word=$word"),
      headers: {"Authorization": "Bearer " + MyApp.currentUser.getToken},
    );
    List<dynamic> sss = json.decode(response.body);
    List<PageModel> list = List();
    for (int i = 0; i < sss.length; i++) {
      if (sss.isNotEmpty) {
        list.add(PageModel.fromJson(sss[i]));
      }
    }
    return list;
  }

  Future<PageModel> getPageById1(String id) async {
    int p = int.parse(id);
    final response = await http.get(
      Uri.parse(currentUri + '/getPageById/id=$p'),
      headers: {"Authorization": "Bearer " + MyApp.currentUser.getToken},
    );
    pageModel = PageModel.fromJson(json.decode(response.body));
    print("\n^^^^^^^^^^ggg^^^^^^^^^^^\n");
    print(response.body);
    print("\n^^^^^^^^^ggg^^^^^^^^^^^^\n");
    return pageModel;
  }

  Future<PageModel> updateInformation(PageModel pageModel) async {
    var response = await http.post(Uri.parse(currentUri + "/updateInformation"),
        body: json.encode(pageModel.toJson()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + MyApp.currentUser.getToken
        });

    PageModel p = PageModel.fromJson(json.decode(response.body));
  }

  Future<PageModel> addPage(PageModel pageModel, String admin_id) async {
    print("\n\n\n\n\n\t\t\t >>>>   " + pageModel.getName + "\n\n");
    int ad = int.parse(admin_id);
    final body = json.encode(pageModel.toJson());
    final response = await http.post(
        Uri.parse(currentUri + "/addPage/adminId=$ad"),
        body: body,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + MyApp.currentUser.getToken
        });

    this.pageModel = PageModel.fromJson(json.decode(response.body));

    if (pageModel.getImage != null) {
      uploadController.uploadFile(this.pageModel, "pages");
    }

    print("\n^^^^^^^^^^^^^^^^^^^^^\n");
    print(response.body);
    print("\n^^^^^^^^^^^^^^^^^^^^^\n");

    return pageModel;
  }

  leavePage(String u_id, String p_id) {}

  ///////////////////////// mahmood
  Future<PageModel> getPageById(String id) async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    int p = int.parse(id);
    var path = currentUri + '/findById/$p';
    Uri uri = Uri.parse(path);
    // print(uri);
    print(cache.getString('token'));
    var t = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + cache.getString("token")
    });
    return PageModel.fromJson(json.decode(t.body));
  }

  Future<bool> isUserAdmin(PageModel pageModel) async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    // print(cache.getString('id'));
    // print(pageModel.getAdmin().getFirstName);
    return MyApp.currentUser.getId == pageModel.getAdmin.getId;
  }

  void unFollowToThisPage(String u_id, String page_id) async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    int p = int.parse(page_id);
    int u = int.parse(u_id);
    var path = currentUri + "/deleteMember/pageId=$p,memberId=$u";
    Uri uri = Uri.parse(path);
    // print(uri);
    var t = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + cache.getString("token")
      },
    );
    print("\n^^^^^^^^^^UnfollowPage1^^^^^^^^^^^\n");
    print(t.body);
    print("\n^^^^^^^^^UnfollowPage2^^^^^^^^^^^^\n");
  }

  void followThisPage(String u_id, String page_id) async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    int u = int.parse(u_id);
    int p = int.parse(page_id);
    var path = currentUri + "/addMember/pageId=$p,memberId=$u";
    Uri uri = Uri.parse(path);
    var t = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + cache.getString("token")
    });
    print("\n^^^^^^^^^^followPage1^^^^^^^^^^^\n");
    print(t.body);
    print("\n^^^^^^^^^followPage2^^^^^^^^^^^^\n");
  }

  void deletePage(PageModel pageModel) async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    var path = currentUri + '/deleteById/Id=' + pageModel.getId;
    Uri uri = Uri.parse(path);
    var t = await http.post(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + cache.getString("token")
    });
  }
}
