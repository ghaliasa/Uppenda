import 'package:flutter/material.dart';
import 'package:ppp/Model/GroupModel.dart';
import 'package:ppp/Pages/Group.dart';

class GroupsSearch extends StatefulWidget {
  GroupModel groupmodel;
  GroupsSearch({this.groupmodel});

  @override
  _GroupsSearchState createState() => _GroupsSearchState();
}

class _GroupsSearchState extends State<GroupsSearch> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 8.0, right: 12),
            child: Icon(Icons.search, color: Color.fromRGBO(233, 207, 236, 1)),
          ),
          Container(
            child: InkWell(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.groupmodel.getName,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black38,
                        fontFamily: 'Merienda',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                if (widget.groupmodel.getId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        if (widget.groupmodel.getId == null)
                          return Center(child: CircularProgressIndicator());
                        else
                          return Group1(
                            group_id: widget.groupmodel.getId,
                          );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
