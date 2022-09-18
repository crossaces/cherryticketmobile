class Check {
  final int idcheck;
  final String tglcheck;
  final String statuscheck;
  final int idpeserta;

  Check({
    this.idcheck,
    this.tglcheck,
    this.statuscheck,
    this.idpeserta,
  });

  factory Check.fromJson(Map<String, dynamic> json) {
    return Check(
        idcheck: json['ID_CHECK'],
        tglcheck: json['TGL_CHECK'].toString(),
        statuscheck: json['STATUS_CHECK'].toString(),
        idpeserta: json['ID_PESERTA']);
  }
}

class CheckRequestModel {
  int idpendaftaran;
  int idpeserta;

  CheckRequestModel({this.idpendaftaran, this.idpeserta});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id_pendaftaran': idpendaftaran,
      'id_peserta': idpeserta,
    };

    return map;
  }
}
