class Transaksi {
  final int idtransaksi;
  final String tgltransaksi;
  final String statustransaksi;
  final String metodetransaksi;
  final String buktipembayaran;
  final int idpeserta;

  Transaksi(
      {this.idtransaksi,
      this.tgltransaksi,
      this.statustransaksi,
      this.metodetransaksi,
      this.buktipembayaran,
      this.idpeserta});

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
        idtransaksi: json['ID_TRANSAKSI'],
        tgltransaksi: json['TGL_TRANSAKSI'].toString(),
        statustransaksi: json['STATUS_TRANSAKSI'].toString(),
        metodetransaksi: json['METODE_TRANSAKSI'].toString(),
        buktipembayaran: json['BUKTI_PEMBAYARAN'].toString(),
        idpeserta: json['ID_PESERTA']);
  }
}
