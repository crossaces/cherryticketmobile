import 'dart:convert';
import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/event_model.dart';
import 'package:cherryticketmobile/model/formpendaftaran_model.dart';
import 'package:cherryticketmobile/model/pendaftaran_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PendaftaranpesertaAPI extends ChangeNotifier {
  List<Pendaftaranpeserta> _items = [];

  List<Pendaftaranpeserta> get items {
    return _items;
  }

  Future<void> fetch() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    int id = prefs.getInt('idpeserta') ?? '0';
    Uri url = Uri.parse(api + "pendaftaranp/" + id.toString());
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
      final List<Pendaftaranpeserta> loadpendaftaran = [];
      final pendaftaranData = extractedData['data'];
      pendaftaranData.forEach((data) => loadpendaftaran.add(Pendaftaranpeserta(
          idpendaftaran: data['ID_PENDAFTARAN'],
          event: Event.fromJson(data['event']),
          nomortiket: data['NOMOR_TIKET'],
          datapertanyaan: List<PertanyaanResponse>.from(json
              .decode(data["DATA_PERTANYAAN"])
              .map((x) => PertanyaanResponse.fromJson(x))).toList(),
          statuspendaftaran: data['STATUS_PENDAFTARAN'].toString(),
          idformpendaftaran: data['ID_FORM_PENDAFTARAN'])));

      _items = loadpendaftaran;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
