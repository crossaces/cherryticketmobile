import 'dart:convert';
import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/event_model.dart';
import 'package:cherryticketmobile/model/order_model.dart';
import 'package:cherryticketmobile/model/transaksi_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransaksiApi extends ChangeNotifier {
  List<Transaksi> _items = [];

  List<Transaksi> get items {
    return _items;
  }

  Transaksi findById(int id) {
    return _items.firstWhere(
        (transaksi) => transaksi.idtransaksi == id); // find the berita
  }

  Future<void> fetch() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    int id = prefs.getInt('idpeserta') ?? '0';
    Uri url = Uri.parse(api + 'pesertat/' + id.toString());
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
      final List<Transaksi> loadKota = [];
      final transaksiData = extractedData['data'];
      transaksiData.forEach((json) => loadKota.add(
            Transaksi(
                idtransaksi: json['ID_TRANSAKSI'],
                event: Event.fromJson(json['event']),
                tgltransaksi: json['TGL_TRANSAKSI'].toString(),
                statustransaksi: json['STATUS_TRANSAKSI'].toString(),
                metodetransaksi: json['METODE_TRANSAKSI'].toString(),
                buktipembayaran: json['BUKTI_PEMBAYARAN'].toString(),
                total: json['TOTAL_HARGA'],
                order: List<Order>.from(
                    json["order"].map((x) => Order.fromJson(x))),
                idpeserta: json['ID_PESERTA']),
          ));
      _items = loadKota;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
