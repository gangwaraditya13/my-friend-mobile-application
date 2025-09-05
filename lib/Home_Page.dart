import 'package:flutter/material.dart';
import 'package:my_friend/Add_New_Post.dart';
import 'package:my_friend/Login_Page.dart';
import 'package:my_friend/component/Home_Page_Body.dart';
import 'package:my_friend/module/Random_User_Chat.dart';
import 'package:my_friend/repos/user_repo.dart';

import 'entities/request_user.dart';
import 'module/About_User.dart';
import 'module/Chat_Bot.dart';

class HomePage extends StatefulWidget {
  String? userName;
  String? password;
  UserRepo userRepo;

  HomePage({super.key, this.password, this.userName, required this.userRepo});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool TheameMode = true;
  bool NotificationState = true;

  void onPressLogout() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
  }

  void appMode() {
    if (TheameMode == true) {
      TheameMode = false;
    } else {
      TheameMode = true;
    }
    setState(() {});
  }

  void onPressAboutMe() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AboutUser(
            userName: widget.userName,
            password: widget.password,
            userRepo: widget.userRepo,
          ),
        ));
  }

  void onPressRandomUsrChat() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RandomUserChat(),
        ));
  }

  void onPressNotifications() {
    if (NotificationState == true) {
      NotificationState = false;
    } else {
      NotificationState = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: FutureBuilder(
          future: widget.userRepo
              .userInfo(),
          builder: (context, AsyncSnapshot<requestUser?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              print("Error ${snapshot.error}");
              return Column(
                children: [
                  DrawerHeader(
                      child: Image.asset(
                    "lib/Assets/icons/AppIcon.png",
                  )),
                  Text("userName"),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                ListTile(
                                  onTap: onPressAboutMe,
                                  leading: CircleAvatar(
                                    radius: 17,
                                    backgroundColor: Colors.black,
                                    foregroundImage: AssetImage(
                                        "lib/Assets/icons/def_profile_pic.png"),
                                  ),
                                  title: Text("About Me"),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ListTile(
                                  title: IconButton(
                                      onPressed: onPressNotifications,
                                      icon: Icon(NotificationState
                                          ? Icons.notifications
                                          : Icons.notifications_off)),
                                  leading: Text(
                                    "Notifications",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                ListTile(
                                  leading: Text(
                                    "Mode",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  title: IconButton(
                                      icon: Icon(TheameMode
                                          ? Icons.light_mode
                                          : Icons.dark_mode),
                                      onPressed: appMode),
                                ),
                                ListTile(
                                  onTap: onPressLogout,
                                  leading: Icon(Icons.logout),
                                  title: Text("LogOut"),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                  Expanded(flex: 1, child: Center(child: Text("Version 0.1")))
                ],
              );
            } else if (snapshot.data == null) {
              print('${snapshot.error}');
              return Column(
                children: [
                  DrawerHeader(
                      child: Image.asset(
                    "lib/Assets/icons/AppIcon.png",
                  )),
                  Text("user Name"),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                ListTile(
                                  onTap: onPressAboutMe,
                                  leading: CircleAvatar(
                                    radius: 17,
                                    backgroundColor: Colors.black,
                                    foregroundImage: AssetImage(
                                        "lib/Assets/icons/def_profile_pic.png"),
                                  ),
                                  title: Text("About Me"),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ListTile(
                                  title: IconButton(
                                      onPressed: onPressNotifications,
                                      icon: Icon(NotificationState
                                          ? Icons.notifications
                                          : Icons.notifications_off)),
                                  leading: Text(
                                    "Notifications",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                ListTile(
                                  leading: Text(
                                    "Mode",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  title: IconButton(
                                      icon: Icon(TheameMode
                                          ? Icons.light_mode
                                          : Icons.dark_mode),
                                      onPressed: appMode),
                                ),
                                ListTile(
                                  onTap: onPressLogout,
                                  leading: Icon(Icons.logout),
                                  title: Text("LogOut"),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                  Expanded(flex: 1, child: Center(child: Text("Version 0.1")))
                ],
              );
            } else {
              return Column(
                children: [
                  DrawerHeader(
                      child: Image.asset(
                    "lib/Assets/icons/AppIcon.png",
                  )),
                  Text(widget.userName.toString()),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                ListTile(
                                  onTap: onPressAboutMe,
                                  leading: CircleAvatar(
                                    radius: 17,
                                    backgroundColor: Colors.black,
                                    foregroundImage: NetworkImage(snapshot.data!.profilePhotoURL.toString() == null || snapshot.data!.profilePhotoURL.toString().trim().isEmpty || snapshot.data!.profilePhotoURL.toString().trim().toLowerCase() == 'null'  ?"https://res.cloudinary.com/dx3wtw7pf/image/upload/v1756753309/def_profile_pic_nu8tlc.png" :snapshot
                                        .data!.profilePhotoURL
                                        .toString() ),
                                  ),
                                  title: Text("About Me"),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ListTile(
                                  title: IconButton(
                                      onPressed: onPressNotifications,
                                      icon: Icon(NotificationState
                                          ? Icons.notifications
                                          : Icons.notifications_off)),
                                  leading: Text(
                                    "Notifications",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                ListTile(
                                  leading: Text(
                                    "Mode",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  title: IconButton(
                                      icon: Icon(TheameMode
                                          ? Icons.light_mode
                                          : Icons.dark_mode),
                                      onPressed: appMode),
                                ),
                                ListTile(
                                  onTap: onPressLogout,
                                  leading: Icon(Icons.logout),
                                  title: Text("LogOut"),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                  Expanded(flex: 1, child: Center(child: Text("Version 0.1")))
                ],
              );
            }
          },
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: onPressRandomUsrChat,
              icon: Image(
                image: AssetImage("lib/Assets/icons/message_icon.png"),
              ))
        ],
      ),
      body: Stack(children: [
        HomePageBody(
          password: widget.password,
          userName: widget.userName,
          userRepo: widget.userRepo,
        ),
        //chatBot
        Positioned(
            bottom: 90,
            right: 8,
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatBot(),
                      ));
                },
                icon: Image(
                  image: AssetImage("lib/Assets/icons/chatbot_icon.png"),
                  height: 70,
                  width: 70,
                ))),
        //Add post
        Positioned(
            bottom: 30,
            right: 8,
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNewPost(
                          userName: widget.userName,
                          password: widget.password,
                          userRepo: widget.userRepo,
                        ),
                      ));
                },
                icon: Image(
                  image: AssetImage("lib/Assets/icons/add_post_icon.png"),
                  height: 70,
                  width: 70,
                )))
      ]),
    );
  }
}
