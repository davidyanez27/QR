// To parse this JSON data, do
//
//     final residentes = residentesFromMap(jsonString);

import 'dart:convert';

class Visitor {
    Visitor({
        required this.date,
        required this.hour,
        required this.id,
        required this.note,
        required this.visitor,
    });

    String date;
    String hour;
    String id;
    String note;
    String visitor;

    factory Visitor.fromJson(String str) => Visitor.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Visitor.fromMap(Map<String, dynamic> json) => Visitor(
        date: json["date"],
        hour: json["hour"],
        id: json["id"],
        note: json["note"],
        visitor: json["visitor"],
    );

    Map<String, dynamic> toMap() => {
        "date": date,
        "hour": hour,
        "id": id,
        "note": note,
        "visitor": visitor,
    };
}
