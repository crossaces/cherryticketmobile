import 'dart:convert';

import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/peserta_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PesertaAPI with ChangeNotifier {
  Peserta _items = Peserta();

  Peserta get items {
    return _items;
  }

  Future<void> fetch() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    int id = prefs.getInt('idpeserta') ?? '0';
    Uri url = Uri.parse(api + "peserta/" + id.toString());
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
      final pesertaData = extractedData['data'];
      _items = Peserta.fromJson(pesertaData);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
