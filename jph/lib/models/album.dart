class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.id, this.userId, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(userId: json['userId'], id: json['id'], title: json['title']);
  }
}
