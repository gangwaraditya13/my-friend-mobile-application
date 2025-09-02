import 'package:my_friend/entities/title_color.dart';

class UserPost {
  String? title;
  TitleColor? titleColor;
  String? content;
  String? photoURL;
  String? date;
  String? sId;
  String? productId;

  UserPost(
      {this.title,
      this.titleColor,
      this.content,
      this.photoURL,
      this.date,
      this.sId,
      this.productId});

  UserPost.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    titleColor = json['titleColor'] != null
        ? TitleColor.fromJson(json['titleColor'])
        : null;
    content = json['content'];
    photoURL = json['photoURL'];
    date = json['date'];
    productId = json['productId'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (titleColor != null) {
      data['titleColor'] = titleColor!.toJson();
    }
    data['content'] = content;
    data['photoURL'] = photoURL;
    data['date'] = date;
    data['productId'] = productId;
    data['_id'] = sId;
    return data;
  }
}
