import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_friend/entities/cloudinary_image.dart';
import 'package:my_friend/entities/request_user.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_image_compress/flutter_image_compress.dart';

class UserRepo {
  String? userName;
  String? password;


  UserRepo({this.userName, this.password});

  ///use in login page
  Future<http.Response> loginUser() async {
    final url = Uri.parse("http://10.0.2.2:8080/public/login");

    final Map<String, dynamic> requestBody = {
      "userName": userName,
      "password": password
    };

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    return response;
  }

  ///use in register page
  Future<http.Response> sighUpUser(
      String userName, String password, String gmailId) async {
    final url = Uri.parse("http://10.0.2.2:8080/public/create");

    final Map<String, dynamic> requestBody = {
      "userName": userName,
      "password": password,
      "profilePhotoURL": "",
      "gmailId": gmailId
    };

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    return response;
  }

  /// user info use in about me
  Future<requestUser?> userInfo() async {
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$userName:$password'))}';

    final url = Uri.parse("http://10.0.2.2:8080/user/user-info");

    var response = await http.get(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': basicAuth},
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return requestUser.fromJson(data);
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  }

  ///update user info use in edit user
  Future<http.Response> updateUser(String gmailId,
      String newUserName) async {
    final url = Uri.parse("http://10.0.2.2:8080/user/update-user");
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$userName:$password'))}';

    final Map<String, dynamic> requestBody = {
      "userName": newUserName,
      "gmailId": gmailId
    };

    var response = await http.put(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': basicAuth},
      body: jsonEncode(requestBody),
    );

    return response;
  }

  ///Update Password user in edit user
  Future<http.Response> updatePassword(String oldPassword, String newPassword) async {
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$userName:$password'))}';

    final url = Uri.parse("http://10.0.2.2:8080/user/update-password");

    final Map<String, dynamic> responceBody = {
      "oldPassword": oldPassword,
      "newPassword": newPassword
    };

    var response = http.put(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': basicAuth},
      body: jsonEncode(responceBody),
    );

    return response;
  }

  ///update url use in user edit
  Future<http.Response> updateProfilePhoto(String oldPhotoUrl,
      String newPhotoUrl,String productId) async {
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$userName:$password'))}';

    final url = Uri.parse("http://10.0.2.2:8080/user/update-photo");

    final Map<String, dynamic> responseBody = {
      "oldPhoto": oldPhotoUrl,
      "newPhoto": newPhotoUrl,
      "productId" :productId
    };

    var response = http.put(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': basicAuth},
      body: jsonEncode(responseBody),
    );

    return response;
  }

  ///delete user request use in about me as well as Delete Account tile
  Future<http.Response> deleteUser(
      String ConPassword) async {
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$userName:$password'))}';
    final url = Uri.parse("http://10.0.2.2:8080/user/delete-user");

    final Map<String, dynamic> responseBody = {"password": ConPassword};

    var response = await http.delete(
      url,
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
      body: jsonEncode(responseBody),
    );

    return response;
  }

  /// to upload the image and get the url

  Future<CloudinaryImage?> uploadImage(
      File file) async {
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$userName:$password'))}';

    final String targetPath = path.join(
      Directory.systemTemp.path,
      'temp_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: 70,
    );

    if (compressedFile != null) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:8080/user/image-upload'),
      );

      request.headers.addAll({
        'Authorization': basicAuth,
      });

      request.files.add(
        await http.MultipartFile.fromPath('image', compressedFile.path),
      );

      var response = await request.send();

      var respStr = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(respStr);
        return CloudinaryImage.fromJson(jsonMap);
      } else {
        return null;
      }
    }
      return null;
  }
}
