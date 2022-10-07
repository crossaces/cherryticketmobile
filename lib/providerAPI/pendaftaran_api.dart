import 'dart:convert';
import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/event_model.dart';
import 'package:cherryticketmobile/model/formpendaftaran_model.dart';
import 'package:cherryticketmobile/model/order_model.dart';
import 'package:cherryticketmobile/model/pendaftaran_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PendaftaranpesertaAPI extends ChangeNotifier {
  bool cekcoming = false;
  bool cekgoing = false;
  bool cekover = false;

  bool get cekcomings {
    return cekcoming;
  }

  bool get cekgoings {
    return cekgoing;
  }

  bool get cekovers {
    return cekover;
  }

  List<Pendaftaranpeserta> _coming = [];

  List<Pendaftaranpeserta> get coming {
    return _coming;
  }

  List<Pendaftaranpeserta> _going = [];

  List<Pendaftaranpeserta> get going {
    return _going;
  }

  Pendaftaranpeserta findByIdGoing(int id) {
    return _going
        .firstWhere((data) => data.idpendaftaran == id); // find the berita
  }

  List<Pendaftaranpeserta> _over = [];

  List<Pendaftaranpeserta> get over {
    return _over;
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
          event: EventPendaftaran.fromJson(data['event']),
          nomortiket: data['NOMOR_TIKET'],
          order: OrderTransaksi.fromJson(data['order']),
          datapertanyaan: List<PertanyaanResponse>.from(json
              .decode(data["DATA_PERTANYAAN"])
              .map((x) => PertanyaanResponse.fromJson(x))).toList(),
          statuspendaftaran: data['STATUS_PENDAFTARAN'].toString(),
          idformpendaftaran: data['ID_FORM_PENDAFTARAN'])));

      _coming = loadpendaftaran
          .where((x) => x.event.statusevent.toString() == "null")
          .toList();
      if (_coming.isEmpty) cekcoming = true;

      _going = loadpendaftaran
          .where((x) =>
              x.event.statusevent.toString() != "null" &&
              x.event.statusevent.toString() != "Finish")
          .toList();
      _over = loadpendaftaran
          .where((x) => x.event.statusevent.toString() == "Finish")
          .toList();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
