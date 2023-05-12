import 'dart:convert';

import 'package:esprit/src/data/models/custom_error.dart';
import 'package:esprit/src/data/models/user.dart';
import 'package:esprit/src/utils/custom_http_client.dart';
import 'package:esprit/src/utils/custom_shared_prefs.dart';
import 'package:esprit/src/utils/my_urls.dart';

class LoginRepository {
  CustomHttpClient http = CustomHttpClient();

  Future<dynamic> login(String email, String password) async {
    try {
      var body = jsonEncode({'email': email, 'password': password});
      var response = await http.post(
        '${MyUrls.serverUrl}/auth',
        body: body,
      );
      final dynamic loginResponse = jsonDecode(response.body);

      if (loginResponse['error'] != null) {
        return CustomError.fromJson(loginResponse);
      }
      await CustomSharedPreferences.setString('token', loginResponse['token']);
      final User user = User.fromJson(loginResponse['user']);
      await CustomSharedPreferences.setString('user', user.toString());
      return user;
    } catch (err) {
      return CustomError(
        error: true,
        errorMessage: "There's an error, try again!",
      );
    }
  }
}
