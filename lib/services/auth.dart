import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

class AuthController {
  Future<bool> login(String email, String password) async {
    try {
      http.Response response = await http
          .post(Uri.parse('http://buddy.ropstambpo.com/api/login'), body: {
        'email': email,
        'password': password,
        'device_token': 'zasdcvgtghnkiuhgfde345tewasdfghjkm'
      });
      var data = jsonDecode(response.body.toString());
      if (data['meta']['status'] == 200) {
        var pref = await SharedPreferences.getInstance();
        pref.setString("userData", json.encode(data));
        Get.off(() => const HomeScreen());
        return true;
      } else {
        Get.snackbar('Message', data['meta']['message'],
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }
    } catch (e) {
      Get.snackbar('Message', 'Something went wrong',
          snackPosition: SnackPosition.BOTTOM);
    }
    return false;
  }

  Future<bool> tryAutoLogin() async {
    var pref = await SharedPreferences.getInstance();
    if (!pref.containsKey("userData")) {
      return false;
    } else {
      return true;
    }
  }

  static logOut() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    Get.off(() => const LoginScreen());
  }
}
