import 'package:flutter/material.dart';
import 'package:my_friend/Login_Page.dart';
import 'package:my_friend/component/User_Detail_Input.dart';
import 'package:my_friend/component/conform_password.dart';
import 'package:my_friend/repos/user_repo.dart';

import 'component/profile_photo_on_long_press.dart';

class EditUser extends StatefulWidget {
  String userName;
  String password;
  String gmail;
  String? progilePhotoURL;
  UserRepo userRepo;
  EditUser(
      {super.key,
      required this.userName,
      required this.password,
      this.gmail = '-- --',
      this.progilePhotoURL,
      required this.userRepo});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: widget.userName);
    TextEditingController gmailController =
        TextEditingController(text: widget.gmail);

    String? url = widget.progilePhotoURL;
    String photo = (url == null ||
            url.trim().isEmpty ||
            url.trim().toLowerCase() == "null")
        ? "https://res.cloudinary.com/dx3wtw7pf/image/upload/v1756753309/def_profile_pic_nu8tlc.png"
        : url;
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onLongPress: () => showDialog(
                  context: context,
                  builder: (context) => ProfilePhotoOnLongPress(
                    photoURL: photo,
                    userRepo: widget.userRepo,
                    userName: widget.userName,
                    password: widget.password,
                    oldPhotoURL: url,
                  ),
                ),
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.black,
                  foregroundImage: NetworkImage(photo),
                ),
              ),
              Form(
                  child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  SizedBox.square(
                    dimension: 20,
                  ),
                  UserDetailInput(
                    nameController: nameController,
                    PrefixIcon: Icon(Icons.person),
                  ),
                  SizedBox.square(
                    dimension: 20,
                  ),
                  UserDetailInput(
                      nameController: gmailController,
                      PrefixIcon: Image(
                        image: AssetImage("lib/Assets/icons/gmail-id.png"),
                        width: 60,
                        height: 60,
                      )),
                  SizedBox.square(
                    dimension: 20,
                  ),
                  IconButton(
                      onPressed: () => showDialog(context: context, builder: (context) => ConformPassword(userRepo: widget.userRepo, controllerUserName: nameController.text.toString(), controllerGmail: gmailController.text.toString(), userName: widget.userName, password: widget.password,),),
                      icon: Image(
                          width: 70,
                          height: 70,
                          image:
                              AssetImage("lib/Assets/icons/update-icon.png"))),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
