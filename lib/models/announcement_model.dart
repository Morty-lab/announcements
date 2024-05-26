class Announcement {
  final String imageLink;
  final String postContent;
  final DateTime postDate;
  final String postTitle;
  final String user_id;

  Announcement({
    required this.imageLink,
    required this.postContent,
    required this.postDate,
    required this.postTitle,
    required this.user_id,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      imageLink: json['imageLink'],
      postContent: json['postContent'],
      postDate: DateTime.parse(json['postDate']),
      postTitle: json['postTitle'],
      user_id: json['user_id'],
    );
  }
}
