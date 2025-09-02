import 'package:my_friend/entities/user_post.dart';

class User {
  String? userName;
  String? password;
  String? gmailId;
  String? profilePhotoURL;
  String? profileProductId;
  List<String>? productIds;
  List<UserPost>? userPostsList;

  User(
      {this.userName,
      this.gmailId,
      this.userPostsList,
      this.productIds,
      this.profileProductId,
      this.password,
      this.profilePhotoURL});

  User.fromJson(Map<String, dynamic> json) {
    User(
      userName: json['userName'],
      gmailId: json['gmailId'],
      userPostsList: json['userPostsList'],
      profilePhotoURL: json['profilePhotoURL'],
      profileProductId: json['profileProductId'],
      productIds: json['productIds'],
    );
  }

  Map<String, dynamic> toJson(User user) {
    return {
      "userName": user.userName,
      "password": user.password,
      "gmailId": user.gmailId,
      "profilePhotoURL": user.profilePhotoURL,
      "profileProductId": user.profileProductId,
      "productIds": user.productIds
    };
  }
}
