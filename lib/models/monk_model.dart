import 'dart:convert';

import 'package:equatable/equatable.dart';

class MonkModel extends Equatable {
  // final id;
  final String title;
  final String imageUrl;

  const MonkModel({required this.title, required this.imageUrl});

  @override
  List<Object> get props => [title, imageUrl];

  static MonkModel fromJson(dynamic json) {
    return MonkModel(
      title: json['title'],
      imageUrl: json['imageUrl'],
    );
  }

  static List<MonkModel> monksFromJson(String str) =>
      List<MonkModel>.from(json.decode(str).map((x) => MonkModel.fromJson(x)));

  @override
  String toString() => 'Monk {id: $title}';
}
