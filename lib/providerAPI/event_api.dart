import 'dart:convert';

import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/event_model.dart';
import 'package:cherryticketmobile/model/tiket_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EventAPI extends ChangeNotifier {
  List<Event> _items = [];
  List<Event> tempitem = [];
  String namagenre = 'All';
  String search = "";

  String get searchvalue {
    return search;
  }

  void initTiket(int idtiket, int idevent) {
    _items
        .firstWhere((event) => event.idevent == idevent)
        .tiket
        .firstWhere((tiket) => tiket.idtiket == idtiket)
        .jumlahbeli = 0;
  }

  void searchinit(String value) {
    search = value;
    notifyListeners();
  }

  String get genre {
    return namagenre;
  }

  int jumlahBeli(int idtiket, int idevent) {
    return _items[_items.indexWhere((event) => event.idevent == idevent)]
        .tiket[_items[_items.indexWhere((event) => event.idevent == idevent)]
            .tiket
            .indexWhere((tiket) => tiket.idtiket == idtiket)]
        .jumlahbeli;
  }

  void initNamaGenre(String genre) {
    namagenre = genre;
    notifyListeners();
  }

  void plusTiket(int idtiket, int idevent) {
    _items
        .firstWhere((event) => event.idevent == idevent)
        .tiket
        .firstWhere((tiket) => tiket.idtiket == idtiket)
        .jumlahbeli += 1;
    notifyListeners();
  }

  void minusTiket(int idtiket, int idevent) {
    final indexevent = _items.indexWhere((event) => event.idevent == idevent);
    _items[indexevent]
        .tiket
        .firstWhere((tiket) => tiket.idtiket == idtiket)
        .jumlahbeli--;
    notifyListeners();
  }

  List<Event> get items {
    return _items;
  }

  Event findById(int id) {
    return _items.firstWhere((event) => event.idevent == id); // find the berita
  }

  Tiket findByIdTiket(int idtiket, int idevent) {
    return _items[_items.indexWhere((event) => event.idevent == idevent)]
        .tiket
        .firstWhere((event) => event.idtiket == idtiket); // find the berita
  }

  Event findByToken(String token) {
    return _items.firstWhere((event) => event.token == token,
        orElse: () => null); // find the berita
  }

  Future<void> fetch() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    Uri url = Uri.parse(api + "event");
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
      final List<Event> loadevent = [];
      final eventData = extractedData['data']['Active'];
      eventData.forEach(
        (json) => loadevent.add(
          Event(
              idevent: json['ID_EVENT'],
              eventtab: json['EVENT_TAB'].toString(),
              namaevent: json['NAMA_EVENT'].toString(),
              tglmulai: json['TGL_MULAI'].toString(),
              tglselesai: json['TGL_SELESAI'].toString(),
              tglacaramulai: json['TGL_ACARA_MULAI'].toString(),
              tglacaraselesai: json['TGL_ACARA_SELESAI'].toString(),
              waktumulai: json['WAKTU_MULAI'].toString(),
              waktuselesai: json['WAKTU_SELESAI'].toString(),
              statusevent: json['STATUS_EVENT'].toString(),
              totaltiketberedar: json['TOTAL_TIKET_BEREDAR'],
              visibleevent: json['VISIBLE_EVENT'],
              deskripsi: json['DESKRIPSI'].toString(),
              syarat: json['SYARAT'],
              sertifikat: json['SERTIFIKAT'],
              evaluasi: json['EVALUASI'],
              modeevent: json['MODE_EVENT'].toString(),
              gambarevent: json['GAMBAR_EVENT'].toString(),
              namalokasi: json['NAMA_LOKASI'].toString(),
              namajenis: json['jenisacara']['NAMA_JENIS'].toString(),
              namakota: json['kota']['NAMA_KOTA'].toString(),
              namagenre: json['genre']['NAMA_GENRE'].toString(),
              numberphone: json['eo']['user']['no_hp'].toString(),
              lng: json['LNG'],
              lat: json['LAT'],
              url: json['URL'].toString(),
              qrcode: json['QRCODE'].toString(),
              token: json['TOKEN'].toString(),
              qna: json['QNA'],
              batastiket: json['BATAS_TIKET'],
              komentar: json['KOMENTAR'].toString(),
              tiket: List<Tiket>.from(
                  json["tiket"].map((x) => Tiket.fromJson(x)))),
        ),
      );
      tempitem = loadevent;
      _items = loadevent;

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
