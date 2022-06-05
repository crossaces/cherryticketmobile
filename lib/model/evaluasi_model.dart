class Evaluasi {
  final int idevaluasi;
  final String datajawaban;
  final int idformevaluasi;

  Evaluasi({this.idevaluasi, this.datajawaban, this.idformevaluasi});

  factory Evaluasi.fromJson(Map<String, dynamic> json) {
    return Evaluasi(
        idevaluasi: json['ID_EVALUASI'],
        datajawaban: json['DATA_JAWABAN'],
        idformevaluasi: json['ID_FORM_EVALUASI']);
  }
}
