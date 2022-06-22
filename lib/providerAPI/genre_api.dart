import 'dart:convert';

import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/genre_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GenreAPI extends ChangeNotifier {
  List<Genre> _items = [];

  int index = 0;

  void initBeforeIndex(int i) {
    index = i;
    notifyListeners();
  }

  void touchGenre(int i, int index) {
    _items[i].check = true;
    if (index != i) {
      _items[index].check = false;
    }

    notifyListeners();
  }

  int get getIndex {
    return index;
  }

  List<Genre> get items {
    return _items;
  }

  Genre findById(int idgenre) {
    return _items
        .firstWhere((genre) => genre.idgenre == idgenre); // find the berita
  }

  Future<void> fetch() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    Uri url = Uri.parse(api + "genre");
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
      final List<Genre> loadgenre = [];
      final genreData = extractedData['data'];
      loadgenre.add(
        Genre(
          idgenre: 0,
          namagenre: 'All',
          gambar: 'all.png',
          check: true,
        ),
      );
      genreData.forEach(
        (json) => loadgenre.add(
          Genre(
            idgenre: json['ID_GENRE'],
            namagenre: json['NAMA_GENRE'].toString(),
            gambar: json['GAMBAR_GENRE'].toString(),
            check: false,
          ),
        ),
      );
      _items = loadgenre;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
