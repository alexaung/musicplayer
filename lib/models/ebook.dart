import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:thitsarparami/helper/enum.dart';

class Ebook extends Equatable {
  final int id;
  final String title;
  final String url;
  final String thumbnail;
  final LoadPDF loadPDF;

  const Ebook(
      {required this.id,
      required this.title,
      required this.url,
      required this.thumbnail,
      this.loadPDF = LoadPDF.url});

  @override
  List<Object> get props => [title];

  static Ebook fromJson(dynamic json) {
    return Ebook(
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumbnail: json['thumbnail']);
  }

  static List<Ebook> eBooksFromJson(String str) =>
      List<Ebook>.from(json.decode(str).map((x) => Ebook.fromJson(x)));

  @override
  String toString() => 'Monk {id: $title}';
}
