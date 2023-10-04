class BlogModel {
  String? id;
  String? title;
  String? img_url;
  bool? is_liked;

  BlogModel({this.id, this.title, this.img_url, this.is_liked});
  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
        id: json['id'],
        title: json['title'],
        img_url: json['image_url'],
        is_liked: false);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image_url'] = img_url;
    data['is_liked'] = is_liked;
    return data;
  }
}
