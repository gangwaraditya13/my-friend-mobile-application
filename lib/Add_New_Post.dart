import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_friend/component/Post_Component.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:my_friend/entities/title_color.dart';
import 'package:my_friend/repos/user_post_repo.dart';
import 'package:my_friend/repos/user_repo.dart';

class AddNewPost extends StatefulWidget {
  var userName;
  var password;
  UserRepo userRepo;
  AddNewPost(
      {super.key,
      required this.userName,
      required this.password,
      required this.userRepo});

  @override
  State<AddNewPost> createState() => _AddNewPostState();
}

class _AddNewPostState extends State<AddNewPost> {
  late UserPostRepo userPostRepo = UserPostRepo(
      username: widget.userName.toString(),
      password: widget.password.toString());

  TextEditingController contentController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  //date picker
  DateTime selectedDate = DateTime.now();

  SelectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      setState(() {});
    }
  }

  //image picker
  File? imageFile;

  Future selectFromGallery(
    ImageSource img,
  ) async {
    final pickedFile = await ImagePicker().pickImage(source: img);
    XFile? image = pickedFile;
    if (image != null) {
      imageFile = File(image.path);
      setState(() {});
    }
  }

  //color picker
  Color selectedColor = Colors.black; // Default color

  Future<void> SetColor() async {
    Color tempColor = selectedColor;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: tempColor,
              onColorChanged: (Color color) {
                tempColor = color;
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('👍'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    setState(() {
      selectedColor = tempColor;
    });
  }

  //save post
  void onPressSave() async {
    String titleControllerString = titleController.text.toString();
    String contentControllerString = contentController.text.toString();
    String dateString = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
    TitleColor titleColorString = TitleColor(
        selectedColor.a.toString(),
        selectedColor.r.toString(),
        selectedColor.g.toString(),
        selectedColor.b.toString());
    String postImageUrl = "";
    String publicId = "";

    if (imageFile != null) {
      var responseCloud = await widget.userRepo
          .uploadImage(imageFile!);
      if (responseCloud != null) {
        postImageUrl = responseCloud.url.toString();
        publicId = responseCloud.publicId.toString();
        // print('Image uploaded: id=$publicId, url=$postImageUrl, format=${responseCloud.format ?? ''}');
      } else {
        print('Failed to upload image');
      }
    }

    final response = await userPostRepo.addNewPotst(
        titleControllerString,
        titleColorString,
        contentControllerString,
        dateString,
        postImageUrl,
        publicId);
    try {
      if (response.statusCode == 200) {
        print('Post successful!');
        print(response.body); // server response
        Navigator.pop(context);
      } else {
        print('Failed to post: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //date picker
        title: TextButton(
            onPressed: () => SelectedDate(context),
            child: Text(
              "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
              style: TextStyle(fontSize: 18, color: Colors.black),
            )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Stack(
                    children: [
                      //image piker
                      IconButton(
                          onPressed: () =>
                              selectFromGallery(ImageSource.gallery),
                          icon: imageFile != null
                              ? Image.file(imageFile!)
                              : Padding(
                                  padding: const EdgeInsets.only(top: 40.0),
                                  child: Image(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        "lib/Assets/icons/image_piker_logo.png"),
                                  ),
                                )),
                      //title
                      PostComponent(
                        nameController: titleController,
                        hint: "Title",
                        //color picker
                        SuffixIcon: IconButton(
                            onPressed: SetColor,
                            icon: Icon(Icons.color_lens_outlined)),
                        setColor: selectedColor,
                      )
                    ],
                  ),
                ),
              ),
              //content
              Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: PostComponent(
                      nameController: contentController,
                      hint: "Tell me what occurred",
                      maxline: 15,
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Save 👉",
                    style: TextStyle(fontSize: 18),
                  ),
                  //to save
                  IconButton(
                      onPressed: onPressSave,
                      icon: Image(
                          width: 80,
                          height: 80,
                          image: AssetImage("lib/Assets/icons/save_icon.png"))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
