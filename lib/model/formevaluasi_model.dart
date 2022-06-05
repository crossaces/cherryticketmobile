class Formevaluasi {
  final int idformevaluasi;
  final String datapertanyaan;
  final int idevent;

  Formevaluasi({this.idformevaluasi, this.datapertanyaan, this.idevent});

  factory Formevaluasi.fromJson(Map<String, dynamic> json) {
    return Formevaluasi(
        idformevaluasi: json['ID_FORM_EVALUASI'],
        idevent: json['ID_EVENT'],
        datapertanyaan: json['DATA_PERTANYAAN']);
  }
}
