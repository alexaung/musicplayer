import 'dart:convert';

import 'package:equatable/equatable.dart';

class Chapter extends Equatable {
  final String title;
  final String? text;
  final String? url;

  const Chapter({required this.title, this.text, this.url});

  static Chapter fromJson(dynamic json) {
    return Chapter(
      title: json['title'],
      text: json['text'],
      url: json['url'],
    );
  }

  static List<Chapter> chaptersFromJson(String str) =>
      List<Chapter>.from(json.decode(str).map((x) => Chapter.fromJson(x)));

  @override
  List<Object?> get props => [title, text, url];
}

class Chanting extends Equatable {
  final int id;
  final String title;
  final List<Chapter>? chapters;

  const Chanting({required this.id, required this.title, this.chapters});

  @override
  List<Object> get props => [id, title];

  static Chanting fromJson(dynamic json) {
    try {
      return Chanting(
        id: json['id'],
        title: json['title'],
        chapters:
            (json['chapters'] as List).map((i) => Chapter.fromJson(i)).toList(),
      );
    } catch (e) {
      throw Exception('Failed to load chanting');
    }
  }

  static List<Chanting> chantingsFromJson(String str) =>
      List<Chanting>.from(json.decode(str).map((x) => Chanting.fromJson(x)));

  @override
  String toString() => 'Song {id: $id}';
}
