import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ppp/Body/BodyGroupButton.dart';
import 'package:ppp/Body/BodyPageButton.dart';
import 'package:ppp/Controllers/GroupController.dart';
import 'package:ppp/Controllers/PageController.dart';
import 'package:ppp/Controllers/UserController.dart';
import 'package:ppp/Model/GroupModel.dart';
import 'package:ppp/Model/PageModel.dart';
import 'package:ppp/Model/UserModel.dart';
import 'package:ppp/Social/CreateGroup.dart';
import 'package:ppp/Social/CreatePage.dart';
import 'package:ppp/Social/CreatePost.dart';
import 'package:ppp/Social/GroupsSearch.dart';
import 'package:ppp/Social/PagesSearch.dart';
import 'package:ppp/Social/PeopleSearch.dart';
import 'package:ppp/Social/Social_Home.dart';
import 'package:ppp/pages/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Search extends StatefulWidget {
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  TextEditingController textSearch = TextEditingController();
  UserController userController = UserController();
  GroupController groupController = GroupController();
  PageControler pageController = PageControler();

  List<UserModel> users = [];
  List<PageModel> pages = [];
  List<GroupModel> groups = [];
  bool typing = false;

  String profileId;
  Future<String> getUserFromCache() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    return cache.getString('id');
  }

  @override
  void initState() {
    super.initState();
    getUserFromCache().then((idFromChash) {
      setState(() {
        profileId = idFromChash;
        userController.getUserById(idFromChash).then((value) {
          setState(() {
            MyApp.currentUser = value;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: TextBox(),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.purple,
            indicatorWeight: 3.0,
            tabs: [
              Tab(
                child: Container(
                  child: Text(
                    'People',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w200,
                        fontFamily: 'Merienda'),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    'Pages',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w200,
                        fontFamily: 'Merienda'),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    'Groups',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w200,
                        fontFamily: 'Merienda'),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            users.isEmpty
                ? Center(
                    child: Text("No pages in this name",
                        style: TextStyle(fontFamily: 'Merienda')),
                  )
                : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, i) {
                      return PeopleSearch(usermodel: users[i]);
                    },
                  ),
            pages.isEmpty
                ? Center(
                    child: Text(
                      "No pages in this name",
                      style: TextStyle(fontFamily: 'Merienda'),
                    ),
                  )
                : ListView.builder(
                    itemCount: pages.length,
                    itemBuilder: (context, i) {
                      return PagesSearch(
                        pagemodel: pages[i],
                      );
                    },
                  ),
            groups.isEmpty
                ? Center(
                    child: Text(
                      "No groups in this name",
                      style: TextStyle(fontFamily: 'Merienda'),
                    ),
                  )
                : ListView.builder(
                    itemCount: groups.length,
                    itemBuilder: (context, i) {
                      return GroupsSearch(
                        groupmodel: groups[i],
                      );
                    },
                  ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          color: Colors.white,
          height: 55.0,
          child: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 5.0, 2.0, 0.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(
                            user_id: profileId,
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      MdiIcons.account,
                      size: 30,
                      color: Colors.purple,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 5.0, 2.0, 0.0),
                  child: IconButton(
                    icon: Icon(Icons.supervised_user_circle,
                        color: Colors.purple, size: 30),
                    onPressed: () {
                      showGroupsButton();
                    },
                  ),
                ),
                FloatingActionButton(
                    heroTag: 1,
                    child: Icon(
                      Icons.add_circle_sharp,
                      size: 40,
                      color: Color.fromRGBO(233, 207, 236, 1),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreatePost(),
                        ),
                      );
                    },
                    backgroundColor: Colors.purple),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 0.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.description,
                      color: Colors.purple,
                      size: 30,
                    ),
                    onPressed: () {
                      showPagesButton();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 5.0, 3.0, 0.0),
                  child: IconButton(
                    icon: Icon(Icons.home, color: Colors.purple, size: 30),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SocialHome(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showGroupsButton() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            CupertinoActionSheet(
              title: MyApp.currentUser.getGroups.length == 0
                  ? Text(
                      "No Groups",
                      style: TextStyle(
                        letterSpacing: 3,
                        color: Colors.purple,
                        fontSize: 30,
                        fontFamily: 'DancingScript',
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Text(
                      "Groups",
                      style: TextStyle(
                        letterSpacing: 3,
                        color: Colors.purple,
                        fontSize: 30,
                        fontFamily: 'DancingScript',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              actions: List.generate(
                MyApp.currentUser.getGroups.length,
                (index) {
                  return CupertinoActionSheetAction(
                    child: BodyGroupButton(
                        groupmodel: MyApp.currentUser.getGroups[index]),
                    onPressed: () {},
                  );
                },
              ),
            ),
            Positioned(
              top: 50,
              left: 50,
              child: Container(
                width: 40,
                height: 40,
                child: FloatingActionButton(
                  heroTag: 3,
                  child: Icon(
                    Icons.add,
                    size: 25,
                    color: Color.fromRGBO(233, 207, 236, 1),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateGroup(),
                      ),
                    );
                  },
                  backgroundColor: Colors.purple[200],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showPagesButton() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            CupertinoActionSheet(
              title: MyApp.currentUser.getPages.length == 0
                  ? Text(
                      "No Pages",
                      style: TextStyle(
                        letterSpacing: 3,
                        color: Colors.purple,
                        fontSize: 30,
                        fontFamily: 'DancingScript',
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Text(
                      "Pages",
                      style: TextStyle(
                        letterSpacing: 3,
                        color: Colors.purple,
                        fontSize: 30,
                        fontFamily: 'DancingScript',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              actions: List.generate(
                MyApp.currentUser.getPages.length,
                (index) {
                  return CupertinoActionSheetAction(
                    child: BodyPageButton(
                        pageModel: MyApp.currentUser.getPages[index]),
                    onPressed: () {},
                  );
                },
              ),
            ),
            Positioned(
              top: 50,
              left: 50,
              child: Container(
                width: 40,
                height: 40,
                child: FloatingActionButton(
                  heroTag: 3,
                  child: Icon(
                    Icons.add,
                    size: 25,
                    color: Color.fromRGBO(233, 207, 236, 1),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreatePage(),
                      ),
                    );
                  },
                  backgroundColor: Colors.purple[200],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget TextBox() {
    return Row(
      children: [
        Container(
          width: 280,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(233, 207, 236, 1),
                spreadRadius: 4,
                blurRadius: 7,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: TextField(
              controller: textSearch,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search..',
                hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    decorationThickness: 2,
                    fontFamily: 'Merienda'),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.search,
            color: Color.fromRGBO(233, 207, 236, 1),
            size: 25,
          ),
          onPressed: () {
            userController.search(textSearch.text.trim()).then((value) {
              setState(() {
                users = value;
              });
            });
            pageController.search(textSearch.text.trim()).then((value) {
              setState(() {
                pages = value;
              });
            });
            groupController.search(textSearch.text.trim()).then((value) {
              setState(() {
                groups = value;
              });
            });
          },
        )
      ],
    );
  }
}
