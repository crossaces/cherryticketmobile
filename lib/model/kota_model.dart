class Kota {
  final int idkota;
  final String namakota;
  final String gambarkota;

  Kota({
    this.idkota,
    this.namakota,
    this.gambarkota,
  });

  factory Kota.fromJson(Map<String, dynamic> json) {
    return Kota(
      idkota: json['ID_KOTA'],
      namakota: json['NAMA_KOTA'].toString(),
      gambarkota: json['GAMBAR_KOTA'].toString(),
    );
  }
}
