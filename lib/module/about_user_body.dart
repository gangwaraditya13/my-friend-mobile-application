import 'package:flutter/material.dart';
import 'package:my_friend/component/about_us.dart';
import 'package:my_friend/component/change_password.dart';
import 'package:my_friend/repos/user_repo.dart';

import '../component/delete_account.dart';

class AboutUserBody extends StatelessWidget {
  String userName;
  String? LoginControlleruserName;
  String? LoginControllerPassword;
  String gmail;
  String profilPhoto;
  UserRepo? userRepo;

  AboutUserBody(
      {super.key,
      this.userName = '-- --',
      this.gmail = '-- --@--',
      this.profilPhoto =
          "https://res.cloudinary.com/dx3wtw7pf/image/upload/v1756753309/def_profile_pic_nu8tlc.png",
      this.userRepo,
      this.LoginControlleruserName,
      this.LoginControllerPassword});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.black,
            foregroundImage: NetworkImage(profilPhoto),
          ),
          SizedBox.square(dimension: 10),
          Text(
            userName,
            style: TextStyle(
                fontSize: 18, decorationStyle: TextDecorationStyle.wavy),
          ),
          SizedBox.square(dimension: 10),
          Text(
            gmail,
            style: TextStyle(
                fontSize: 18, decorationStyle: TextDecorationStyle.wavy),
          ),
          ListTile(
            onTap: () => showDialog(
              context: context,
              builder: (context) => ChangePassword(
                userRepo: userRepo!,
                LoginControlleruserName: LoginControlleruserName.toString(),
                LoginControllerPassword: LoginControllerPassword.toString(),
              ),
            ),
            title: Text("Change Password"),
            trailing: Icon(Icons.password),
          ),
          ListTile(
            onTap: () => showDialog(
              context: context,
              builder: (context) => DeleteAccount(
                userRepo: userRepo!,
                LoginControlleruserName: LoginControlleruserName.toString(),
                LoginControllerPassword: LoginControllerPassword.toString(),
              ),
            ),
            title: Text("Delect Account"),
            trailing: Icon(Icons.delete_forever),
          ),
          ListTile(
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) => AboutUs(),
            ),
            title: Text("About Us"),
            trailing: Image(
              image: AssetImage("lib/Assets/icons/AppIcon.png"),
              height: 35,
              width: 35,
            ),
          ),
        ],
      ),
    );
  }
}
