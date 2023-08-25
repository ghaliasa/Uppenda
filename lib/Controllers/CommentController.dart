import 'package:http/http.dart' as http;
import 'package:ppp/Model/CommentModel.dart';
import 'dart:convert';

import '../main.dart';
import 'UploadController.dart';

class CommentController {
  CommentModel commentModel = CommentModel();
  UploadController uploadController = UploadController();
  String currentUri = MyApp.mainURL + "/comment";

  Future<CommentModel> addComment(
      CommentModel commentModel, String u_id, String p_id) async {
    int u = int.parse(u_id);
    int p = int.parse(p_id);
    final body = json.encode(commentModel.toJson());
    final response = await http
        .post(Uri.parse(currentUri + "/add/$p/$u"), body: body, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + MyApp.currentUser.getToken
    });

    this.commentModel = CommentModel.fromJson(json.decode(response.body));

    if (commentModel.getImage != null) {
      uploadController.uploadFile(this.commentModel, "comments");
    }
    return commentModel;
  }

  Future<CommentModel> updateComment(CommentModel commentModel) async {
    final body = json.encode(commentModel.toJson());
    final response = await http
        .post(Uri.parse(currentUri + "/update"), body: body, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + MyApp.currentUser.getToken
    });

    print("\n^^^^^^^^^^^^^^^^^^^^^\n");
    print(response.body);
    print("\n^^^^^^^^^^^^^^^^^^^^^\n");

    this.commentModel = CommentModel.fromJson(json.decode(response.body));
    return commentModel;
  }

  Future<CommentModel> deleteById(String id) async {
    int p = int.parse(id);
    var response =
        await http.delete(Uri.parse(currentUri + "/delete/$p"), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + MyApp.currentUser.getToken
    });

    print("\n***************\n");
    print(response.body);
    print("\n***************\n");
  }
}
