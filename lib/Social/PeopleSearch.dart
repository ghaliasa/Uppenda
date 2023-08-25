import 'package:flutter/material.dart';
import 'package:ppp/Model/UserModel.dart';
import 'package:ppp/Pages/profile.dart';

class PeopleSearch extends StatefulWidget {
  UserModel usermodel;
  PeopleSearch({this.usermodel});

  @override
  _PeopleSearchState createState() => _PeopleSearchState();
}

class _PeopleSearchState extends State<PeopleSearch> {
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
            child: Icon(
              Icons.search,
              color: Color.fromRGBO(233, 207, 236, 1),
            ),
          ),
          Container(
            child: InkWell(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.usermodel.firstName +
                          ' ' +
                          widget.usermodel.lastName,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Profile(
                        user_id: widget.usermodel.getId,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
