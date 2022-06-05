class Users {
  final int iduser;
  final String email;
  final String nohp;
  final String role;
  final int idpeserta;
  final String namadepan;
  final String namabelakang;
  final String gambar;
  final String alamat;
  final String token;

  Users({
    this.email,
    this.nohp,
    this.role,
    this.idpeserta,
    this.namabelakang,
    this.namadepan,
    this.gambar,
    this.alamat,
    this.token,
    this.iduser,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      iduser: json['ID_USER'],
      email: json['email'].toString(),
      nohp: json['no_hp'].toString(),
      role: json['role'].toString(),
      idpeserta: json['ID_PESERTA'],
      namadepan: json['NAMA_DEPAN'].toString(),
      namabelakang: json['NAMA_BELAKANG'].toString(),
      gambar: json['GAMBAR'].toString(),
      alamat: json['ALAMAT'].toString(),
      token: json['TOKEN'].toString(),
    );
  }
}
