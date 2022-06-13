class Peserta {
  final int idpeserta;
  String namadepan;
  String namabelakang;
  String gambar;
  String email;
  String nohp;
  String alamat;
  final String token;
  final int iduser;

  Peserta(
      {this.idpeserta,
      this.namabelakang,
      this.namadepan,
      this.gambar,
      this.alamat,
      this.email,
      this.nohp,
      this.token,
      this.iduser});

  factory Peserta.fromJson(Map<String, dynamic> json) {
    return Peserta(
        idpeserta: json['ID_PESERTA'],
        namadepan: json['NAMA_DEPAN'].toString(),
        namabelakang: json['NAMA_BELAKANG'].toString(),
        gambar: json['GAMBAR'].toString(),
        alamat: json['ALAMAT'].toString(),
        email: json['email'].toString(),
        nohp: json['no_hp'].toString(),
        token: json['TOKEN'].toString(),
        iduser: json['ID_USER']);
  }
}
