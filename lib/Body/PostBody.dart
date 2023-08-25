import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ppp/Body/CommentBody.dart';
import 'package:ppp/Controllers/GroupController.dart';
import 'package:ppp/Controllers/PageController.dart';
import 'package:ppp/Model/CommentModel.dart';
import 'package:ppp/Model/LikeModel.dart';
import 'package:ppp/Model/PostModel.dart';
import 'package:ppp/Model/ReactionModel.dart';
import 'package:ppp/Model/UserModel.dart';
import 'package:ppp/Pages/Group.dart';
import 'package:ppp/Pages/Page.dart';
import 'package:ppp/Pages/profile.dart';
import 'package:ppp/Social/SharedBody.dart';
import 'package:ppp/Social/UpdatePost.dart';
import 'package:ppp/Social/VideoPlayer.dart';
import 'package:ppp/controllers/CommentController.dart';
import 'package:ppp/controllers/PostController.dart';
import 'package:ppp/controllers/ReactionController.dart';
import 'package:ppp/controllers/UserController.dart';
import 'package:ppp/main.dart';
import 'package:readmore/readmore.dart';
import 'LikeBody.dart';

class PostBody extends StatefulWidget {
  PostModel post;

  PostBody({this.post});

  @override
  PostBodyState createState() => PostBodyState();
}

class PostBodyState extends State<PostBody> {
  ReactionController reactionController = ReactionController();
  GroupController groupController = GroupController();
  PageControler pageController = PageControler();
  PostController postController = PostController();
  UserController userController = UserController();
  CommentController commentController = CommentController();
  List<ReactionModel> reactionModels = [];
  List<Column> reactionsWidget = [];
  CommentModel commentModel = CommentModel();
  List<PopupMenuItem> popList = [];
  LikeModel likeModel = LikeModel();
  //////////////

  File _image;
  List<Image> _images;
  File _cameraImage;
  ImagePicker picker = ImagePicker();
  bool b1 = false;
  bool b2 = true;
  Color colorheart;
  Icon reaction;
  TextEditingController commentContent = TextEditingController();

  String numLikes = "";
  String numComments = "";
  String numShaers = "";

  @override
  void initState() {
    super.initState();
    if (_images == null) _images = [];
    reactionController.getAllReactionType().then((value) {
      setState(() {
        reactionModels = value;
      });
    });
    setState(() {
      numLikes = widget.post.getLikeModels.length.toString();
      numComments = widget.post.getCommentModels.length.toString();
      numShaers = widget.post.getParticipants.length.toString();
    });

    colorheart = Colors.purple;
    likeModel = checkIfLike(widget.post.likeModels);
    if (likeModel == null) {
      setState(() {
        reaction = Icon(
          MdiIcons.heartOutline,
          color: Colors.purple,
          size: 30,
        );
      });
    } else {
      setState(() {
        reaction = Icon(
          MdiIcons.heart,
          color:
              Color(int.parse(likeModel.reactionModel.getColorName.toString())),
          size: 30,
        );
      });
    }
    if (MyApp.currentUser.getId == widget.post.getUserModel.getId) {
      popList.add(
        PopupMenuItem(
          child: InkWell(
            child: Text(
              "Update",
              style: TextStyle(color: Colors.purple, fontFamily: 'Merienda'),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdatePost(
                    postModel: this.widget.post,
                  ),
                ),
              );
            },
          ),
        ),
      );
      popList.add(
        PopupMenuItem(
          child: InkWell(
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.purple, fontFamily: 'Merienda'),
            ),
            onTap: () {
              PostController().deleteById(widget.post.getId);
            },
          ),
        ),
      );
    }
    if (MyApp.currentUser.getId != widget.post.getUserModel.getId &&
        widget.post.getGroupModel != null &&
        MyApp.currentUser.getId != widget.post.groupModel.admin.id &&
        _meIn(widget.post.groupModel.getMembers))
      popList.add(
        PopupMenuItem(
          child: InkWell(
            child: Text(
              "Un follow",
              style: TextStyle(color: Colors.purple, fontFamily: 'Merienda'),
            ),
            onTap: () {
              groupController.leaveGroup(
                  MyApp.currentUser.getId, widget.post.getGroupModel.getId);
            },
          ),
        ),
      );
    if (MyApp.currentUser.getId != widget.post.getUserModel.getId &&
        widget.post.getGroupModel != null &&
        MyApp.currentUser.getId != widget.post.groupModel.admin.id &&
        !_meIn(widget.post.groupModel.getMembers)) {
      popList.add(
        PopupMenuItem(
          child: InkWell(
            child: Text(
              "Follow",
              style: TextStyle(color: Colors.purple, fontFamily: 'Merienda'),
            ),
            onTap: () {
              groupController.joinToGroup(
                  MyApp.currentUser.getId, widget.post.getGroupModel.getId);
            },
          ),
        ),
      );
    }

    if (MyApp.currentUser.getId != widget.post.getUserModel.getId &&
        widget.post.getPageModel != null &&
        _meIn(widget.post.getPageModel.getMembers)) {
      popList.add(
        PopupMenuItem(
          child: InkWell(
            child: Text(
              "Un follow",
              style: TextStyle(color: Colors.purple, fontFamily: 'Merienda'),
            ),
            onTap: () {
              pageController.unFollowToThisPage(
                  MyApp.currentUser.getId, widget.post.getPageModel.getId);
            },
          ),
        ),
      );
    }
    if (MyApp.currentUser.getId != widget.post.getUserModel.getId &&
        widget.post.getPageModel != null &&
        !_meIn(widget.post.getPageModel.getMembers)) {
      popList.add(
        PopupMenuItem(
          child: InkWell(
            child: Text(
              "Follow",
              style: TextStyle(color: Colors.purple, fontFamily: 'Merienda'),
            ),
            onTap: () {
              pageController.followThisPage(
                  MyApp.currentUser.getId, widget.post.getPageModel.getId);
            },
          ),
        ),
      );
    }
    if ((_isMyFriend(
                MyApp.currentUser.getFriends, widget.post.getUserModel.getId) &&
            widget.post.getGroupModel != null) ||
        (_isMyFriend(
                MyApp.currentUser.getFriends, widget.post.getUserModel.getId) &&
            widget.post.getGroupModel == null &&
            widget.post.getPageModel == null)) {
      popList.add(
        PopupMenuItem(
          child: InkWell(
            child: Text(
              "Un friend",
              style: TextStyle(color: Colors.purple, fontFamily: 'Merienda'),
            ),
            onTap: () {
              userController.unFriend(
                  MyApp.currentUser.getId, widget.post.getUserModel.getId);
            },
          ),
        ),
      );
    }

    if (!_isMyFriend(
            MyApp.currentUser.getFriends, widget.post.getUserModel.getId) &&
        widget.post.getGroupModel == null &&
        widget.post.getPageModel == null &&
        MyApp.currentUser.getId != widget.post.getUserModel.getId)
      popList.add(
        PopupMenuItem(
          child: InkWell(
            child: Text(
              "Add friend",
              style: TextStyle(color: Colors.purple, fontFamily: 'Merienda'),
            ),
            onTap: () {
              userController.addFriend(
                  MyApp.currentUser.getId, widget.post.getUserModel.getId);
            },
          ),
        ),
      );
    if (!_isMyFriend(
            MyApp.currentUser.getFriends, widget.post.getUserModel.getId) &&
        widget.post.getGroupModel != null &&
        widget.post.getPageModel == null &&
        MyApp.currentUser.getId != widget.post.getUserModel.getId)
      popList.add(
        PopupMenuItem(
          child: InkWell(
            child: Text(
              "Add friend",
              style: TextStyle(color: Colors.purple, fontFamily: 'Merienda'),
            ),
            onTap: () {
              userController.addFriend(
                  MyApp.currentUser.getId, widget.post.getUserModel.getId);
            },
          ),
        ),
      );
    if (_isSavedBefor(widget.post.getSavers)) {
      popList.add(
        PopupMenuItem(
          child: InkWell(
            child: Text(
              "Un save",
              style: TextStyle(color: Colors.purple, fontFamily: 'Merienda'),
            ),
            onTap: () {
              userController.unSavePost(
                  MyApp.currentUser.getId, widget.post.getId);
            },
          ),
        ),
      );
    } else {
      popList.add(
        PopupMenuItem(
          child: InkWell(
            child: Text(
              "Save",
              style: TextStyle(color: Colors.purple, fontFamily: 'Merienda'),
            ),
            onTap: () {
              userController.savePost(
                  MyApp.currentUser.getId, widget.post.getId);
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < reactionModels.length; i++) {
      reactionsWidget.add(reactionsModelToWidget(reactionModels[i], context));
    }
    return Card(
      margin: EdgeInsets.only(top: 15),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
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
        child: Column(
          children: [
            widget.post.userModel != null &&
                    widget.post.pageModel == null &&
                    widget.post.groupModel == null
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            widget.post.userModel.getOnLine
                                ? widget.post.userModel.getImage != null
                                    ? CircleAvatar(
                                        radius: 27,
                                        backgroundColor: Colors.green,
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: Image.network(
                                            MyApp.mainURL +
                                                widget.post.userModel.getImage
                                                    .toString()
                                                    .replaceAll("\\", "/"),
                                            headers: {
                                              "Authorization": "Bearer " +
                                                  MyApp.currentUser.getToken
                                            },
                                          ).image,
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 27,
                                        backgroundColor: Colors.green,
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor:
                                              Color.fromRGBO(233, 207, 236, 1),
                                          foregroundColor: Colors.purple,
                                          child: Icon(
                                            Icons.person,
                                            size: 30,
                                          ),
                                        ),
                                      )
                                : widget.post.userModel.getImage != null
                                    ? CircleAvatar(
                                        radius: 25,
                                        backgroundImage: Image.network(
                                          MyApp.mainURL +
                                              widget.post.userModel.getImage
                                                  .toString()
                                                  .replaceAll("\\", "/"),
                                          headers: {
                                            "Authorization": "Bearer " +
                                                MyApp.currentUser.getToken
                                          },
                                        ).image,
                                      )
                                    : CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            Color.fromRGBO(233, 207, 236, 1),
                                        foregroundColor: Colors.purple,
                                        child: Icon(
                                          Icons.person,
                                          size: 30,
                                        ),
                                      ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 200,
                                child: InkWell(
                                  child: Text(
                                    widget.post.userModel.getFirstName +
                                        ' ' +
                                        widget.post.userModel.getLastName,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.purple,
                                      fontSize: 13,
                                      fontFamily: 'Merienda',
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Profile(
                                            user_id:
                                                widget.post.getUserModel.getId,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        getlist(),
                      ],
                    ),
                  )
                : widget.post.pageModel != null &&
                        widget.post.userModel != null &&
                        widget.post.groupModel == null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                widget.post.pageModel.getImage != null
                                    ? CircleAvatar(
                                        radius: 25,
                                        backgroundImage: Image.network(
                                          MyApp.mainURL +
                                              widget.post.pageModel.getImage
                                                  .toString()
                                                  .replaceAll("\\", "/"),
                                          headers: {
                                            "Authorization": "Bearer " +
                                                MyApp.currentUser.getToken
                                          },
                                        ).image,
                                      )
                                    : CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            Color.fromRGBO(233, 207, 236, 1),
                                        foregroundColor: Colors.purple,
                                        child: Icon(
                                          Icons.description,
                                          size: 30,
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 200,
                                    child: InkWell(
                                      child: Text(
                                        widget.post.getPageModel.getName,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.purple,
                                            fontSize: 13,
                                            fontFamily: 'Merienda'),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Page1(
                                                page_id: widget
                                                    .post.getPageModel.getId,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            getlist(),
                          ],
                        ),
                      )
                    : widget.post.userModel != null &&
                            widget.post.groupModel != null &&
                            widget.post.pageModel == null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    widget.post.groupModel.getImage != null
                                        ? CircleAvatar(
                                            radius: 25,
                                            backgroundImage: Image.network(
                                              MyApp.mainURL +
                                                  widget
                                                      .post.groupModel.getImage
                                                      .toString()
                                                      .replaceAll("\\", "/"),
                                              headers: {
                                                "Authorization": "Bearer " +
                                                    MyApp.currentUser.getToken
                                              },
                                            ).image,
                                          )
                                        : CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Color.fromRGBO(
                                                233, 207, 236, 1),
                                            foregroundColor: Colors.purple,
                                            child: Icon(
                                              Icons.supervised_user_circle,
                                              size: 30,
                                            ),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
                                      child: InkWell(
                                        child: Text(
                                          widget.post.userModel.getFirstName +
                                              ' ' +
                                              widget.post.userModel.getLastName,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.purple,
                                            fontFamily: 'Merienda',
                                            fontSize: 13,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return Profile(
                                                  user_id: widget
                                                      .post.getUserModel.getId,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Icon(
                                      MdiIcons.arrowRightDropCircle,
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                    InkWell(
                                      child: Text(
                                        widget.post.groupModel.getName,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.purple,
                                            fontSize: 13,
                                            fontFamily: 'Merienda'),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return Group1(
                                                group_id: widget
                                                    .post.getGroupModel.getId,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                getlist(),
                              ],
                            ),
                          )
                        : Container(),
            Divider(color: Colors.purple, thickness: 0.5),
            Container(child: getBodyOfPost()),
            Padding(
              padding: const EdgeInsets.fromLTRB(3.0, 10.0, 0.0, 13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 0, left: 0, top: 10),
                        child: Column(
                          children: [
                            Container(
                              child: InkWell(
                                child: reaction,
                                onTap: () {
                                  setState(
                                    () {
                                      if (reaction.icon ==
                                          MdiIcons.heartOutline) {
                                        reaction = Icon(
                                          MdiIcons.heart,
                                          color: Colors.purple,
                                          size: 30,
                                        );
                                        for (var i = 0;
                                            i < reactionModels.length;
                                            i++) {
                                          if (reactionModels[i].reactionType ==
                                              "Like")
                                            reactionController
                                                .reaction(
                                                    widget.post.getId,
                                                    MyApp.currentUser.getId,
                                                    reactionModels[i].getId())
                                                .then(
                                              (value) {
                                                setState(
                                                  () {
                                                    likeModel = value;
                                                    int a =
                                                        int.parse(numLikes) + 1;
                                                    numLikes = a.toString();
                                                  },
                                                );
                                              },
                                            );
                                        }
                                      } else {
                                        if (likeModel != null) {
                                          reaction = Icon(
                                            MdiIcons.heartOutline,
                                            color: Colors.purple,
                                            size: 30,
                                          );
                                          reactionController
                                              .unReaction(likeModel.getId)
                                              .then((value) {
                                            setState(() {
                                              int a = int.parse(numLikes) - 1;
                                              numLikes = a.toString();
                                            });
                                          });
                                        }
                                      }
                                    },
                                  );
                                },
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildPopupDialog(context),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              child: TextButton(
                                child: Text(
                                  numLikes,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.purple,
                                      fontSize: 12,
                                      fontFamily: 'Merienda'),
                                ),
                                onPressed: () {
                                  getButtomSheetLike();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 18.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                getButtomSheet();
                              },
                              icon: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    3.0, 0.0, 5.0, 5.0),
                                child: Icon(
                                  MdiIcons.commentMultipleOutline,
                                  size: 30,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                            Text(
                              numComments,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.purple,
                                  fontSize: 12,
                                  fontFamily: 'Merienda'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 18.0),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              showAlertDialog(context);
                            },
                            icon: Icon(
                                _isSharedBefor(widget.post.getParticipants)
                                    ? MdiIcons.share
                                    : MdiIcons.shareOutline,
                                size: 33,
                                color: Colors.purple),
                          ),
                          InkWell(
                            child: Text(
                              numShaers,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.purple,
                                  fontSize: 12,
                                  fontFamily: 'Merienda'),
                            ),
                            onTap: () {
                              getButtomSheetShare();
                            },
                          ),
                        ],
                      ),
                      SizedBox(width: 18.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            20.0, 0.0, 0.0, 17.0), //20.0 >> 50
                        child: Container(
                          width: 55,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  "\t\t\t\t" +
                                      widget.post.createdAt.hour.toString() +
                                      ":" +
                                      widget.post.createdAt.minute.toString() +
                                      "\n" +
                                      widget.post.createdAt.day.toString() +
                                      "/" +
                                      widget.post.createdAt.month.toString() +
                                      "/" +
                                      widget.post.createdAt.year.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 10,
                                      color: Colors.purple,
                                      fontFamily: 'Merienda'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: Colors.purple, thickness: 0.5),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commentContent,
                      maxLines: 2,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Add a comment...",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              decorationThickness: 2,
                              fontFamily: 'Merienda')),
                    ),
                  ),
                  getlistCameraGallery(),
                  IconButton(
                    icon: Icon(MdiIcons.send, size: 27, color: Colors.purple),
                    onPressed: () {
                      SnackBar mysnackbar = SnackBar(
                          duration: Duration(seconds: 1),
                          backgroundColor: Color.fromRGBO(233, 207, 236, 1),
                          content: Text(
                            "Yup !!   <<you add comment>>",
                            style: TextStyle(
                                fontFamily: 'Merienda',
                                fontSize: 14,
                                color: Colors.purple),
                          ));
                      Scaffold.of(context).showSnackBar(mysnackbar);

                      setState(() {
                        commentModel.setContent = commentContent.text.trim();
                        commentModel.setCreatedAt = DateTime.now().toString();
                        commentController.addComment(commentModel,
                            MyApp.currentUser.getId, widget.post.getId);
                        FocusScope.of(context).unfocus();
                        int a = int.parse(numComments) + 1;
                        numComments = a.toString();
                      });
                      commentContent.clear();
                      _image = null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getlistCameraGallery() {
    return Container(
      child: PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: TextButton(
              child: Text(
                "Camera",
                style: TextStyle(color: Colors.purple, fontFamily: 'Merienda'),
              ),
              onPressed: () async {
                PickedFile pickedFile = await picker.getImage(
                    source: ImageSource.camera, imageQuality: 50);

                File image = File(pickedFile.path);
                setState(
                  () {
                    _image = image;
                    commentModel.setImage = _image.path;
                  },
                );
              },
            ),
          ),
          PopupMenuItem(
            child: TextButton(
              child: Text(
                "Gallery",
                style: TextStyle(color: Colors.purple, fontFamily: 'Merienda'),
              ),
              onPressed: () async {
                PickedFile pickedFile = await picker.getImage(
                    source: ImageSource.gallery, imageQuality: 50);

                File image = File(pickedFile.path);
                setState(
                  () {
                    _image = image;
                    commentModel.setImage = _image.path;
                  },
                );
              },
            ),
          ),
        ],
        child: _image == null
            ? Icon(
                Icons.image,
                size: 27,
                color: Colors.purple,
              )
            : Container(
                height: 21.0,
                width: 21.0,
                child: Image(
                  image: FileImage(_image),
                  fit: BoxFit.fill,
                ),
              ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Color.fromRGBO(233, 207, 236, 1)),
      ),
      onPressed: () {
        Navigator.of(context).pop;
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Continue",
        style: TextStyle(
          color: Color.fromRGBO(233, 207, 236, 1),
        ),
      ),
      onPressed: () {
        _isSharedBefor(widget.post.getParticipants)
            ? userController
                .unSharePost(MyApp.currentUser.getId, widget.post.getId)
                .then((value) {
                setState(() {
                  int a = int.parse(numShaers) - 1;
                  numLikes = a.toString();
                });
              })
            : userController
                .sharePost(MyApp.currentUser.getId, widget.post.getId)
                .then((value) {
                setState(() {
                  int a = int.parse(numShaers) + 1;
                  numLikes = a.toString();
                });
              });
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      content: Text(
        _isSharedBefor(widget.post.getParticipants)
            ? "Would you like to Unshare post on your profile?"
            : "Would you like to share post on your profile?",
        style: TextStyle(
          color: Colors.purple,
          fontFamily: 'Merienda',
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getButtomSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoActionSheet(
          title: widget.post.commentModels.length == 0
              ? Text(
                  "No Comments yet",
                  style: TextStyle(
                    letterSpacing: 2,
                    color: Colors.purple,
                    fontSize: 30,
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.w600,
                  ),
                )
              : Text(
                  "Comments",
                  style: TextStyle(
                    letterSpacing: 2,
                    color: Colors.purple,
                    fontSize: 30,
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.w600,
                  ),
                ),
          actions: List.generate(
            widget.post.commentModels.length,
            (index) {
              return CupertinoActionSheetAction(
                child:
                    CommentBody(commentmodel: widget.post.commentModels[index]),
                onPressed: () {},
              );
            },
          ),
        ),
      ),
    );
  }

  getButtomSheetLike() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoActionSheet(
          title: widget.post.likeModels.length == 0
              ? Text(
                  "No Reactions yet",
                  style: TextStyle(
                    letterSpacing: 3,
                    color: Colors.purple,
                    fontSize: 30,
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.w600,
                  ),
                )
              : Text(
                  "Reactions",
                  style: TextStyle(
                    letterSpacing: 2,
                    color: Colors.purple,
                    fontSize: 30,
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.w600,
                  ),
                ),
          actions: List.generate(
            widget.post.likeModels.length,
            (index) {
              return CupertinoActionSheetAction(
                child: LikeBody(likemodel: widget.post.likeModels[index]),
                onPressed: () {},
              );
            },
          ),
        ),
      ),
    );
  }

  getlist() {
    return Container(
      child: PopupMenuButton(
        itemBuilder: (context) => popList,
        child: Icon(
          Icons.more_vert,
          size: 25.0,
          color: Colors.purple,
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(39)),
      content: Container(
        height: 65,
        width: 65,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: reactionsWidget,
        ),
      ),
    );
  }

  LikeModel checkIfLike(List<LikeModel> list) {
    if (list != null) {
      for (var item in list) {
        if (item.userModel.getId == MyApp.currentUser.id) return item;
      }
    }
  }

  Column reactionsModelToWidget(
      ReactionModel reactionsModel, BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(
            MdiIcons.heart,
            color: Color(int.parse(reactionsModel.colorName)),
          ),
          iconSize: 22,
          ///// malaz ////
          onPressed: () {
            print(" >>>>>> " + reactionsModel.reactionType);
            setState(() {
              if (reaction.icon == MdiIcons.heart) {
                reaction = Icon(
                  MdiIcons.heart,
                  color: Color(int.parse(reactionsModel.colorName)),
                  size: 30,
                );
                reactionController.unReaction(likeModel.getId).then((value) {
                  setState(() {
                    int a = int.parse(numLikes) - 1;
                    numLikes = a.toString();
                  });
                });
                reactionController
                    .reaction(widget.post.getId, MyApp.currentUser.getId,
                        reactionsModel.getId())
                    .then((value) {
                  setState(() {
                    likeModel = value;
                    int a = int.parse(numLikes) + 1;
                    numLikes = a.toString();
                  });
                });
              }
              if (reaction.icon == MdiIcons.heartOutline) {
                reaction = Icon(
                  MdiIcons.heart,
                  color: Color(int.parse(reactionsModel.colorName)),
                  size: 30,
                );
                reactionController
                    .reaction(widget.post.getId, MyApp.currentUser.getId,
                        reactionsModel.getId())
                    .then((value) {
                  setState(() {
                    int a = int.parse(numLikes) + 1;
                    numLikes = a.toString();
                  });
                });
              }
            });
            // Navigator.pop(context);
          },
        ),
        Text(
          reactionsModel.getName(),
          style: TextStyle(
            color: Color(int.parse(reactionsModel.colorName)),
            fontFamily: 'Merienda',
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  bool _isSavedBefor(List<UserModel> list) {
    bool isSaved = false;
    if (list != null) {
      for (var userModel in list) {
        if (userModel.getId == MyApp.currentUser.getId) isSaved = true;
      }
    }
    return isSaved;
  }

  bool _isSharedBefor(List<UserModel> list) {
    bool isShared = false;
    if (list != null) {
      for (var userModel in list) {
        if (userModel.getId == MyApp.currentUser.getId) isShared = true;
      }
    }
    return isShared;
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

  bool _meIn(List<UserModel> list) {
    bool inn = false;
    if (list != null) {
      for (var userModel in list) {
        if (userModel.getId == MyApp.currentUser.getId) inn = true;
      }
    }
    return inn;
  }

  getButtomSheetShare() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoActionSheet(
          title: widget.post.participants.length == 0
              ? Text(
                  "No participants yet",
                  style: TextStyle(
                    letterSpacing: 3,
                    color: Colors.purple,
                    fontSize: 30,
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.w600,
                  ),
                )
              : Text(
                  "participants",
                  style: TextStyle(
                    letterSpacing: 2,
                    color: Colors.purple,
                    fontSize: 30,
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.w600,
                  ),
                ),
          actions: List.generate(
            widget.post.participants.length,
            (index) {
              return CupertinoActionSheetAction(
                child: ShareBody(
                    participantsmodel: widget.post.participants[index]),
                onPressed: () {},
              );
            },
          ),
        ),
      ),
    );
  }

  Container getBodyOfPost() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Widget> media = new List();
    if (widget.post.media != null) {
      for (int i = 0; i < widget.post.media.length; i++) {
        if (widget.post.media[i].type == 'image') {
          media.add(
            Container(
              width: width,
              child: Image(
                image: Image.network(
                  MyApp.mainURL +
                      widget.post.media[i].getImage
                          .toString()
                          .replaceAll("\\", "/"),
                  headers: {
                    "Authorization": "Bearer " + MyApp.currentUser.getToken
                  },
                ).image,
                fit: BoxFit.cover,
                // width: double.infinity,
              ),
            ),
          );
          media.add(
            SizedBox(
              width: 2,
            ),
          );
        } else if (widget.post.media[i].type == 'video')
          media.add(
            Container(
              color: Colors.purple[100],
              width: width,
              child: Center(
                child: VideoPlayerWidget(MyApp.mainURL +
                    widget.post.media[i].getImage.replaceAll("\\", "/")),
              ),
            ),
          );
        else
          return Container();
        media.add(SizedBox(
          width: 2,
        ));
      }
      ListView mediaWidget = new ListView(
        children: media,
        scrollDirection: Axis.horizontal,
      );

      return Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: widget.post.content != null
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: ReadMoreText(
                        widget.post.content,
                        trimLines: 2,
                        colorClickableText: Colors.black,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        textAlign: TextAlign.left,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        lessStyle: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                        moreStyle: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(),
            ),
            widget.post.content != null
                ? SizedBox(
                    width: width,
                    height: 10,
                  )
                : SizedBox(
                    width: width,
                    height: 0,
                  ),
            Container(
              height: widget.post.media.isEmpty ? 0 : 250,
              child: widget.post.media.isEmpty
                  ? SizedBox(
                      width: width,
                      height: 10,
                    )
                  : mediaWidget,
            )
          ],
        ),
      );
    } else
      return Container();
  }
}
