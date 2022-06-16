import 'dart:convert';

import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/formpendaftaran_model.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FormPendaftaranAPI with ChangeNotifier {
  Formpendaftaran _items = Formpendaftaran();

  Formpendaftaran get items {
    return _items;
  }

  Future<void> fetch(int idevent) async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    Uri url = Uri.parse(api + "fpendaftaran/" + idevent.toString());
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      final extractedData = json.decode(response.body);
      final formpendaftaranData = extractedData['data'];
      _items = Formpendaftaran.fromJson(formpendaftaranData);

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
