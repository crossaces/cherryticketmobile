class Formpendaftaran {
  final int idformpendaftaran;
  List<Pertanyaan> datapertanyaan;
  final int idevent;

  Formpendaftaran({this.idformpendaftaran, this.datapertanyaan, this.idevent});

  factory Formpendaftaran.fromJson(Map<String, dynamic> json) {
    return Formpendaftaran(
        idformpendaftaran: json['ID_FORM_PENDAFTARAN'],
        idevent: json['ID_EVENT'],
        datapertanyaan: json['DATA_PERTANYAAN'] == null
            ? null
            : List<Pertanyaan>.from(
                    json["DATA_PERTANYAAN"].map((x) => Pertanyaan.fromJson(x)))
                .toList());
  }
}

class Options {
  final String option;

  Options({this.option});

  Map<String, dynamic> toJson() => {
        'OPTION': option,
      };
  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      option: json['OPTION'],
    );
  }
}

class Pertanyaan {
  final String pertanyaan;
  final int nomor;
  String jawaban;
  final String type;
  final List<Options> options;

  Pertanyaan(
      {this.pertanyaan, this.type, this.options, this.jawaban, this.nomor});

  Map<String, dynamic> toJson() => {
        'PERTANYAAN': pertanyaan,
        'NOMOR': nomor,
        'DATA_JAWABAN': jawaban,
        'TYPE': type,
        'OPTIONS': options.map((tag) => tag.toJson()).toList(),
      };

  factory Pertanyaan.fromJson(Map<String, dynamic> json) {
    return Pertanyaan(
        pertanyaan: json['PERTANYAAN'],
        type: json['TYPE'],
        nomor: json['NOMOR'],
        jawaban: "",
        options: List<Options>.from(
            json["OPTIONS"].map((x) => Options.fromJson(x))));
  }
}

class PertanyaanResponse {
  final String pertanyaan;
  final int nomor;
  String jawaban;
  final String type;
  final List<Options> options;

  PertanyaanResponse(
      {this.pertanyaan, this.type, this.options, this.jawaban, this.nomor});

  Map<String, dynamic> toJson() => {
        'PERTANYAAN': pertanyaan,
        'NOMOR': nomor,
        'DATA_JAWABAN': jawaban,
        'TYPE': type,
        'OPTIONS': options.map((tag) => tag.toJson()).toList(),
      };

  factory PertanyaanResponse.fromJson(Map<String, dynamic> json) {
    return PertanyaanResponse(
        pertanyaan: json['PERTANYAAN'],
        type: json['TYPE'],
        nomor: json['NOMOR'],
        jawaban: json['DATA_JAWABAN'],
        options: List<Options>.from(
            json["OPTIONS"].map((x) => Options.fromJson(x))));
  }
}

class Jawaban {
  int nomor;
  int idpeserta;
  int idevent;
  final int harga;
  List<Pertanyaan> datapertanyaan;
  final int idtiket;
  final String fasilitas;
  final String namatiket;
  Jawaban(
      {this.idpeserta,
      this.idevent,
      this.fasilitas,
      this.datapertanyaan,
      this.idtiket,
      this.nomor,
      this.namatiket,
      this.harga});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'IDPESERTA': idpeserta.toString(),
      'IDEVENT': idevent.toString(),
      'JAWABAN': datapertanyaan.map((tag) => tag.toJson()).toList(),
      'IDTIKET': idtiket.toString()
    };

    return map;
  }
}

class Order {
  int jumlah;
  int subtotal;
  int idtiket;
  int harga;
  String namatiket;
  String fasilitas;
  Order(
      {this.jumlah,
      this.idtiket,
      this.harga,
      this.subtotal,
      this.namatiket,
      this.fasilitas});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'JUMLAH': jumlah,
      'SUBTOTAL': subtotal,
      'ID_TIKET': idtiket
    };
    return map;
  }
}
