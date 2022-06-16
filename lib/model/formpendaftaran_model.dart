class Formpendaftaran {
  final int idformpendaftaran;
  final List<Pertanyaan> datapertanyaan;
  final int idevent;

  Formpendaftaran({this.idformpendaftaran, this.datapertanyaan, this.idevent});

  factory Formpendaftaran.fromJson(Map<String, dynamic> json) {
    return Formpendaftaran(
        idformpendaftaran: json['ID_FORM_PENDAFTARAN'],
        idevent: json['ID_EVENT'],
        datapertanyaan: json['DATA_PERTANYAAN'] == null
            ? null
            : List<Pertanyaan>.from(
                json["DATA_PERTANYAAN"].map((x) => Pertanyaan.fromJson(x))));
  }
}

class Pertanyaan {
  final String pertanyaan;
  String jawaban;
  final String type;
  final List<Options> options;

  Pertanyaan({this.pertanyaan, this.type, this.options, this.jawaban});

  factory Pertanyaan.fromJson(Map<String, dynamic> json) {
    return Pertanyaan(
        pertanyaan: json['PERTANYAAN'],
        type: json['TYPE'],
        jawaban: "",
        options: List<Options>.from(
            json["OPTIONS"].map((x) => Options.fromJson(x))));
  }
}

class Options {
  final String option;

  Options({this.option});

  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      option: json['OPTION'],
    );
  }
}

class Jawaban {
  int idpeserta;
  int harga;
  List<Pertanyaan> datapertanyaan;
  int idtiket;
  String namatiket;
  Jawaban(
      {this.idpeserta,
      this.datapertanyaan,
      this.idtiket,
      this.namatiket,
      this.harga});
}
