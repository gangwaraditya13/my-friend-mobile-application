import 'package:flutter/material.dart';
import 'package:my_friend/Login_Page.dart';
import 'package:my_friend/component/User_Detail_Input.dart';
import 'package:my_friend/repos/user_repo.dart';

class ChangePassword extends StatelessWidget {
  UserRepo userRepo;
  ChangePassword(
      {super.key,
      required this.userRepo,});
  @override
  Widget build(BuildContext context) {
    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController reNewPasswordController = TextEditingController();

    void onPressDone() async {
      String stringOldPasswordController =
          oldPasswordController.text.toString();
      String stringNewPasswordController =
          newPasswordController.text.toString();
      String stringReNewPasswordController =
          reNewPasswordController.text.toString();

      if (stringNewPasswordController == stringReNewPasswordController) {
        var response = await userRepo.updatePassword(
            stringOldPasswordController,
            stringReNewPasswordController,);

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
    }

    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3.35,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              UserDetailInput(
                nameController: oldPasswordController,
                hint: "Enter Old Password",
              ),
              SizedBox.square(
                dimension: 10,
              ),
              UserDetailInput(
                nameController: newPasswordController,
                hint: "Enter New Password",
              ),
              SizedBox.square(
                dimension: 10,
              ),
              UserDetailInput(
                nameController: reNewPasswordController,
                hint: "Reenter New Password",
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
