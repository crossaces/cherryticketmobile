class Genre {
  final int idgenre;
  final String namagenre;

  Genre({
    this.idgenre,
    this.namagenre,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      idgenre: json['ID_GENRE'],
      namagenre: json['NAMA_GENRE'].toString(),
    );
  }
}
