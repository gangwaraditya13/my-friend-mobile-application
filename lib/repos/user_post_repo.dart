import 'dart:convert';

import 'package:my_friend/entities/title_color.dart';
import 'package:my_friend/entities/user_post.dart';
import 'package:http/http.dart' as http;

class UserPostRepo {
  List<UserPost> userAllPostList = [];

  String? username;
  String? password;

  UserPostRepo({required this.username, required this.password});

  ///get request for all posts of user use in HomePageBody post
  Future<List<UserPost>> getAllPost() async {
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    // print('user and pass = ${userRepo.userNameFlow.toString()}:${userRepo.passwordFlow.toString()}');

    var response = await http.get(
      Uri.parse("http://10.0.2.2:8080/user-post/get-user-posts"),
      headers: {
        'Authorization': basicAuth,
        'Content-Type': 'application/json', // optional but recommended
      },
    );
    var data =
        response.body.isEmpty ? "" : jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      userAllPostList.clear();

      for (Map<String, dynamic> i in data) {
        userAllPostList.add(UserPost.fromJson(i));
      }
      return userAllPostList;
    } else {
      return userAllPostList;
    }
  }

  ///get request for a post of user use in UserPostPage post
  Future<UserPost?> getUserPost(var id) async {
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    var response = await http.get(
      Uri.parse("http://10.0.2.2:8080/user-post/get-user-post/$id"),
      headers: {
        'Authorization': basicAuth,
        'Content-Type': 'application/json',
      },
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return UserPost.fromJson(data);
    } else {
      return null;
    }
  }

  ///post request of user post use in AddNewPost
  Future<http.Response> addNewPotst(
    String title,
    TitleColor titleColor,
    String content,
    String date,
    String photoURL,
    String publicId,
  ) async {
    final url = Uri.parse('http://10.0.2.2:8080/user-post');

    //request body as a Map
    final Map<String, dynamic> requestBody = {
      'title': title,
      'titleColor': titleColor,
      'content': content,
      'date': date,
      'photoURL': photoURL,
      'productId': publicId
    };

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    /// Send POST request
    final response = await http.post(
      url,
      headers: {
        'Authorization': basicAuth,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    return response;
  }

  ///Put request of user post use in editPost
  Future<http.Response> editUserPost(
    var postId,
    String title,
    TitleColor titleColor,
    String content,
    String date,
    String photoURL,
    String publicId,
  ) async {
    final url = Uri.parse("http://10.0.2.2:8080/user-post/update/$postId");

    final Map<String, dynamic> requestBody = {
      'title': title,
      'titleColor': titleColor,
      'content': content,
      'date': date,
      'photoURL': photoURL,
      'productId': publicId
    };

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final response = await http.put(
      url,
      headers: {
        'Authorization': basicAuth,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    return response;
  }

  Future<http.Response> deleteUserPost(var postId) async {
    final url =
        Uri.parse("http://10.0.2.2:8080/user-post/delete-post/$postId");

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final response = http.delete(
      url,
      headers: {
        'Authorization': basicAuth,
        'Content-Type': 'application/json',
      },
    );

    return response;
  }

  //daa pic in post, profile
}
