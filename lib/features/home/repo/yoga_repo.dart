//
//
//

//
import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:keepyoga/features/home/models/Yoga_Session_DataModel.dart';

class YogaRepo {
  static Future<List<YogaSessionData>> fetchYogaSessions() async {
    var client = http.Client();
    List<YogaSessionData> yogaSessions = [];
    String token = await GetStorage().read("access_token");
    try {
      log("response.body");
      var response = await client.get(
        Uri.parse('http://84.46.249.96:5000/api/v1/sessions'),
        headers: {
          'Authorization': 'Bearer $token',
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
    String token = await GetStorage().read("access_token");
    try {
      log("response.body");
      var response = await client.get(
        Uri.parse('http://84.46.249.96:5000/api/v1/session?id=$id'),
        headers: {
          'Authorization': 'Bearer $token',
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
      String id) async {
    var client = http.Client();
    List<YogaSessionLessonData> yogaLesson = [];
    String token = await GetStorage().read("access_token");
    try {
      var response = await client.get(
        Uri.parse('http://84.46.249.96:5000/api/v1/lesson?id=$id'),
        headers: {
          'Authorization': 'Bearer $token',
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
