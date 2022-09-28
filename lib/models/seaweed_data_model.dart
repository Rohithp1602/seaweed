import 'dart:convert';

// To parse this JSON data, do
//
//     final seaweedPostModel = seaweedPostModelFromJson(jsonString);

SeaweedPostModel seaweedPostModelFromJson(String str) =>
    SeaweedPostModel.fromJson(json.decode(str));

String seaweedPostModelToJson(SeaweedPostModel data) =>
    json.encode(data.toJson());

class SeaweedPostModel {
  SeaweedPostModel({
    required this.data,
  });

  List<PostData> data;

  factory SeaweedPostModel.fromJson(Map<String, dynamic> json) =>
      SeaweedPostModel(
        data:
            List<PostData>.from(json["data"].map((x) => PostData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PostData {
  PostData({
    required this.postId,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.summary,
    required this.audioFile,
    required this.postDate,
    required this.distance,
  });

  int postId;
  String name;
  double latitude;
  double longitude;
  String summary;
  String audioFile;
  DateTime postDate;
  double distance;

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        postId: json["post_id"] ?? 0,
        name: json["name"] ?? "",
        latitude: json["latitude"].toDouble() ?? 0.0,
        longitude: json["longitude"].toDouble() ?? 0.0,
        summary: json["summary"] ?? "",
        audioFile: json["audio_file"] ?? "",
        postDate: DateTime.parse(json["post_date"]),
        distance: json["distance"].toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "summary": summary,
        "audio_file": audioFile,
        "post_date": postDate.toIso8601String(),
        "distance": distance,
      };
}
