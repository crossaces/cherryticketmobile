import 'dart:convert';

import 'package:cherryticketmobile/components/data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cherryticketmobile/model/berita_model.dart';

class BeritaAPI extends ChangeNotifier {
  List<Berita> _items = [];

  List<Berita> get items {
    return _items;
  }

  Berita findById(int idberita) {
    return _items
        .firstWhere((berita) => berita.idberita == idberita); // find the berita
  }

  Future<void> fetchberita() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    Uri url = Uri.parse(api + "berita");
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
      final List<Berita> loadberita = [];
      final beritaMenu = extractedData['data'];
      beritaMenu.forEach(
        (json) => loadberita.add(
          Berita(
            idberita: json['ID_BERITA'],
            tglmulai: json['TGL_MULAI'].toString(),
            tglselesai: json['TGL_SELESAI'].toString(),
            judul: json['JUDUL'].toString(),
            gambarberita: json['GAMBAR_BERITA'].toString(),
            deskripsi: json['DESKRIPSI'].toString(),
            idadmin: json['ID_ADMIN'],
          ),
        ),
      );
      _items = loadberita;

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
