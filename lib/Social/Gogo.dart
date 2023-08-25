import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ppp/Model/GroupModel.dart';
import 'package:ppp/Model/PageModel.dart';
//import 'package:image_picker/image_picker.dart';

class Go extends StatefulWidget {
  GroupModel pageModel;
  Go({this.pageModel});

  @override
  _GoState createState() => _GoState();
}

class _GoState extends State<Go> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(widget.pageModel.getId),
          Text(widget.pageModel.getName),
          Text(widget.pageModel.getDescription),
          Text(widget.pageModel.getCreatedAt),
          Text(widget.pageModel.getImage),
        ],
      ),
    );
  }
}
