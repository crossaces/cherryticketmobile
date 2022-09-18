import 'dart:convert';
import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/formevaluasi_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FormEvaluasiAPI extends ChangeNotifier {
  Formevaluasi _items = Formevaluasi();
  bool check = false;
  Formevaluasi get items {
    return _items;
  }

  void initCheck(bool init) {
    check = init;
    notifyListeners();
  }

  bool get checks {
    return check;
  }

  PertanyaanE returnPertanyaanDetail(int index) {
    return _items.datapertanyaan[index];
  }

  void isiPertanyaan(int indexquestion, String value) {
    _items.datapertanyaan[indexquestion].jawaban = value;
    notifyListeners();
  }

  Future<void> fetch(int idevent) async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    Uri url = Uri.parse(api + "fevaluasi/" + idevent.toString());
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
      _items = Formevaluasi.fromJson(formpendaftaranData);

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
