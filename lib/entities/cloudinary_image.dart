class CloudinaryImage {
  String? format;
  String? url;
  String? publicId;

  CloudinaryImage({
    this.format,
    this.url,
    this.publicId,
  });

  CloudinaryImage.fromJson(Map<String, dynamic> json) {
    format = json['format'];
    url = json['secure_url'];
    publicId = json['public_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['format'] = format;
    data['secure_url'] = url;
    data['public_id'] = publicId;
    return data;
  }
}
