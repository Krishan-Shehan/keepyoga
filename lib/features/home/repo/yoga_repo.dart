//
//
//

//
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:keepyoga/features/home/models/Yoga_Session_DataModel.dart';

class YogaRepo {
  static Future<List<YogaSessionData>> fetchYogaSessions() async {
    var client = http.Client();
    List<YogaSessionData> yogaSessions = [];
    try {
      log("response.body");
      var response = await client.get(
        Uri.parse('http://84.46.249.96:5000/api/v1/sessions'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIzMmUwZTJkMy02ZWVlLTQzNTYtYmVjMC01Yjg5ZWY1NTRiYjQiLCJpYXQiOjE3MTQ2NDg0NDcsImV4cCI6MTcxNDczNDg0N30.BOS4ziXJNBLQrzAQWMjXQE0WVEx70l4BUpAvgdE850s', // Add your token here
        },
      );

      // log(response.body);

      if (response.statusCode == 200) {
        log("statusCode");
        List<dynamic> result = jsonDecode(response.body);

        for (int i = 0; i < result.length; i++) {
          List<YogaSessionLessonData> lessons = [];
          if (result[i]['lessons'] != null) {
            for (int j = 0; j < result[i]['lessons'].length; j++) {
              YogaSessionLessonData lesson =
                  YogaSessionLessonData.fromJson(result[i]['lessons'][j]);
              lessons.add(lesson);
            }
          }
          YogaSessionData session = YogaSessionData.fromJson(result[i]);
          session.lessons = lessons;
          yogaSessions.add(session);
        }
        log("statusCode End");
      }

      return yogaSessions;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<List<YogaSessionData>> fetchYogaSingleSessionData(
      String id) async {
    var client = http.Client();
    List<YogaSessionData> yogaSession = [];
    try {
      log("response.body");
      var response = await client.get(
        Uri.parse('http://84.46.249.96:5000/api/v1/session?id=$id'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIzMmUwZTJkMy02ZWVlLTQzNTYtYmVjMC01Yjg5ZWY1NTRiYjQiLCJpYXQiOjE3MTQ2NDg0NDcsImV4cCI6MTcxNDczNDg0N30.BOS4ziXJNBLQrzAQWMjXQE0WVEx70l4BUpAvgdE850s', // Add your token here
        },
      );

      log(response.body);

      if (response.statusCode == 200) {
        log("statusCode");
        List<dynamic> result = [jsonDecode(response.body)];

        for (int i = 0; i < result.length; i++) {
          List<YogaSessionLessonData> lessons = [];
          if (result[i]['lessons'] != null) {
            for (int j = 0; j < result[i]['lessons'].length; j++) {
              YogaSessionLessonData lesson =
                  YogaSessionLessonData.fromJson(result[i]['lessons'][j]);
              lessons.add(lesson);
            }
          }
          YogaSessionData session = YogaSessionData.fromJson(result[i]);
          session.lessons = lessons;
          yogaSession.add(session);
        }
        log("statusCode End");
      }

      return yogaSession;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<List<YogaSessionLessonData>> fetchYogaSingleLessonData(
      String id, String token) async {
    var client = http.Client();
    List<YogaSessionLessonData> yogaLesson = [];
    try {
      var response = await client.get(
        Uri.parse('http://84.46.249.96:5000/api/v1/lesson?id=$id'),
        headers: {
          'Authorization':
              // 'Bearer $token', // Add your token here
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIzMmUwZTJkMy02ZWVlLTQzNTYtYmVjMC01Yjg5ZWY1NTRiYjQiLCJpYXQiOjE3MTQ2NDg0NDcsImV4cCI6MTcxNDczNDg0N30.BOS4ziXJNBLQrzAQWMjXQE0WVEx70l4BUpAvgdE850s', // Add your token here
        },
      );

      log(response.body);

      if (response.statusCode == 200) {
        log("statusCode");
        var result = jsonDecode(response.body);
        log(result["id"]);
        log("statusCode");
        YogaSessionLessonData lesson = YogaSessionLessonData(
            id: result["id"],
            title: result["title"],
            description: result["description"],
            video: result["video"],
            sessionId: result["sessionId"],
            createdAt: DateTime.parse(result["createdAt"]),
            updatedAt: DateTime.parse(result["updatedAt"]),
            videoUrl: result["videoUrl"]);

        yogaLesson.add(lesson);

        log("statusCode End");
      }

      return yogaLesson;
    } catch (e) {
      log(e.toString());
      return [];
    } finally {
      client.close();
    }
  }
}
// YogaSessionData
