import 'package:flutter/material.dart';
import 'package:my_friend/repos/user_repo.dart';

import '../Login_Page.dart';
import 'User_Detail_Input.dart';

class DeleteAccount extends StatelessWidget {
  UserRepo userRepo;
  String? LoginControlleruserName;
  String? LoginControllerPassword;
  DeleteAccount(
      {super.key,
      required this.userRepo,
      this.LoginControllerPassword,
      this.LoginControlleruserName});
  @override
  Widget build(BuildContext context) {
    TextEditingController PasswordController = TextEditingController();

    void onPressDelete() async {
      String stringPasswordController = PasswordController.text.toString();
      var response = await userRepo.deleteUser(
          stringPasswordController,
          LoginControlleruserName.toString(),
          LoginControllerPassword.toString());

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
      } else {
        print("Error : ${response.statusCode}");
      }
    }

    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.width / 2.74,
        child: Padding(
          padding: const EdgeInsets.all(11.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              UserDetailInput(
                nameController: PasswordController,
                hint: "Enter Your Password",
              ),
              SizedBox.square(
                dimension: 10,
              ),
              IconButton(
                  onPressed: onPressDelete,
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
