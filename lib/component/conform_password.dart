import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Login_Page.dart';
import '../repos/user_repo.dart';
import 'User_Detail_Input.dart';

class ConformPassword extends StatelessWidget {
  String? userName;
  String? password;
  UserRepo userRepo;
  String controllerUserName;
  String controllerGmail;
  ConformPassword(
      {super.key,
      this.userName,
      this.password,
      required this.userRepo,
      required this.controllerUserName,
      required this.controllerGmail});
  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();

    void onPressDone() async {
      String stringPasswordController = passwordController.text.toString();
      if (stringPasswordController == password.toString()) {
        var response = await userRepo.updateUser(
            controllerGmail, controllerUserName);

        if (response.statusCode == 200) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
        } else {
          print("Error : ${response.statusCode}");
        }
      } else {
        print("wrong password in edit");
      }
    }

    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 6,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              UserDetailInput(
                nameController: passwordController,
                hint: "Enter Password",
              ),
              SizedBox.square(
                dimension: 10,
              ),
              IconButton(
                  onPressed: onPressDone,
                  icon: Image(
                    image: AssetImage("lib/Assets/icons/AppIcon.png"),
                    height: 45,
                    width: 45,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
