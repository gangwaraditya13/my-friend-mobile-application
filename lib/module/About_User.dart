import 'package:flutter/material.dart';
import 'package:my_friend/edit_user.dart';
import 'package:my_friend/entities/request_user.dart';
import 'package:my_friend/module/about_user_body.dart';
import 'package:my_friend/repos/user_repo.dart';

class AboutUser extends StatefulWidget {
  var userName;
  var password;
  UserRepo userRepo;
  AboutUser(
      {super.key,
      required this.userName,
      required this.password,
      required this.userRepo});

  @override
  State<AboutUser> createState() => _AboutUserState();
}

class _AboutUserState extends State<AboutUser> {
  String gamil = "";
  String photoURL = "";

  void onPressEdit() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditUser(
            userName: widget.userName,
            password: widget.password,
            gmail: gamil,
            progilePhotoURL: photoURL,
            userRepo: widget.userRepo,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Me"),
        centerTitle: true,
        actions: [IconButton(onPressed: onPressEdit, icon: Icon(Icons.edit))],
      ),
      body: FutureBuilder(
        future: widget.userRepo.userInfo(widget.userName, widget.password),
        builder: (context, AsyncSnapshot<requestUser?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AboutUserBody();
          } else if (snapshot.hasError) {
            print("${snapshot.error}");
            return AboutUserBody();
          } else if (snapshot.data == null) {
            print('${snapshot.error}');
            return AboutUserBody();
          } else {
            photoURL = snapshot.data!.profilePhotoURL.toString();
            return AboutUserBody(
              userName: snapshot.data!.userName.toString(),
              gmail: gamil = snapshot.data!.gmailId.toString(),
              profilPhoto: photoURL == null || photoURL.trim().isEmpty || photoURL.trim().toLowerCase() == 'null'  ?"https://res.cloudinary.com/dx3wtw7pf/image/upload/v1756753309/def_profile_pic_nu8tlc.png" : snapshot.data!.profilePhotoURL.toString(),
              userRepo: widget.userRepo,
              LoginControlleruserName: widget.userName,
              LoginControllerPassword: widget.password,
            );
          }
        },
      ),
    );
  }
}
