class Qna {
  final int idqna;
  final String namapeserta;
  final String pertanyaan;
  final int idevent;

  Qna({this.idqna, this.namapeserta, this.pertanyaan, this.idevent});

  factory Qna.fromJson(Map<String, dynamic> json) {
    return Qna(
      idqna: json['ID_QNA'],
      namapeserta: json['NAMA_PESERTA'].toString(),
      pertanyaan: json['PERTANYAAN'],
      idevent: json['ID_EVENT'],
    );
  }
}
