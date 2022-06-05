class Formpendaftaran {
  final int idformpendaftaran;
  final String datapertanyaan;
  final int idevent;

  Formpendaftaran({this.idformpendaftaran, this.datapertanyaan, this.idevent});

  factory Formpendaftaran.fromJson(Map<String, dynamic> json) {
    return Formpendaftaran(
        idformpendaftaran: json['ID_FORM_PENDAFTARAN'],
        idevent: json['ID_EVENT'],
        datapertanyaan: json['DATA_PERTANYAAN']);
  }
}
