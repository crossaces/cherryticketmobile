class Jenisacara {
  final int idjenisacara;
  final String namajenis;
  final String gambar;
  final String status;

  Jenisacara({this.idjenisacara, this.namajenis, this.gambar, this.status});

  factory Jenisacara.fromJson(Map<String, dynamic> json) {
    return Jenisacara(
        idjenisacara: json['ID_JENIS_ACARA'],
        namajenis: json['NAMA_JENIS'].toString(),
        gambar: json['GAMBAR'].toString(),
        status: json['STATUS'].toString());
  }
}
