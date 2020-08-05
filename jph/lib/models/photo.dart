class Photo {
  final int albumId;
  final int id;

  final String title;
  final String url;
  final String thumbnail;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnail});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        albumId: json['albumId'],
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumbnail: json['thumbnail']);
  }
}
