class Pendaftaranpeserta {
  final int idpendaftaran;
  final int datapertanyaan;
  final int nomortiket;
  final String statuspendaftaran;
  final int idformpendaftaran;

  Pendaftaranpeserta(
      {this.idpendaftaran,
      this.datapertanyaan,
      this.nomortiket,
      this.statuspendaftaran,
      this.idformpendaftaran});

  factory Pendaftaranpeserta.fromJson(Map<String, dynamic> json) {
    return Pendaftaranpeserta(
        idpendaftaran: json['ID_PENDAFTARAN'],
        nomortiket: json['NOMOR_TIKET'],
        datapertanyaan: json['DATA_PERTANYAAN'],
        statuspendaftaran: json['STATUS_PENDAFTARAN'].toString(),
        idformpendaftaran: json['ID_FORM_PENDAFTARAN']);
  }
}
