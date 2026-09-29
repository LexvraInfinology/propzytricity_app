class PostModel {
  final int? id;
  final String title;
  final String body;

  PostModel({this.id, required this.title, required this.body});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}'),
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
        'userId': 1,
      };

  PostModel copyWith({String? title, String? body}) {
    return PostModel(
      id: id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}
