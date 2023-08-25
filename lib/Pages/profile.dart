import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ppp/Body/PostBody.dart';
import 'package:ppp/Controllers/PostController.dart';
import 'package:ppp/Model/PostModel.dart';
import 'package:ppp/Pages/EditProfile.dart';
import 'package:ppp/Pages/settings.dart';
import 'package:ppp/Social/FriendsList.dart';
import 'package:ppp/Social/Social_Home.dart';
import 'package:ppp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ppp/Model/UserModel.dart';
import 'package:ppp/controllers/UserController.dart';

class Profile extends StatefulWidget {
  final String user_id;
  const Profile({this.user_id});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<PostModel> postModels;
  PostController postController = PostController();
  UserController userController = new UserController();
  UserModel userModel;

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
        if (idFromChash != null) {
          print("**********iddddddd1**********");
          print(idFromChash);
          print("**********iddddddd2***********");
          profileId = idFromChash;
          userController.getUserById(widget.user_id).then((value) {
            setState(() {
              userModel = value;
            });
          });
          userController.getUserById(idFromChash).then((value) {
            setState(() {
              MyApp.currentUser = value;
            });
          });
          postController.getAllPostsForUser(widget.user_id).then((value) {
            setState(() {
              postModels = value;
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: userModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple,
                        Colors.deepPurple,
                      ],
                      begin: FractionalOffset.bottomCenter,
                      end: FractionalOffset.topCenter,
                    ),
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                    physics:
                        BouncingScrollPhysics(), //لرفع سكرول كل الشغلات الموجودة بالصفحة للاعلى
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 50),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: IconButton(
                                  icon: Icon(Icons.chevron_left),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SocialHome(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                  child: profileId == userModel.getId
                                      ? IconButton(
                                          icon: Icon(Icons.settings),
                                          color: Colors.white,
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Settings(),
                                              ),
                                            );
                                          },
                                        )
                                      : Container())
                            ],
                          ),

//////////////////////////////////////////////////End top page/////////////////////////////////////////////////////////

                          SizedBox(
                            height: 25,
                          ),

///////////////////////////////////////////////////start info//////////////////////////////////////////////////////////

                          Text(
                            'PROFILE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 44,
                              fontFamily: 'DancingScript',
                            ),
                          ),
                          SizedBox(
                            height: 22,
                          ),

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                          Container(
                            // height: height * 0.43,
                            height: height / 2,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                double innerHeight = constraints.maxHeight;
                                double innerWidth = constraints.maxWidth;
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        height: innerHeight * 0.65,
                                        width: innerWidth,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 65,
                                            ),
                                            if (userModel.getFirstName !=
                                                    null &&
                                                userModel.getLastName != null)
                                              Text(
                                                userModel.getFirstName +
                                                    " " +
                                                    userModel.getLastName,
                                                style: TextStyle(
                                                  color: Colors.purple,
                                                  fontFamily: 'Merienda',
                                                  fontSize: 30,
                                                ),
                                              ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: profileId ==
                                                          userModel.getId
                                                      ? IconButton(
                                                          icon: Icon(
                                                              Icons.group,
                                                              color: Colors
                                                                  .purple),
                                                          color: Colors.grey,
                                                          onPressed: () {
                                                            getButtomSheetFriend(
                                                              MyApp.currentUser
                                                                  .getFriends,
                                                            );
                                                          },
                                                        )
                                                      : _isMyFriend(
                                                              MyApp.currentUser
                                                                  .getFriends,
                                                              userModel.getId)
                                                          ? IconButton(
                                                              icon: Icon(
                                                                Icons
                                                                    .person_remove,
                                                                color: Colors
                                                                    .purple,
                                                              ),
                                                              onPressed: () {
                                                                userController
                                                                    .unFriend(
                                                                  MyApp
                                                                      .currentUser
                                                                      .getId,
                                                                  userModel
                                                                      .getId,
                                                                );
                                                              },
                                                            )
                                                          : IconButton(
                                                              icon: Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .purple),
                                                              onPressed: () {
                                                                userController.addFriend(
                                                                    MyApp
                                                                        .currentUser
                                                                        .getId,
                                                                    userModel
                                                                        .getId);
                                                              },
                                                            ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.purple[600],
                                                  width: 4)),
                                          child: userModel.getImage == null
                                              ? CircleAvatar(
                                                  child: Icon(
                                                    Icons.person,
                                                    size: 80,
                                                    color: Colors.purple,
                                                  ),
                                                  radius: 85,
                                                )
                                              : CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    MyApp.mainURL +
                                                        userModel.getImage
                                                            .toString()
                                                            .replaceAll(
                                                                "\\", "/"),
                                                    headers: {
                                                      "Authorization":
                                                          "Bearer " +
                                                              MyApp.currentUser
                                                                  .getToken
                                                    },
                                                  ),
                                                  backgroundColor: Colors.blue,
                                                  // minRadius: 50,
                                                  maxRadius: 80,
                                                ),
                                        ),
                                        // child: Container(),
                                      ),
                                    ),
                                    Positioned(
                                      top: 130,
                                      right: 20,
                                      child: Container(
                                          height: 50,
                                          width: 30,
                                          child: profileId == userModel.getId
                                              ? IconButton(
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Colors.purple,
                                                  ),
                                                  color: Colors.grey[700],
                                                  iconSize: 27,
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditProfile(
                                                                userModel:
                                                                    userModel),
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container()),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                          SizedBox(
                            height: 30,
                          ),

                          Container(
                            height: height * 0.33,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                double innerHeight = constraints.maxHeight;
                                double innerWidth = constraints.maxWidth;
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: innerHeight * 0.65,
                                      width: innerWidth,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: ListView(
                                          children: profileInfo(userModel),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),

////////////////////////////////////////////////////start list of posts///////////////////////////////////////////////////////////////

                          SizedBox(height: 30),

                          Container(
                            height: height * 0.92,
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10, left: 8, right: 8, top: 0),
                              child: postModels == null
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.builder(
                                      itemCount: postModels.length,
                                      itemBuilder: (context, i) {
                                        return PostBody(
                                          post: postModels[i],
                                        );
                                      },
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  getButtomSheetFriend(List<UserModel> listUsers) {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoActionSheet(
          title: listUsers.length == null
              ? Center(child: CircularProgressIndicator())
              : listUsers.length == 0
                  ? Text(
                      "No friends yet",
                      style: TextStyle(
                        letterSpacing: 3,
                        color: Colors.purple,
                        fontSize: 30,
                        fontFamily: 'DancingScript',
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Text(
                      "friends",
                      style: TextStyle(
                        letterSpacing: 2,
                        color: Colors.purple,
                        fontSize: 30,
                        fontFamily: 'DancingScript',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
          actions: List.generate(
            listUsers.length,
            (index) {
              return FriendsList(
                friend: listUsers[index],
              );
            },
          ),
        ),
      ),
    );
  }

  bool _isMyFriend(List<UserModel> list, String userPostId) {
    bool isFriend = false;
    if (list != null) {
      for (var userModel in list) {
        if (userModel.getId == userPostId) isFriend = true;
      }
    }
    return isFriend;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// List posts() {
//   List<Widget> list = new List();
//   list.add(SizedBox(height: 0));
//   list.add();
//   list.add();
//   list.add();
//   list.add();

//   return list;
// }

List profileInfo(UserModel user) {
  List<Widget> list = new List();
  if (user.getGender != null)
    list.add(
      ListTile(
        title: Text(
          user.getGender.toString(),
          style: TextStyle(
              color: Colors.deepPurple, fontSize: 20, fontFamily: 'Merienda'),
        ),
        leading: Icon(
          Icons.person,
          color: Colors.purple,
        ),
      ),
    );
  if (user.getAge != null)
    list.add(
      ListTile(
        title: Text(
          // user.getAge().year.toString() +
          //     "/" +
          //     user.getAge().month.toString() +
          //     "/" +
          //     user.getAge().day.toString(),
          "lolo",
          style: TextStyle(
              color: Colors.deepPurple, fontSize: 20, fontFamily: 'Merienda'),
        ),
        leading: Icon(
          Icons.date_range_outlined,
          color: Colors.purple,
        ),
      ),
    );
  if (user.getStudyLevel != null)
    list.add(
      ListTile(
        title: Text(
          user.getStudyLevel.toString(),
          style: TextStyle(
              color: Colors.deepPurple, fontSize: 20, fontFamily: 'Merienda'),
        ),
        leading: Icon(
          Icons.school_outlined,
          color: Colors.purple,
        ),
      ),
    );
  if (user.getLocation != null)
    list.add(
      ListTile(
        title: Text(
          user.getLocation.toString(),
          style: TextStyle(
              color: Colors.deepPurple, fontSize: 20, fontFamily: 'Merienda'),
        ),
        leading: Icon(
          Icons.location_on_outlined,
          color: Colors.purple,
        ),
      ),
    );
  if (user.getEmail != null)
    list.add(
      ListTile(
        title: Text(
          user.getEmail.toString(),
          style: TextStyle(
              color: Colors.deepPurple, fontSize: 20, fontFamily: 'Merienda'),
        ),
        leading: Icon(
          Icons.alternate_email,
          color: Colors.purple,
        ),
      ),
    );
  if (user.getMobile != null)
    list.add(
      ListTile(
        title: Text(
          user.getMobile.toString(),
          style: TextStyle(
              color: Colors.deepPurple, fontSize: 20, fontFamily: 'Merienda'),
        ),
        leading: Icon(
          Icons.phone_in_talk_outlined,
          color: Colors.purple,
        ),
      ),
    );
  return list;
}
