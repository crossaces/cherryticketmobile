import 'package:cherryticketmobile/model/event_model.dart';
import 'package:cherryticketmobile/model/order_model.dart';

class Transaksi {
  final int idtransaksi;
  final String tgltransaksi;
  final String statustransaksi;
  final String metodetransaksi;
  final String buktipembayaran;
  final int idpeserta;
  final int total;
  final Event event;
  final List<OrderTransaksi> order;

  Transaksi(
      {this.idtransaksi,
      this.tgltransaksi,
      this.statustransaksi,
      this.metodetransaksi,
      this.event,
      this.total,
      this.order,
      this.buktipembayaran,
      this.idpeserta});

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
        idtransaksi: json['ID_TRANSAKSI'],
        event: Event.fromJson(json['event']),
        tgltransaksi: json['TGL_TRANSAKSI'].toString(),
        statustransaksi: json['STATUS_TRANSAKSI'].toString(),
        total: json['TOTAL_HARGA'],
        metodetransaksi: json['METODE_TRANSAKSI'].toString(),
        buktipembayaran: json['BUKTI_PEMBAYARAN'].toString(),
        order: List<OrderTransaksi>.from(
            json["order"].map((x) => OrderTransaksi.fromJson(x))),
        idpeserta: json['ID_PESERTA']);
  }
}
