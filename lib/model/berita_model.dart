class Berita {
  final int idberita;
  final String tglmulai;
  final String tglselesai;
  final String judul;
  final String gambarberita;
  final String deskripsi;
  final int idadmin;

  Berita(
      {this.idberita,
      this.tglmulai,
      this.tglselesai,
      this.judul,
      this.gambarberita,
      this.deskripsi,
      this.idadmin});

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      idberita: json['ID_BERITA'],
      tglmulai: json['TGL_MULAI'].toString(),
      tglselesai: json['TGL_SELESAI'].toString(),
      judul: json['JUDUL'].toString(),
      gambarberita: json['GAMBAR_BERITA'].toString(),
      deskripsi: json['DESKRIPSI'].toString(),
      idadmin: json['ID_ADMIN'],
    );
  }
}
