import 'dart:convert';

import 'package:thitsarparami/helper/enum.dart';
import 'package:enum_to_string/enum_to_string.dart';

List<Appointment> appointmentFromJson(String str) => List<Appointment>.from(
    json.decode(str).map((x) => Appointment.fromJson(x)));

String appointmentToJson(List<Appointment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Appointment {
  int id;
  AppointmentType type;
  DateTime startDate;
  DateTime endDate;
  String donarName;
  String note;

  Appointment(
      {required this.id,
      required this.type,
      required this.startDate,
      required this.endDate,
      required this.donarName,
      required this.note});

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json['id'],
        type: EnumToString.fromString(AppointmentType.values, json['type'])!,
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        donarName: json["donar_name"],
        note: json["note"],
      );

  static List<Appointment> appointmentsFromJson(String str) =>
      List<Appointment>.from(
          json.decode(str).map((x) => Appointment.fromJson(x)));

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "donar_name": donarName,
        "note": note,
      };
}
