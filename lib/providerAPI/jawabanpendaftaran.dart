import 'package:cherryticketmobile/model/formpendaftaran_model.dart';

import 'package:flutter/material.dart';

class JawabanPendaftaran with ChangeNotifier {
  List<Jawaban> _items = [];
  int index = 0;
  bool check = false;

  void initCheck(bool init) {
    check = init;
    notifyListeners();
  }

  bool get checks {
    return check;
  }

  void initIndex() {
    index = 0;
    notifyListeners();
  }

  void changeindex(int i) {
    index = i;
    notifyListeners();
  }

  void initFormPeserta(List<Jawaban> test) {
    _items = test;
  }

  int get i {
    return index;
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

  List<Pertanyaan> returnJawaban(int i) {
    // print(indexform.toString() +
    //     '-' +
    //     indexquestion.toString() +
    //     _items[indexform].datapertanyaan[indexquestion].jawaban);
    return _items[i].datapertanyaan;
  }

  void isiPertanyaan(int i, int j, String value) {
    // print(_items[indexform].datapertanyaan[indexquestion].pertanyaan);
    // print(indexform.toString() + '-' + indexquestion.toString());
    notifyListeners();
    _items[i].datapertanyaan[j].jawaban = value;
  }

  void addFormPeserta(Jawaban data) {
    _items.add(data);
    notifyListeners();
  }

  void removeFormPeserta(int idtiket) {
    _items.removeAt(_items.indexWhere((form) => form.idtiket == idtiket));
    notifyListeners();
  }

  List<Jawaban> get items {
    return _items;
  }
}
