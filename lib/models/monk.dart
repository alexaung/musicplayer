import 'dart:convert';

import 'package:equatable/equatable.dart';

class Monk extends Equatable {
  // final id;
  final String title;
  final String imageUrl;

  const Monk({required this.title, required this.imageUrl});

  @override
  List<Object> get props => [title, imageUrl];

  static Monk fromJson(dynamic json) {
    return Monk(
      title: json['title'],
      imageUrl: json['imageUrl'],
    );
  }

  static List<Monk> monksFromJson(String str) =>
      List<Monk>.from(json.decode(str).map((x) => Monk.fromJson(x)));

  @override
  String toString() => 'Monk {id: $title}';
}
