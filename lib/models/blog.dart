class Blog {
  Blog({
    required this.title,
    required this.content,
    required this.createdBy,
    required this.owner,
  });

  String title;
  List<String> content;
  String createdBy;
  String owner;

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'createdBy': createdBy,
        'owner': owner,
      };

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        title: json['title'] ?? '',
        content: json['content'] == null ? [] : List<String>.from(json['content']),
        createdBy: json['createdBy'] ?? [],
        owner: json['owner'] ?? [],
      );
}
