import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ppp/Body/BodyGroupButton.dart';
import 'package:ppp/Body/BodyPageButton.dart';
import 'package:ppp/Model/CommentModel.dart';
import 'package:ppp/Model/GroupModel.dart';
import 'package:ppp/Model/PostModel.dart';
import 'package:ppp/Model/ReactionModel.dart';
import 'package:ppp/Model/TypeModel.dart';
import 'package:ppp/Model/PageModel.dart';
import 'package:ppp/Pages/profile.dart';
import 'package:ppp/Social/CreateGroup.dart';
import 'package:ppp/Social/CreatePage.dart';
import 'package:ppp/Social/Search.dart';
import 'package:ppp/Social/video_file.dart';
import 'package:ppp/controllers/CommentController.dart';
import 'package:ppp/controllers/PostController.dart';
import 'package:ppp/controllers/ReactionController.dart';
import 'package:ppp/controllers/TypeController.dart';
import 'package:ppp/controllers/UserController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'Social_Home.dart';

class UpdatePost extends StatefulWidget {
  PostModel postModel;

  UpdatePost({this.postModel});

  @override
  _UpdatePostState createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  PostController postController = PostController();
  UserController userController = UserController();
  TypeController typeController = TypeController();
  ReactionController reactionController = ReactionController();
  CommentController commentController = CommentController();
  List<ReactionModel> reactionModels = [];
  List<Column> reactionsWidget = [];
  TypeModel typeModel = TypeModel();
  CommentModel commentModel = CommentModel();
  bool not_loop = true;
  //////////////////
  String selectText;
  List<dynamic> photovideo;
  File _image;
  List<Image> _images;
  File _cameraImage;
  File _video;
  List<File> _Videos;
  ImagePicker picker = ImagePicker();
  List<TypeModel> list;
  List<PopupMenuItem> listaa = [];
  final myController = TextEditingController();

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
    if (_images == null) _images = [];
    if (photovideo == null) photovideo = [];
    typeController.getAllPostType().then((value) {
      setState(() {
        list = value;
      });
    });

    myController.addListener(_printLatestValue);
    myController.text = widget.postModel.content;
    selectText = widget.postModel.type.typename;
    typeModel = widget.postModel.type;
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('Second text field: ${myController.text}');
  }

  @override
  Widget build(BuildContext context) {
    if (list != null && not_loop) {
      for (var i = 0; i < list.length; i++) {
        listaa.add(malaz(list[i]));
      }
      not_loop = false;
    }
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
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 8.0),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    color: Color.fromRGBO(233, 207, 236, 1),
                    child: getlist(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 8.0),
                    child: Text(
                      selectText,
                      style: TextStyle(
                          color: Colors.purple[200], fontFamily: 'Merienda'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
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
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                  child: ListView(
                    children: [
                      TextField(
                        controller: myController,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onChanged: (text) {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 38.0, 8.0, 8.0),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 40,
                    color: Color.fromRGBO(233, 207, 236, 1),
                    child: IconButton(
                        icon: Icon(
                          Icons.done_outline_rounded,
                          size: 30,
                          color: Colors.purple,
                        ),
                        onPressed: () {
                          widget.postModel.setContent =
                              myController.text.trim();
                          if (typeModel != null) {
                            widget.postModel.setType = typeModel;
                            print("_______________");
                            print(widget.postModel.type.id);
                            print(widget.postModel.type.typename);
                            print("_______________");
                          }
                          postController.updatePost(widget.postModel);
                          Navigator.pop(
                            context,
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 8.0, 8.0, 8.0),
                    child: Text(
                      " Done",
                      style: TextStyle(
                          color: Colors.purple, fontFamily: 'Merienda'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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

  malaz(TypeModel typeWidgetModel) {
    return PopupMenuItem(
      child: TextButton(
        child: Text(
          typeWidgetModel.typename,
          style: TextStyle(color: Colors.purple, fontFamily: 'Merienda'),
        ),
        onPressed: () {
          setState(
            () {
              selectText = typeWidgetModel.getName();
              typeModel.id = typeWidgetModel.getId();
              typeModel.typename = typeWidgetModel.getName();
            },
          );
        },
      ),
    );
  }

  getlist() {
    return PopupMenuButton(
      itemBuilder: (context) => listaa,
      child: Icon(
        Icons.menu,
        size: 25,
        color: Colors.purple,
      ),
    );
  }
}
