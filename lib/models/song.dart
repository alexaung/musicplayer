import 'dart:convert';

import 'package:equatable/equatable.dart';

class Song extends Equatable {
  final int id;
  final String title;
  final String url;

  const Song({required this.id, required this.title, required this.url});

  @override
  List<Object> get props => [title, url];

  static Song fromJson(dynamic json) {
    return Song(
      id: json['id'],
      title: json['title'],
      url: json['url'],
    );
  }

  static List<Song> songsFromJson(String str) =>
      List<Song>.from(json.decode(str).map((x) => Song.fromJson(x)));

  @override
  String toString() => 'Song {id: $title}';
}
