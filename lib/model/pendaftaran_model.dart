import 'dart:convert';
import 'package:cherryticketmobile/model/event_model.dart';
import 'package:cherryticketmobile/model/formpendaftaran_model.dart';

import 'package:cherryticketmobile/model/order_model.dart';

class Pendaftaranpeserta {
  final int idpendaftaran;
  List<PertanyaanResponse> datapertanyaan;
  final int nomortiket;
  final String statuspendaftaran;
  final int idformpendaftaran;
  final Event event;
  final OrderTransaksi order;

  Pendaftaranpeserta(
      {this.idpendaftaran,
      this.datapertanyaan,
      this.nomortiket,
      this.statuspendaftaran,
      this.order,
      this.event,
      this.idformpendaftaran});

  factory Pendaftaranpeserta.fromJson(Map<String, dynamic> data) {
    return Pendaftaranpeserta(
        idpendaftaran: json.decode(data['ID_PENDAFTARAN']),
        event: Event.fromJson(data['event']),
        nomortiket: data['NOMOR_TIKET'],
        order: OrderTransaksi.fromJson(data['order']),
        datapertanyaan: data['DATA_PERTANYAAN'],
        statuspendaftaran: data['STATUS_PENDAFTARAN'].toString(),
        idformpendaftaran: data['ID_FORM_PENDAFTARAN']);
  }
}
