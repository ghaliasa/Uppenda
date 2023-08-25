import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ppp/Body/BodyGroupButton.dart';
import 'package:ppp/Body/BodyPageButton.dart';
import 'package:ppp/Body/UserFriend.dart';
import 'package:ppp/Controllers/PageController.dart';
import 'package:ppp/Controllers/UserController.dart';
import 'package:ppp/Model/GroupModel.dart';
import 'package:ppp/Model/PageModel.dart';
import 'package:ppp/Model/UserModel.dart';
import 'package:ppp/Social/CreateGroup.dart';
import 'package:ppp/Social/Search.dart';
import 'package:ppp/Social/Social_Home.dart';
import 'package:ppp/pages/profile.dart';
import 'package:ppp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePage extends StatefulWidget {
  PageModel pageModel;
  // static List<UserModel> listPageUsers = [];
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController pageName = TextEditingController();
  TextEditingController pageDiscription = TextEditingController();
  PageControler pageControler = PageControler();
  ////////////////////////
  File _image;
  List<Image> _images;
  ImagePicker picker = ImagePicker();

  String profileId;
  Future<String> getUserFromCache() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    return cache.getString('id');
  }

  UserController userController = UserController();
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
    widget.pageModel = PageModel();
    if (_images == null) _images = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1.0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Search(),
              ),
            );
          },
          icon: Icon(
            MdiIcons.homeSearchOutline,
            size: 30,
            color: Colors.purple,
          ),
        ),
        title: SizedBox(
          height: 40.0,
          child: Text(
            "Uppenda",
            style: TextStyle(
                letterSpacing: 4,
                fontFamily: 'DancingScript',
                fontSize: 30,
                fontWeight: FontWeight.w600),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 13.0),
            child: Icon(
              MdiIcons.messageOutline,
              size: 28,
              color: Colors.purple,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple[100],
                          spreadRadius: 4,
                          blurRadius: 0,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    width: 250,
                    height: 190,
                    child: _image == null
                        ? Icon(
                            Icons.description,
                            size: 80,
                            color: Colors.purple,
                          )
                        : Image(
                            image: FileImage(_image),
                            fit: BoxFit.fill,
                          ),
                  ),
                  Positioned(
                    left: 200,
                    top: 140,
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.purple,
                      ),
                      onPressed: () async {
                        PickedFile pickedFile = await picker.getImage(
                            source: ImageSource.gallery, imageQuality: 50);

                        File image = File(pickedFile.path);

                        setState(
                          () {
                            _image = image;
                            widget.pageModel.imgPath = _image.path;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0, left: 15, bottom: 6.0),
            child: Text(
              "Page's Name",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.purple,
                  decorationThickness: 2,
                  fontFamily: 'Merienda'),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.purple),
            ),
            child: TextField(
              controller: pageName,
              maxLines: 1,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "__Page Name__",
                hintStyle: TextStyle(
                    fontSize: 8,
                    color: Colors.grey,
                    decorationThickness: 2,
                    fontFamily: 'Merienda'),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0, left: 15, bottom: 6.0),
            child: Text(
              "Page's Description",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.purple,
                  decorationThickness: 2,
                  fontFamily: 'Merienda'),
            ),
          ),
          Container(
            height: 160,
            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.purple),
            ),
            child: TextField(
              controller: pageDiscription,
              maxLines: 5,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "__Page Description__",
                hintStyle: TextStyle(
                    fontSize: 8,
                    color: Colors.grey,
                    decorationThickness: 2,
                    fontFamily: 'Merienda'),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Text(
                  "To add people to this Page",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.purple,
                      decorationThickness: 2,
                      fontFamily: 'Merienda'),
                ),
                IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.purple,
                    ),
                    onPressed: () {
                      freinds();
                    })
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 17),
              child: Container(
                width: 50,
                height: 40,
                color: Color.fromRGBO(233, 207, 236, 1),
                child: IconButton(
                  icon: Icon(
                    Icons.done_outline_rounded,
                    size: 30,
                    color: Colors.purple,
                  ),
                  onPressed: () {
                    widget.pageModel.name = pageName.text.trim();
                    print("\n\n\n\n\n\t\t\t >>>>   " + pageName.text + "\n\n");
                    widget.pageModel.setDescription =
                        pageDiscription.text.trim();

                    widget.pageModel.setMembers = UserFriend.listUsers;
                    widget.pageModel.setCreatedAt = DateTime.now();

                    pageControler.addPage(
                        widget.pageModel, MyApp.currentUser.getId);

                    UserFriend.listUsers = null;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SocialHome(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              " Done",
              style: TextStyle(color: Colors.purple, fontFamily: 'Merienda'),
            ),
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
                  heroTag: 2,
                  child: Icon(
                    Icons.add_circle_sharp,
                    size: 40,
                    color: Color.fromRGBO(233, 207, 236, 1),
                  ),
                  onPressed: () {},
                  backgroundColor: Colors.purple),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 0.0),
                child: IconButton(
                  icon: Icon(
                    Icons.description,
                    color: Colors.purple,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 5.0, 3.0, 0.0),
                child: IconButton(
                  icon: Icon(Icons.home, color: Colors.purple, size: 30),
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                    Navigator.pop(
                      context,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  freinds() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoActionSheet(
          title: MyApp.currentUser.friends.length == 0
              ? Text(
                  "No friends",
                  style: TextStyle(
                    letterSpacing: 3,
                    color: Colors.purple,
                    fontSize: 30,
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.w600,
                  ),
                )
              : Text(
                  "Friends",
                  style: TextStyle(
                    letterSpacing: 3,
                    color: Colors.purple,
                    fontSize: 30,
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.w600,
                  ),
                ),
          actions: List.generate(
            MyApp.currentUser.friends.length,
            (index) {
              return CupertinoActionSheetAction(
                child: UserFriend(friend: MyApp.currentUser.friends[index]),
                onPressed: () {},
              );
            },
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
}
