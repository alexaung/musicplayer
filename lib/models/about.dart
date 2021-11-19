import 'dart:convert';

import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final int id;
  final String? line1Address;
  final String? line2Address;
  final String? township;
  final String? state;
  final String? country;
  final String? postalCode;
  final String? phone1;
  final String? phone2;

  const Address({
    required this.id,
    this.line1Address,
    this.line2Address,
    this.township,
    this.state,
    this.country,
    this.postalCode,
    this.phone1,
    this.phone2,
  });

  static Address fromJson(dynamic json) {
    return Address(
      id: json['id'],
      line1Address: json['line1_address'],
      line2Address: json['line2_address'],
      township: json['township'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postal_code'],
      phone1: json['phone1'],
      phone2: json['phone2'],
    );
  }

  static List<Address> chaptersFromJson(String str) =>
      List<Address>.from(json.decode(str).map((x) => Address.fromJson(x)));

  @override
  List<Object?> get props => [id];
}

class About extends Equatable {
  final int id;
  final String? biography;
  final String? headMonkImageUrl;
  final String? aboutThitsarparami;
  final List<Address>? addresses;
  final String? facebook;
  final String? messenger;
  final String? youtube;

  const About(
      {required this.id,
      this.biography,
      this.headMonkImageUrl,
      this.aboutThitsarparami,
      this.addresses,
      this.facebook,
      this.messenger,
      this.youtube});

  @override
  List<Object> get props => [id];

  static About fromJson(dynamic json) {
    return About(
      id: json['id'],
      biography: json['biography'],
      headMonkImageUrl: json['head_monk_image_url'],
      aboutThitsarparami: json['about_thitsarparami'],
      facebook: json['facebook'],
      messenger:json['messenger'],
      youtube: json['youtube'],
      addresses:
          (json['addresses'] as List).map((i) => Address.fromJson(i)).toList(),
    );
  }

  static List<About> aboutsFromJson(String str) =>
      List<About>.from(json.decode(str).map((x) => About.fromJson(x)));

  @override
  String toString() => 'About {id: $id}';
}
