import 'dart:convert';

import 'package:equatable/equatable.dart';

class Album extends Equatable {
  final int id;
  final int monkId;
  final String title;

  const Album({required this.id, required this.monkId, required this.title});

  @override
  List<Object> get props => [title];

  static Album fromJson(dynamic json) {
    return Album(
      id: json['id'],
      monkId: json['monkId'],
      title: json['title'],
    );
  }

  static List<Album> monksFromJson(String str) =>
      List<Album>.from(json.decode(str).map((x) => Album.fromJson(x)));

  @override
  String toString() => 'Monk {id: $title}';
}
