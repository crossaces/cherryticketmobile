import 'dart:convert';

import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/kota_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class KotaAPI extends ChangeNotifier {
  List<Kota> _items = [];

  List<Kota> get items {
    return _items;
  }

  Kota findById(int id) {
    return _items.firstWhere((kota) => kota.idkota == id); // find the berita
  }

  Future<void> fetch() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    Uri url = Uri.parse(api + "kota");
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
      final List<Kota> loadKota = [];
      final kotaData = extractedData['data'];
      kotaData.forEach((json) => loadKota.add(
            Kota(
              idkota: json['ID_KOTA'],
              namakota: json['NAMA_KOTA'].toString(),
              gambarkota: json['GAMBAR_KOTA'].toString(),
            ),
          ));
      _items = loadKota;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
