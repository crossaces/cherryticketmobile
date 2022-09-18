import 'dart:convert';

import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/qna_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QnaAPI extends ChangeNotifier {
  List<Qna> _items = [];

  List<Qna> get items {
    return _items;
  }

  Future<void> fetch(String id) async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    Uri url = Uri.parse(api + "qnaevent/" + id);
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
      final List<Qna> loadQna = [];
      final kotaData = extractedData['data'];
      kotaData.forEach((json) => loadQna.add(
            Qna(
              idqna: json['ID_QNA'],
              namapeserta: json['NAMA_PESERTA'].toString(),
              pertanyaan: json['PERTANYAAN'],
              idevent: json['ID_EVENT'],
            ),
          ));
      _items = loadQna;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
