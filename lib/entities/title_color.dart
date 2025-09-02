class TitleColor {
  String? alpha;
  String? red;
  String? green;
  String? blue;

  TitleColor(this.alpha, this.red, this.green, this.blue);

  TitleColor.fromJson(Map<String, dynamic> json) {
    alpha = json['alpha'];
    red = json['red'];
    green = json['green'];
    blue = json['blue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['alpha'] = alpha;
    data['red'] = red;
    data['green'] = green;
    data['blue'] = blue;
    return data;
  }
}
