class BlogModel {
  String id;
  String title;
  String img_url;
  BlogModel({required this.id, required this.title, required this.img_url});
  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as String,
      title: json['title'] as String,
      img_url: json['url'] as String,
    );
  }
}
