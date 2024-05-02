import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class AuthRepo {
  static Future<bool> LogIn(String email, String password) async {
    var client = http.Client();

    try {
      var response = await client.post(
          Uri.parse('http://84.46.249.96:5000/api/v1/auth/login'),
          body: {"email": "test@email.com", "password": "123456"});

      debugPrint(response.body);

      // final test = jsonDecode(response.body);
      // debugPrint("test");
      // debugPrint(test);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = jsonDecode(response.body);
        String token = responseData["token"];
        debugPrint(token);
        await GetStorage().write("access_token", token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
