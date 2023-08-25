import 'package:flutter/material.dart';
import 'package:ppp/Model/PageModel.dart';
import 'package:ppp/Pages/Page.dart';

class PagesSearch extends StatefulWidget {
  PageModel pagemodel;
  PagesSearch({this.pagemodel});

  @override
  _PagesSearchState createState() => _PagesSearchState();
}

class _PagesSearchState extends State<PagesSearch> {
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
                      text: widget.pagemodel.name,
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
                      return Page1(
                        page_id: widget.pagemodel.getId,
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
