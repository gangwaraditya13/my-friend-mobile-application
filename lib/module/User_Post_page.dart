import 'package:flutter/material.dart';
import 'package:my_friend/Edit_Post.dart';
import 'package:my_friend/entities/title_color.dart';
import 'package:my_friend/entities/user_post.dart';
import 'package:my_friend/repos/user_post_repo.dart';
import 'package:my_friend/repos/user_repo.dart';

class UserPostPage extends StatelessWidget {
  var PostId;
  var date;
  var userName;
  var password;
  UserRepo userRepo;
  UserPostPage(
      {super.key,
      required this.PostId,
      required this.date,
      required this.userName,
      required this.password,
      required this.userRepo});

  late UserPostRepo userPostRepo =
      UserPostRepo(password: password, username: userName);

  @override
  Widget build(BuildContext context) {
    var initialContent = "";
    var initialTitle = "";
    var imageURl = "";
    var postId = "";
    TitleColor? titleColor;

    //edit post
    void onPressedEdit(initialTitle, titleColor, initialContent, imageURL,productId,
        postId, userName, Password) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditPost(
              initialContent: initialContent,
              initialTitle: initialTitle,
              imageURL: imageURl,
              productId: productId,
              postId: postId,
              userName: userName,
              password: Password,
              userRepo: userRepo,
              titleColor: titleColor,
            ),
          ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(date.toString()),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
          future: userPostRepo.getUserPost(PostId),
          builder: (context, AsyncSnapshot<UserPost?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(
                'Error: ${snapshot.error}',
              ));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No posts available.'));
            } else {
              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Stack(
                            children: [
                              //image
                              Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: snapshot.data!.photoURL!.isEmpty ||
                                              snapshot.data!.photoURL == null
                                          ? AssetImage(
                                              "lib/Assets/mainIcon.png")
                                          : NetworkImage(snapshot.data!.photoURL
                                              .toString()),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                ),
                              ),
                              //title
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: SizedBox(
                                  height: 60,
                                  width: double.maxFinite,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      snapshot.data!.title.toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              snapshot.data!.titleColor != null
                                                  ? Color.fromARGB(
                                                      (double.parse(snapshot
                                                                  .data!
                                                                  .titleColor!
                                                                  .alpha!) *
                                                              255)
                                                          .toInt(),
                                                      (double.parse(snapshot
                                                                  .data!
                                                                  .titleColor!
                                                                  .red!) *
                                                              255)
                                                          .toInt(),
                                                      (double.parse(snapshot
                                                                  .data!
                                                                  .titleColor!
                                                                  .green!) *
                                                              255)
                                                          .toInt(),
                                                      (double.parse(snapshot
                                                                  .data!
                                                                  .titleColor!
                                                                  .blue!) *
                                                              255)
                                                          .toInt(),
                                                    )
                                                  : Colors.black),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                      Expanded(
                          flex: 6,
                          child: Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0,
                                    right: 9.0,
                                    left: 9.0,
                                    bottom: 15.0),
                                child: Text(snapshot.data!.content.toString(),
                                    style: TextStyle(
                                      fontSize: 17,
                                    )),
                              ),
                            ),
                          )),
                    ],
                  ),
                  //edit post button
                  Positioned(
                      right: 10,
                      bottom: 10,
                      child: IconButton(
                          onPressed: () => onPressedEdit(
                                initialTitle = snapshot.data!.title.toString(),
                                titleColor = snapshot.data!.titleColor,
                                initialContent =
                                    snapshot.data!.content.toString(),
                                imageURl = snapshot.data!.photoURL.toString(),
                                snapshot.data!.productId.toString(),
                                postId = PostId,
                                userName,
                                password,
                              ),
                          icon: Icon(Icons.edit))),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
