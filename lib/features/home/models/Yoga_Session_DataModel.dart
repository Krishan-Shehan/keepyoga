import 'dart:convert';

List<YogaSessionData> yogaSessionFromJson(String str) =>
    List<YogaSessionData>.from(
        json.decode(str).map((x) => YogaSessionData.fromJson(x)));

String yogaSessionToJson(List<YogaSessionData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class YogaSessionData {
  String id;
  String title;
  String instructor;
  String category;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  String imageUrl;
  List<YogaSessionLessonData> lessons;

  YogaSessionData({
    required this.id,
    required this.title,
    required this.instructor,
    required this.category,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
    required this.lessons,
  });

  factory YogaSessionData.fromJson(Map<String, dynamic> json) =>
      YogaSessionData(
        id: json["id"],
        title: json["title"],
        instructor: json["instructor"],
        category: json["category"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        imageUrl: json["imageUrl"],
        lessons: List<YogaSessionLessonData>.from(
            json["lessons"].map((x) => YogaSessionLessonData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "instructor": instructor,
        "category": category,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "imageUrl": imageUrl,
        "lessons": List<dynamic>.from(lessons.map((x) => x.toJson())),
      };
}

class YogaSessionLessonData {
  String id;
  String title;
  String description;
  String video;
  String sessionId;
  DateTime createdAt;
  DateTime updatedAt;
  String videoUrl;

  YogaSessionLessonData({
    required this.id,
    required this.title,
    required this.description,
    required this.video,
    required this.sessionId,
    required this.createdAt,
    required this.updatedAt,
    required this.videoUrl,
  });

  factory YogaSessionLessonData.fromJson(Map<String, dynamic> json) =>
      YogaSessionLessonData(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        video: json["video"],
        sessionId: json["sessionId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        videoUrl: json["videoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "video": video,
        "sessionId": sessionId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "videoUrl": videoUrl,
      };
}
