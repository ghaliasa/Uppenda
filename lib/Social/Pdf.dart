import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ppp/Model/GroupModel.dart';
import 'package:ppp/Model/PageModel.dart';
//import 'package:image_picker/image_picker.dart';

class pdfwidget extends StatefulWidget {
  PageModel pageModel;
  pdfwidget({this.pageModel});

  @override
  _pdfwidgetState createState() => _pdfwidgetState();
}

class _pdfwidgetState extends State<pdfwidget> {
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
