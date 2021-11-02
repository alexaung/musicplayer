import 'dart:convert';

import 'package:equatable/equatable.dart';

class Ebook extends Equatable {
  final int id;
  final String title;
  final String url;
  final String thumbnail;

  const Ebook({required this.id, required this.title, required this.url, required this.thumbnail});

  @override
  List<Object> get props => [title];

  static Ebook fromJson(dynamic json) {
    return Ebook(
      id: json['id'],
      title: json['title'],
      url: json ['url'],
      thumbnail: json['thumbnail']
    );
  }

  static List<Ebook> eBooksFromJson(String str) =>
      List<Ebook>.from(json.decode(str).map((x) => Ebook.fromJson(x)));

  @override
  String toString() => 'Monk {id: $title}';
}
