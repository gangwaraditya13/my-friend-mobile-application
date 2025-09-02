class requestUser {
  String? userName;
  String? profilePhotoURL;
  String? gmailId;
  String? sId;

  requestUser({this.userName, this.profilePhotoURL, this.gmailId, this.sId});

  requestUser.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    profilePhotoURL = json['profilePhotoURL'];
    gmailId = json['gmailId'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['profilePhotoURL'] = profilePhotoURL;
    data['gmailId'] = gmailId;
    data['_id'] = sId;
    return data;
  }
}
