class OrderTransaksi {
  final int idorder;
  final int jumlah;
  final int subtotal;
  final int idtransaksi;
  final int idtiket;
  final String namatiket;
  final String fasilitas;

  OrderTransaksi({
    this.idorder,
    this.jumlah,
    this.subtotal,
    this.idtransaksi,
    this.fasilitas,
    this.namatiket,
    this.idtiket,
  });

  factory OrderTransaksi.fromJson(Map<String, dynamic> json) {
    return OrderTransaksi(
        idtiket: json['ID_TIKET'],
        idorder: json['ID_ORDER'],
        namatiket: json['tiket']['NAMA_TIKET'],
        fasilitas: json['tiket']['FASILITAS'],
        idtransaksi: json['ID_TRANSAKSI'],
        jumlah: json['JUMLAH'],
        subtotal: json['SUBTOTAL']);
  }
}
