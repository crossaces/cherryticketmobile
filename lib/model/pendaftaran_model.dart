import 'dart:convert';

import 'package:cherryticketmobile/model/event_model.dart';
import 'package:cherryticketmobile/model/formpendaftaran_model.dart';

class Pendaftaranpeserta {
  final int idpendaftaran;
  List<PertanyaanResponse> datapertanyaan;
  final int nomortiket;
  final String statuspendaftaran;
  final int idformpendaftaran;
  final Event event;

  Pendaftaranpeserta(
      {this.idpendaftaran,
      this.datapertanyaan,
      this.nomortiket,
      this.statuspendaftaran,
      this.event,
      this.idformpendaftaran});

  factory Pendaftaranpeserta.fromJson(Map<String, dynamic> data) {
    return Pendaftaranpeserta(
        idpendaftaran: json.decode(data['ID_PENDAFTARAN']),
        event: Event.fromJson(data['event']),
        nomortiket: data['NOMOR_TIKET'],
        datapertanyaan: data['DATA_PERTANYAAN'],
        statuspendaftaran: data['STATUS_PENDAFTARAN'].toString(),
        idformpendaftaran: data['ID_FORM_PENDAFTARAN']);
  }
}
