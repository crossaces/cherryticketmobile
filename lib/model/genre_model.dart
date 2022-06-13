class Genre {
  final int idgenre;
  final String namagenre;
  final String gambar;
  bool check;

  Genre({this.idgenre, this.namagenre, this.gambar, this.check});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      idgenre: json['ID_GENRE'],
      namagenre: json['NAMA_GENRE'].toString(),
      gambar: json['GAMBAR_GENRE'].toString(),
    );
  }
}
