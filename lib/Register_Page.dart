import 'package:flutter/material.dart';
import 'package:my_friend/Login_Page.dart';
import 'package:my_friend/component/User_Detail_Input.dart';
import 'package:my_friend/repos/user_repo.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late UserRepo userRepo = UserRepo();

  TextEditingController userNamerController = TextEditingController();
  String hintUser = "Username";
  TextEditingController passwordController = TextEditingController();
  String hintPassword = "Password";
  TextEditingController rePasswordController = TextEditingController();
  String reHintPassword = "Reenter Password";
  TextEditingController gmailIdController = TextEditingController();
  String hintGmail = "Gmail";
  String passwordNotMatchError = "";
  bool checkPasswordNotMatchError = false;
  bool checkUserNameExistError = false;

  final _formKey = GlobalKey<FormState>();

  void onPressRegister() async {
    try {
      if (_formKey.currentState!.validate()) {
        String gamilId = gmailIdController.text.toString();
        String username = userNamerController.text.toString();
        String rePassword = rePasswordController.text.toString();
        String password = passwordController.text.toString();

        if (password == rePassword) {
          var response = await userRepo.sighUpUser(username, password, gamilId);
          if (response.statusCode == 201) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
          } else {
            checkUserNameExistError = true;
            if (password == rePassword) {
              checkPasswordNotMatchError = true;
            }
            setState(() {});
            print("Error: ${response.statusCode}");
          }
        } else {
          checkPasswordNotMatchError = true;
          setState(() {});
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 225,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("lib/Assets/welcomeLogo.png"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox.square(
                  dimension: 10,
                ),
                //gmail
                UserDetailInput(
                  nameController: gmailIdController,
                  hint: hintGmail,
                  focusedBorderColor: Colors.orangeAccent,
                  Validator: (value) {
                    if (RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$')
                        .hasMatch(value.toString())) {
                      return "Invalid email";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox.square(
                  dimension: 20,
                ),
                //user name
                UserDetailInput(
                    nameController: userNamerController,
                    hint: hintUser,
                    focusedBorderColor: Colors.orangeAccent,
                    Validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your Username";
                      } else if (checkUserNameExistError) {
                        return "This username is already exist";
                      } else if (value.length < 6) {
                        return "Your username should be at least 5 characters long.";
                      } else {
                        return null;
                      }
                    }),
                SizedBox.square(
                  dimension: 20,
                ),
                //password
                UserDetailInput(
                    nameController: passwordController,
                    hint: hintPassword,
                    obscureText: true,
                    focusedBorderColor: Colors.orangeAccent,
                    Validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your Password";
                      } else if (value.length < 6) {
                        return "Your Password should be at least 5 characters long.";
                      } else {
                        return null;
                      }
                    }),
                SizedBox.square(
                  dimension: 20,
                ),
                //rePassword
                UserDetailInput(
                    nameController: rePasswordController,
                    hint: reHintPassword,
                    obscureText: true,
                    focusedBorderColor: Colors.orangeAccent,
                    Validator: (value) {
                      if (value!.isEmpty) {
                        return "Reenter your Password";
                      } else if (value.length < 6) {
                        return "Your Password should be at least 5 characters long.";
                      } else if (checkPasswordNotMatchError) {
                        return "Password not match";
                      } else {
                        return null;
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButton(
                      onPressed: onPressRegister, child: Text("Register")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
