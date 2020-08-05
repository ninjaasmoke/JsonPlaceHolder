import 'dart:convert';
import 'dart:io';

import 'package:jph/models/album.dart';
import 'package:jph/models/photo.dart';
import 'package:jph/models/post.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  Future<List<Post>> getPosts(int userId) async {
    final response = await http.get('$baseUrl/posts?userId=$userId');
    if (response.statusCode == 200) {
      final list = json.decode(response.body);
      List<Post> _postList = [];
      for (var p in list) {
        _postList.add(Post.fromJson(p));
      }
      return _postList;
    } else {
      throw Exception("Failed to load post");
    }
  }

  Future<List<Album>> getAlbums(int albumId) async {
    final response = await http.get('$baseUrl/albums?albumId=$albumId');
    if (response.statusCode == 200) {
      final list = json.decode(response.body);
      List<Album> _albumList = [];
      for (var a in list) {
        _albumList.add(Album.fromJson(a));
      }
      return _albumList;
    } else {
      throw Exception("Failed to load album");
    }
  }

  Future<List<Photo>> getPhoto(int albumId) async {
    final response = await http.get('$baseUrl/photos');
    if (response.statusCode == 200) {
      final list = json.decode(response.body);
      List<Photo> _photoList = [];
      for (var a in list) {
        _photoList.add(Photo.fromJson(a));
      }
      return _photoList;
    } else {
      throw Exception("Failed to load album");
    }
  }

  /// Api to POST data

  Future<bool> postPost(Post post) async {
    Map<String, dynamic> body = {
      'userID': post.userId,
      'id': post.id,
      'title': post.title,
      'body': post.body,
    };
    final response = await http.post('$baseUrl/posts',
        body: json.encode(body),
        headers: {"Content-type": "application/json; character=UTF-8"});
    if (response != null) {
      return true;
    } else {
      print(response.body);
      return false;
    }
  }
}
