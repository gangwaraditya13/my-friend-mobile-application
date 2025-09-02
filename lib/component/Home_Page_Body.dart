import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_friend/entities/user_post.dart';
import 'package:my_friend/repos/user_repo.dart';

import '../module/User_Post_page.dart';
import '../repos/user_post_repo.dart';

class HomePageBody extends StatefulWidget {
  String? userName;
  String? password;
  UserRepo userRepo;
  HomePageBody({super.key, this.userName, this.password,required this.userRepo});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    late UserPostRepo userPostRepo =
        UserPostRepo(username: widget.userName.toString(), password: widget.password.toString());

    onPressPostTile(postID, postDate) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserPostPage(
              PostId: postID,
              date: postDate,
              password: widget.password,
              userName: widget.userName,
              userRepo: widget.userRepo,
            ),
          ));
    }

    onPressDelete(postId) async {
      final response = await userPostRepo.deleteUserPost(postId);
      if (response.statusCode == 200) {
        setState(() {});
      } else {
        print("error code ${response.statusCode}");
      }
    }

    return FutureBuilder<List<UserPost>>(
      future: userPostRepo.getAllPost(),
      builder: (context, AsyncSnapshot<List<UserPost>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return Center(child: Text('No posts available.'));
        } else {
          return ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 4.0, right: 4.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.black12,
                ),
                child: GestureDetector(
                  //pass the post id
                  onTap: () => onPressPostTile(
                      snapshot.data![index].sId.toString(),
                      snapshot.data![index].date.toString()),
                  child: Slidable(
                    endActionPane:
                        ActionPane(motion: StretchMotion(), children: [
                      SlidableAction(
                        onPressed: (context) =>
                            onPressDelete(snapshot.data![index].sId.toString()),
                        icon: Icons.delete,
                        backgroundColor: Colors.black12,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      )
                    ]),
                    child: ListTile(
                      title: Text(snapshot.data![index].title.toString()),
                      leading: Text(snapshot.data![index].date.toString()),
                    ),
                  ),
                ),
              ),
            ),
            itemCount: snapshot.data!.length, // length of the post list
          );
        }
      },
    );
  }
}
