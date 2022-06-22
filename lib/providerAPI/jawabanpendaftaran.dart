import 'package:cherryticketmobile/model/formpendaftaran_model.dart';

import 'package:flutter/material.dart';

class JawabanPendaftaran with ChangeNotifier {
  List<Jawaban> _items = [];
  int index = 0;
  bool check = false;
  List<Order> order = [];

  void initCheck(bool init) {
    check = init;
    notifyListeners();
  }

  bool get checks {
    return check;
  }

  List<Order> get orders {
    return order;
  }

  void initIndex() {
    index = 0;
    notifyListeners();
  }

  int get jumlahHarga {
    int harga = 0;
    for (var i = 0; i < _items.length; i++) {
      harga += _items[i].harga;
    }

    return harga;
  }

  void changeindex(int i) {
    index = i;
    notifyListeners();
  }

  void initFormPeserta(List<Jawaban> test) {
    _items = test;
    order = [];
  }

  int get i {
    return index;
  }

  List<Pertanyaan> returnDataPertanyaan() {
    return _items[i].datapertanyaan;
  }

  List<Pertanyaan> returnPertanyaan(int i) {
    return _items[i].datapertanyaan;
  }

  Pertanyaan returnPertanyaanDetail(int i, int index) {
    return _items[i].datapertanyaan[index];
  }

  String returnIDPESERTA(int indexform) {
    return _items[indexform].idpeserta.toString() == '0'
        ? ""
        : _items[indexform].idpeserta.toString();
  }

  void addIDPESERTA(int indexform, int value) {
    _items[indexform].idpeserta = value;
    notifyListeners();
  }

  String returnJawaban(int indexform, int index) {
    return _items[indexform].datapertanyaan[index].jawaban == ""
        ? ""
        : _items[indexform].datapertanyaan[index].jawaban;
  }

  void addPertanyaan(Pertanyaan value) {
    _items[i].datapertanyaan.add(value);
    notifyListeners();
  }

  void isiPertanyaan(int indexquestion, String value) {
    _items[i].datapertanyaan[indexquestion].jawaban = value;
    notifyListeners();
  }

  void addFormPeserta(Jawaban data) {
    if (order.firstWhere((element) => element.idtiket == data.idtiket,
            orElse: () => null) ==
        null) {
      order.add(Order(
          jumlah: 1,
          idtiket: data.idtiket,
          subtotal: data.harga,
          harga: data.harga,
          namatiket: data.namatiket,
          fasilitas: data.fasilitas));
    } else {
      order
          .firstWhere((element) => element.idtiket == data.idtiket,
              orElse: () => null)
          .jumlah++;
      order.firstWhere((element) => element.idtiket == data.idtiket).subtotal =
          order
                  .firstWhere((element) => element.idtiket == data.idtiket)
                  .subtotal +
              data.harga;
    }
    _items.add(data);
    notifyListeners();
  }

  void removeFormPeserta(int idtiket) {
    if (order.firstWhere((element) => element.idtiket == idtiket).jumlah == 1) {
      order.removeAt(order.indexWhere((tiket) => tiket.idtiket == idtiket));
    } else {
      order
          .firstWhere((element) => element.idtiket == idtiket,
              orElse: () => null)
          .jumlah--;
      order.firstWhere((element) => element.idtiket == idtiket).subtotal =
          order.firstWhere((element) => element.idtiket == idtiket).subtotal -
              _items.firstWhere((element) => element.idtiket == idtiket).harga;
    }
    _items.removeAt(_items.indexWhere((form) => form.idtiket == idtiket));
    notifyListeners();
  }

  List<Jawaban> get items {
    return _items;
  }
}
