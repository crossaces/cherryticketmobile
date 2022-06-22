import 'dart:convert';

import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/formpendaftaran_model.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FormPendaftaranAPI extends ChangeNotifier {
  Formpendaftaran _items = Formpendaftaran();

  final Formpendaftaran _items2 =
      Formpendaftaran(idevent: 1, idformpendaftaran: 2, datapertanyaan: [
    Pertanyaan(pertanyaan: "Coba coba", jawaban: "", type: "TEXT", nomor: 1),
    Pertanyaan(pertanyaan: "Coba Lagi", jawaban: "", type: "TEXT", nomor: 1)
  ]);

  Formpendaftaran get items {
    return _items;
  }

  Formpendaftaran get items2 {
    return _items2;
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
