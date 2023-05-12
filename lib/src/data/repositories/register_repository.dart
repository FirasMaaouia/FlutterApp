import 'dart:convert';

import 'package:esprit/src/data/models/custom_error.dart';
import 'package:esprit/src/data/models/user.dart';
import 'package:esprit/src/utils/custom_http_client.dart';
import 'package:esprit/src/utils/custom_shared_prefs.dart';
import 'package:esprit/src/utils/my_urls.dart';

class RegisterRepository {
  CustomHttpClient http = CustomHttpClient();

  Future<dynamic> register(String name, String email, String username,
      String password, String type) async {
    try {
      var body = jsonEncode({
        'name': name,
        'username': username,
        'password': password,
        'email': email,
        'type': type
      });
      var response = await http.post(
        '${MyUrls.serverUrl}/user',
        body: body,
      );
      final dynamic registerResponse = jsonDecode(response.body);
      await CustomSharedPreferences.setString(
          'token', registerResponse['token']);

      if (registerResponse['error'] != null) {
        return CustomError.fromJson(registerResponse);
      }

      final User user = User.fromJson(registerResponse['user']);
      return user;
    } catch (err) {
      throw err;
    }
  }
}
