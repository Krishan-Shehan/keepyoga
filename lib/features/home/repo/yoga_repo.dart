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
}
// YogaSessionData
