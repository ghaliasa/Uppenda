import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ppp/Model/GroupModel.dart';
import 'package:ppp/Model/PageModel.dart';
import 'package:ppp/Model/UserModel.dart';
//import 'package:image_picker/image_picker.dart';

class Usewidget extends StatefulWidget {
  UserModel pageModel;
  Usewidget({this.pageModel});

  @override
  _UsewidgetState createState() => _UsewidgetState();
}

class _UsewidgetState extends State<Usewidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(widget.pageModel.getId),
          Text(widget.pageModel.getFirstName),
          Text(widget.pageModel.getLastName),
          Text(widget.pageModel.getCreatedAt.toString()),
          Text(widget.pageModel.getImage),
        ],
      ),
    );
  }
}
