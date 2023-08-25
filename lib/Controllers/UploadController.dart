import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ppp/Model/MediaModel.dart';
import 'package:ppp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadController {
  uploadFile(dynamic model, String type) async {
    print("__________________");
    print(model.getImage);
    print("__________________");
    SharedPreferences cache = await SharedPreferences.getInstance();
    var request = http.MultipartRequest(
        'POST', Uri.parse(MyApp.mainURL + "/upload/employee"));
    print("object");
    request.fields["type"] = type;
    request.headers.addAll({
      // "Content-Type": "application/json",
      "Authorization": "Bearer " + cache.getString("token")
    });
    request.fields["id"] = model.getId;
    request.fields["name"] =
        model.getId + "." + model.getImage.split("/").last.split(".").last;

    request.files
        .add(await http.MultipartFile.fromPath('file', model.getImage));
    var res = await request.send();
  }

  uploadMultiFile(List<MediaModel> mediaMdoels) async {
// var request = http.MultipartRequest(
//         'POST', Uri.parse("http://192.168.43.55:8083/upload/upload-multiple-files"));

//     request.fields["type"] = "posts";
//     request.fields["id"] = ;
//     request.fields["name"] =
//         model.getId + "." + model.getImage.split("/").last.split(".").last;

//     request.files
//         .add(await http.MultipartFile.fromPath('file', .getImage));
//     var res = await request.send();
  }
}
