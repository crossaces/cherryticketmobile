import 'package:cherryticketmobile/model/tiket_model.dart';

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
  final int sertifikat;
  final int evaluasi;
  final String modeevent;
  final String namalokasi;
  final double lng;
  final double lat;
  final String url;
  final String qrcode;
  final String deskripsi;
  final int batastransaksi;
  final String token;
  final int qna;
  final String syarat;
  final int batastiket;
  final String komentar;
  final String gambarevent;
  final String namajenis;
  final String namakota;
  final int ideo;
  final String namagenre;
  final String numberphone;
  final List<Tiket> tiket;

  Event({
    this.idevent,
    this.eventtab,
    this.namaevent,
    this.tglmulai,
    this.numberphone,
    this.tglselesai,
    this.tglacaramulai,
    this.tglacaraselesai,
    this.waktumulai,
    this.waktuselesai,
    this.statusevent,
    this.totaltiketberedar,
    this.batastransaksi,
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
    this.namajenis,
    this.namakota,
    this.namagenre,
    this.ideo,
    this.syarat,
    this.tiket,
    this.deskripsi,
    this.gambarevent,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        idevent: json['ID_EVENT'],
        eventtab: json['EVENT_TAB'].toString(),
        namaevent: json['NAMA_EVENT'].toString(),
        gambarevent: json['GAMBAR_EVENT'].toString(),
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
        namajenis: json['jenisacara']['NAMA_JENIS'].toString(),
        namakota: json['kota']['NAMA_KOTA'].toString(),
        namagenre: json['genre']['NAMA_GENRE'].toString(),
        lng: json['LNG'],
        lat: json['LAT'],
        url: json['URL'].toString(),
        qrcode: json['QRCODE'].toString(),
        token: json['TOKEN'].toString(),
        qna: json['QNA'],
        batastiket: json['BATAS_TIKET'],
        batastransaksi: json['BATAS_TRANSAKSI'],
        komentar: json['KOMENTAR'].toString(),
        tiket: List<Tiket>.from(json["tiket"].map((x) => Tiket.fromJson(x))));
  }
}
