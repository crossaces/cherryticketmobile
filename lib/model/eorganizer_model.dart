class EO {
  final int ideo;
  final String namaeo;
  final String linkweb;
  final String alamat;
  final String statuseo;
  final int iduser;

  EO({
    this.ideo,
    this.namaeo,
    this.linkweb,
    this.alamat,
    this.statuseo,
    this.iduser,
  });

  factory EO.fromJson(Map<String, dynamic> json) {
    return EO(
        ideo: json['ID_EO'],
        namaeo: json['NAMA_EO'].toString(),
        linkweb: json['LINK_WEB'].toString(),
        alamat: json['ALAMAT'].toString(),
        statuseo: json['STATUS_EO'].toString(),
        iduser: json['ID_USER']);
  }
}
