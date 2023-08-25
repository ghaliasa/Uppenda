import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ppp/Body/BodyGroupButton.dart';
import 'package:ppp/Model/GroupModel.dart';

class Groups extends StatefulWidget {
  List<GroupModel> groupmodel;
  Groups({this.groupmodel});

  @override
  GroupsState createState() => GroupsState();
}

class GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
          itemBuilder: (context, i) {
            return BodyGroupButton(
             groupmodel: widget.groupmodel[i],
            );
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
          itemCount: widget.groupmodel.length),
    );
  }
}
