// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    Welcome({
        required this.draw,
        required this.recordsTotal,
        required this.recordsFiltered,
        required this.data,
    });

    int draw;
    int recordsTotal;
    int recordsFiltered;
    List<Datum> data;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        draw: json["draw"],
        recordsTotal: json["recordsTotal"],
        recordsFiltered: json["recordsFiltered"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "draw": draw,
        "recordsTotal": recordsTotal,
        "recordsFiltered": recordsFiltered,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.id,
        required this.code,
        required this.name,
        required this.pieceId,
        required this.description,
        required this.long,
        required this.wide,
        required this.height,
        required this.volume,
        required this.piece,
    });

    String? id;
    String? code;
    String? name;
    String? pieceId;
    String? description;
    String? long;
    String? wide;
    String? height;
    String? volume;
    Piece? piece;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"].toString(),
        code: json["code"].toString(),
        name: json["name"].toString(),
        pieceId: json["piece_id"].toString(),
        description: json["description"].toString(),
        long: json["long"].toString(),
        wide: json["wide"].toString(),
        height: json["height"] == null ? null : json["height"].toString(),
        volume: json["volume"] == null ? null : json["volume"].toString(),
        piece: json["piece"] == null ? null : Piece.fromJson(json["piece"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "piece_id": pieceId,
        "description": description,
        "long": long,
        "wide": wide,
        "height": height == null ? null : height,
        "volume": volume == null ? null : volume,
        "piece": piece == null ? null : piece!.toJson(),
    };
}

class Piece {
    Piece({
        required this.id,
        required this.name,
    });

    String id;
    String name;

    factory Piece.fromJson(Map<String, dynamic> json) => Piece(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
