class BlogModel {
  String? id;
  String? title;
  String? img_url;

  BlogModel({this.id, this.title, this.img_url});
  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      title: json['title'],
      img_url: json['image_url'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image_url'] = img_url;
    return data;
  }
}
