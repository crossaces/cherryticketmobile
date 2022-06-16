class Tiket {
  final int idtiket;
  final String namatiket;
  final String fasilitas;
  final int harga;
  final int stok;
  int jumlahbeli;
  final String tglmulaipenjualan;
  final String tglselesaipenjualan;
  final int idevent;

  Tiket(
      {this.idtiket,
      this.namatiket,
      this.fasilitas,
      this.harga,
      this.jumlahbeli,
      this.stok,
      this.tglmulaipenjualan,
      this.tglselesaipenjualan,
      this.idevent});

  factory Tiket.fromJson(Map<String, dynamic> json) {
    return Tiket(
        idtiket: json['ID_TIKET'],
        namatiket: json['NAMA_TIKET'].toString(),
        fasilitas: json['FASILITAS'].toString(),
        harga: json['HARGA'],
        stok: json['STOK'],
        jumlahbeli: 0,
        tglmulaipenjualan: json['TGL_MULAI PENJUALAN'].toString(),
        tglselesaipenjualan: json['TGL_SELESAI_PENJUALAN'].toString(),
        idevent: json['ID_EVENT']);
  }
}
