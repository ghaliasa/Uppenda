import 'package:flutter/material.dart';
import 'package:ppp/Body/BodyPageButton.dart';
import 'package:ppp/Model/PageModel.dart';

class Pages extends StatefulWidget {
  List<PageModel> pagemodel;
  Pages({this.pagemodel});

  @override
  PagesState createState() => PagesState();
}

class PagesState extends State<Pages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
          itemBuilder: (context, i) {
            return BodyPageButton(pageModel: widget.pagemodel[i]);
          },
          separatorBuilder: (ctx, i) {
            return Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14.0),
              child: Divider(
                thickness: 0.5,
                color: Colors.purple,
              ),
            );
          },
          itemCount: widget.pagemodel.length),
    );
  }
}
