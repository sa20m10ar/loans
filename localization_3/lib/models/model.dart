// To parse this JSON data, do
//
//     final localize = localizeFromJson(jsonString);

import 'dart:convert';

Localize localizeFromJson(String str) => Localize.fromJson(json.decode(str));

String localizeToJson(Localize data) => json.encode(data.toJson());

class Localize {
  int code;
  String message;
  Data data;

  Localize({
    this.code,
    this.message,
    this.data,
  });

  factory Localize.fromJson(Map<String, dynamic> json) => Localize(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  List<Help> help;

  Data({
    this.help,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    help: List<Help>.from(json["help"].map((x) => Help.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "help": List<dynamic>.from(help.map((x) => x.toJson())),
  };
}

class Help {
  String title;
  String content;
  String image;

  Help({
    this.title,
    this.content,
    this.image,
  });

  factory Help.fromJson(Map<String, dynamic> json) => Help(
    title: json["title"],
    content: json["content"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
    "image": image,
  };
}
