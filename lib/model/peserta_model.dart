class Peserta {
  final int idpeserta;
  final String namadepan;
  final String namabelakang;
  final String gambar;
  final String alamat;
  final String token;
  final int iduser;

  Peserta(
      {this.idpeserta,
      this.namabelakang,
      this.namadepan,
      this.gambar,
      this.alamat,
      this.token,
      this.iduser});

  factory Peserta.fromJson(Map<String, dynamic> json) {
    return Peserta(
        idpeserta: json['ID_PESERTA'],
        namadepan: json['NAMA_DEPAN'].toString(),
        namabelakang: json['NAMA_BELAKANG'].toString(),
        gambar: json['GAMBAR'].toString(),
        alamat: json['ALAMAT'].toString(),
        token: json['TOKEN'].toString(),
        iduser: json['ID_USER']);
  }
}
