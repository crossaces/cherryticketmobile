class Sertifikat {
  final int idsertifikat;
  final String background;
  final int idevent;

  Sertifikat({
    this.idsertifikat,
    this.background,
    this.idevent,
  });

  factory Sertifikat.fromJson(Map<String, dynamic> json) {
    return Sertifikat(
      idsertifikat: json['ID_SERTIFIKAT'],
      background: json['BACKGROUND'].toString(),
      idevent: json['ID_EVENT'],
    );
  }
}
