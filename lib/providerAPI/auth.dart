import 'package:cherryticketmobile/model/auth_model.dart';
import 'package:cherryticketmobile/components/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  Future<dynamic> register(RegisterRequestModel requestModel) async {
    Uri url = Uri.parse(api + 'pregister');

    var response = await http.post(
      url,
      body: json.encode(requestModel.toJson()),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  Future<dynamic> resend() async {
    Uri url = Uri.parse(api + 'email/resend');
    final prefs = await SharedPreferences.getInstance();

    int id = prefs.getInt('iduser') ?? '0';
    var response = await http.post(
      url,
      body: json.encode({'id': id}),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  Future<dynamic> login(LoginRequestModel requestModel) async {
    Uri url = Uri.parse(api + 'login');

    var response = await http.post(
      url,
      body: json.encode(requestModel.toJson()),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }
}
