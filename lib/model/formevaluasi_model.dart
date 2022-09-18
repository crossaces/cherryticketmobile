class Formevaluasi {
  final int idformevaluasi;
  List<PertanyaanE> datapertanyaan;
  final int idevent;

  Formevaluasi({this.idformevaluasi, this.datapertanyaan, this.idevent});

  factory Formevaluasi.fromJson(Map<String, dynamic> json) {
    return Formevaluasi(
        idformevaluasi: json['ID_FORM_EVALUASI'],
        idevent: json['ID_EVENT'],
        datapertanyaan: json['DATA_PERTANYAAN'] == null
            ? null
            : List<PertanyaanE>.from(
                    json["DATA_PERTANYAAN"].map((x) => PertanyaanE.fromJson(x)))
                .toList());
  }
}

class OptionsE {
  final String option;

  OptionsE({this.option});

  Map<String, dynamic> toJson() => {
        'OPTION': option,
      };
  factory OptionsE.fromJson(Map<String, dynamic> json) {
    return OptionsE(
      option: json['OPTION'],
    );
  }
}

class PertanyaanE {
  final String pertanyaan;
  final int nomor;
  String jawaban;
  final String type;
  final List<OptionsE> options;

  PertanyaanE(
      {this.pertanyaan, this.type, this.options, this.jawaban, this.nomor});

  Map<String, dynamic> toJson() => {
        'PERTANYAAN': pertanyaan,
        'NOMOR': nomor,
        'DATA_JAWABAN': jawaban,
        'TYPE': type,
        'OPTIONS': options.map((tag) => tag.toJson()).toList(),
      };

  factory PertanyaanE.fromJson(Map<String, dynamic> json) {
    return PertanyaanE(
        pertanyaan: json['PERTANYAAN'],
        type: json['TYPE'],
        nomor: json['NOMOR'],
        jawaban: "",
        options: List<OptionsE>.from(
            json["OPTIONS"].map((x) => OptionsE.fromJson(x))));
  }
}
