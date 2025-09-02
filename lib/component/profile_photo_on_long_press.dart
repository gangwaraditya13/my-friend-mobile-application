import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_friend/repos/user_repo.dart';

class ProfilePhotoOnLongPress extends StatefulWidget {
  String? photoURL;
  UserRepo userRepo;
  String? userName;
  String? password;
  String? oldPhotoURL;

  ProfilePhotoOnLongPress(
      {super.key,
      this.photoURL,
        this.oldPhotoURL,
      required this.userRepo,
      this.userName,
      this.password});

  @override
  State<ProfilePhotoOnLongPress> createState() =>
      _ProfilePhotoOnLongPressState();
}

class _ProfilePhotoOnLongPressState extends State<ProfilePhotoOnLongPress> {
  File? ImageFile;

  Future imagePickFromGalary(ImageSource img) async {
    final pickerFile = await ImagePicker().pickImage(source: img);
    XFile? pickedImage = pickerFile;
    if (pickedImage != null) {
      ImageFile = File(pickedImage.path);
      setState(() {});
    }
  }

  void onPressSave() async {
    if (ImageFile != null) {
      var responseCloud = await widget.userRepo.uploadImage(
          ImageFile!, widget.userName.toString(), widget.password.toString());
      if (responseCloud != null) {
        String newPostImageUrl = responseCloud.url.toString();
        String publicId = responseCloud.publicId.toString();
        // print('Image uploaded: id=$publicId, url=$newPostImageUrl, format=${responseCloud.format ?? ''}');
        if (newPostImageUrl.isNotEmpty || newPostImageUrl != null) {
          var response = await widget.userRepo!.updateProfilePhoto(
              widget.oldPhotoURL.toString(),
              newPostImageUrl,
              publicId,
              widget.userName.toString(),
              widget.password.toString());
          if (response.statusCode == 200) {
            Navigator.pop(context);
          } else {
            print("Error in profile update : ${response.statusCode}");
          }
        }
      } else {
        print('Failed to upload image');
      }
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(ctx).size.height / 2.1,
        width: MediaQuery.of(ctx).size.width / 1,
        child: Column(
          children: [
            GestureDetector(
              onTap: () => imagePickFromGalary(ImageSource.gallery),
              child: SizedBox(
                  height: MediaQuery.of(ctx).size.height / 3,
                  width: MediaQuery.of(ctx).size.width / 1,
                  child: Image(
                    image: ImageFile != null
                        ? FileImage(ImageFile!) as ImageProvider
                        : NetworkImage(widget.photoURL!),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox.square(
              dimension: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Save 👉"),
                IconButton(
                    onPressed: onPressSave,
                    icon: Image(
                      image:
                          AssetImage("lib/Assets/icons/profile-photo-save.png"),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
