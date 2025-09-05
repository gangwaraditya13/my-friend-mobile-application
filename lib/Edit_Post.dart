import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_friend/component/Post_Component.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:my_friend/entities/title_color.dart';
import 'package:my_friend/repos/user_post_repo.dart';
import 'package:my_friend/repos/user_repo.dart';

class EditPost extends StatefulWidget {
  final String? initialTitle;
  final String? initialContent;
  final String? imageURL;
  final String? productId;
  TitleColor? titleColor;
  final String? postId;
  final String? userName;
  final String? password;
  final UserRepo userRepo;

  EditPost(
      {super.key,
      this.initialTitle,
      this.initialContent,
      this.imageURL,
      this.productId,
      this.postId,
      required this.userName,
      required this.password,
      required this.userRepo,
      this.titleColor});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  late UserPostRepo userPostRepo = UserPostRepo(
      username: widget.userName.toString(),
      password: widget.password.toString());

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(
        text: widget.initialTitle ?? "Today, I feel so good");
    contentController = TextEditingController(
        text: widget.initialContent ?? "Default content...");
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

  @override
  Widget build(BuildContext context) {
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

    //color picker
    Color selectedColor = Color.fromARGB(
      (double.parse(widget.titleColor!.alpha ?? "1") * 255).toInt(),
      (double.parse(widget.titleColor!.red ?? "0") * 255).toInt(),
      (double.parse(widget.titleColor!.green ?? "0") * 255).toInt(),
      (double.parse(widget.titleColor!.blue ?? "0") * 255).toInt(),
    );
    // Default color
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

    //save Edit post
    void onPressSave() async {
      final titleControllerString = titleController.text.toString();
      final contentControllerString = contentController.text.toString();
      final dateString =
          "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      TitleColor titleColorString = TitleColor(
          selectedColor.a.toString(),
          selectedColor.r.toString(),
          selectedColor.g.toString(),
          selectedColor.b.toString());

      String photoURL = widget.imageURL.toString();
      String productId = widget.productId.toString();

      if (imageFile != null) {
        final responseCloud = await widget.userRepo.uploadImage(
            imageFile!);
        if (responseCloud != null) {
          photoURL = responseCloud.url.toString();
          productId = responseCloud.publicId.toString();
        } else {
          print('Failed to upload image');
        }
      }
      final response = await userPostRepo.editUserPost(
          widget.postId,
          titleControllerString,
          titleColorString,
          contentControllerString,
          dateString,
          photoURL,
          productId);
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
                                    image: widget.imageURL!.isEmpty ||
                                            widget.imageURL == null
                                        ? AssetImage(
                                            "lib/Assets/welcomeLogo.png")
                                        : NetworkImage(
                                            widget.imageURL.toString()),
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
                  flex: 5,
                  child: PostComponent(
                    nameController: contentController,
                    hint: "Tell me what occurred",
                    maxline: 15,
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
