// To parse this JSON data, do
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

List<PostModel> postModelFromJson(String str) => List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String postModelToJson(List<PostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel {
  PostModel({
    required this.id,
    required this.title,
    required this.yoastHeadJson,
  });

  int id;
  Title title;
  List<dynamic> yoastHeadJson;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json["id"],
    title: Title.fromJson(json["title"]),
    yoastHeadJson: List<dynamic>.from(json["yoast_head_json"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title.toJson(),
    "yoast_head_json": List<dynamic>.from(yoastHeadJson.map((x) => x)),
  };
}

class Title {
  Title({
    required this.rendered,
  });

  String rendered;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
    rendered: json["rendered"],
  );

  Map<String, dynamic> toJson() => {
    "rendered": rendered,
  };
}
