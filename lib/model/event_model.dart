class Event {
  final int idevent;
  final String eventtab;
  final String namaevent;
  final String tglmulai;
  final String tglselesai;
  final String tglacaramulai;
  final String tglacaraselesai;
  final String waktuselesai;
  final String waktumulai;
  final String statusevent;
  final int totaltiketberedar;
  final String visibleevent;
  final bool sertifikat;
  final bool evaluasi;
  final String modeevent;
  final String namalokasi;
  final double lng;
  final double lat;
  final String url;
  final String qrcode;
  final String deskripsi;
  final String token;
  final bool qna;
  final String syarat;
  final int batastiket;
  final String komentar;
  final String gambarevent;
  final int idjenisacara;
  final int idkota;
  final int ideo;
  final int idgenre;

  Event({
    this.idevent,
    this.eventtab,
    this.namaevent,
    this.tglmulai,
    this.tglselesai,
    this.tglacaramulai,
    this.tglacaraselesai,
    this.waktumulai,
    this.waktuselesai,
    this.statusevent,
    this.totaltiketberedar,
    this.visibleevent,
    this.sertifikat,
    this.evaluasi,
    this.modeevent,
    this.namalokasi,
    this.lat,
    this.lng,
    this.url,
    this.qrcode,
    this.token,
    this.qna,
    this.batastiket,
    this.komentar,
    this.idjenisacara,
    this.idkota,
    this.idgenre,
    this.ideo,
    this.syarat,
    this.deskripsi,
    this.gambarevent,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      idevent: json['ID_EVENT'],
      eventtab: json['EVENT_TAB'].toString(),
      namaevent: json['NAMA_EVENT'].toString(),
      tglmulai: json['TGL_MULAI'].toString(),
      tglselesai: json['TGL_SELESAI'].toString(),
      tglacaramulai: json['TGL_ACARA_MULAI'].toString(),
      tglacaraselesai: json['TGL_ACARA_SELESAI'].toString(),
      waktumulai: json['WAKTU_MULAI'].toString(),
      waktuselesai: json['WAKTU_SELESAI'].toString(),
      statusevent: json['STATUS_EVENT'].toString(),
      totaltiketberedar: json['TOTAL_TIKET_BEREDAR'],
      visibleevent: json['VISIBLE_EVENT'],
      sertifikat: json['SERTIFIKAT'],
      evaluasi: json['EVALUASI'],
      modeevent: json['MODE_EVENT'].toString(),
      namalokasi: json['NAMA_LOKASI'].toString(),
      lng: json['LNG'],
      lat: json['LAT'],
      url: json['URL'].toString(),
      qrcode: json['QRCODE'].toString(),
      token: json['TOKEN'].toString(),
      qna: json['QNA'],
      batastiket: json['BATAS_TIKET'],
      komentar: json['KOMENTAR'].toString(),
    );
  }
}
