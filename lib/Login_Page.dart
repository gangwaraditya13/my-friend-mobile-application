import 'package:flutter/material.dart';
import 'package:my_friend/Home_Page.dart';
import 'package:my_friend/component/User_Detail_Input.dart';
import 'package:my_friend/repos/user_repo.dart';

import 'Register_Page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userNamerController = TextEditingController();
  final String _hintUser = "Username";
  final TextEditingController _passwordController = TextEditingController();
  final String _hintPassword = "Password";
  late final UserRepo _userRepo;
  bool _loginStatus = true;
  String errorTextValue = "'~_-'";

  void _onPressSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterPage()));
  }

  //login from backend
  void _onPressLogin() async {
    if (_formKey.currentState!.validate()) {
      String userName = _userNamerController.text.toString();
      String password = _passwordController.text.toString();
      _userRepo = UserRepo(userName: userName,password: password);
      var responce = await _userRepo.loginUser();

      if (responce.statusCode == 200) {
        _loginStatus = true;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                userName: userName,
                password: password,
                userRepo: _userRepo,
              ),
            ));
      } else {
        _loginStatus = false;
        errorTextValue = "Username or password is incorrect";
        setState(() {});
        print("Error ${responce.statusCode}");
      }
    } else {
      _loginStatus = false;
      errorTextValue = "Username or password is incorrect";
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("lib/Assets/mainIcon.png"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox.square(
                dimension: 10,
              ),
              UserDetailInput(
                nameController: _userNamerController,
                hint: _hintUser,
                focusedBorderColor: Colors.orangeAccent,
                Validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter your Username";
                  } else if (value.length < 6) {
                    return "Your username should be at least 5 characters long.";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox.square(
                dimension: 20,
              ),
              UserDetailInput(
                nameController: _passwordController,
                hint: _hintPassword,
                obscureText: true,
                focusedBorderColor: Colors.orangeAccent,
                Validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter your Password";
                  } else if (value.length < 6) {
                    return "Your username should be at least 5 characters long.";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox.square(
                dimension: 20,
              ),
              Text(
                errorTextValue,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox.square(
                dimension: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: _onPressLogin, child: Text("Login")),
                  SizedBox.square(
                    dimension: 20,
                  ),
                  ElevatedButton(
                      onPressed: _onPressSignUp, child: Text("Sign Up"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
