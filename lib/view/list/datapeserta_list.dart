import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cherryticketmobile/providerAPI/jawabanpendaftaran.dart';
import 'package:cherryticketmobile/view/list/item/jumlahpeserta_item.dart';
import 'package:cherryticketmobile/view/list/item/shimer_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataPesertaView extends StatefulWidget {
  const DataPesertaView({Key key}) : super(key: key);

  @override
  _DataPesertaViewState createState() => _DataPesertaViewState();
}

class _DataPesertaViewState extends State<DataPesertaView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const DataPesertaList();
  }
}

class DataPesertaList extends StatefulWidget {
  const DataPesertaList({Key key}) : super(key: key);

  @override
  _DataPesertaListState createState() => _DataPesertaListState();
}

class _DataPesertaListState extends State<DataPesertaList> {
  @override
  @override
  Widget build(BuildContext context) {
    final dataLists = Provider.of<JawabanPendaftaran>(context);
    final data = dataLists.items.length;

    return CarouselSlider.builder(
        options: CarouselOptions(
            reverse: true,
            height: 25,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            viewportFraction: 0.55,
            onPageChanged: (index, reason) {
              Provider.of<JawabanPendaftaran>(context, listen: false)
                  .initCheck(true);
              Provider.of<JawabanPendaftaran>(context, listen: false)
                  .changeindex(index);
              print(index);
              print(Provider.of<JawabanPendaftaran>(context, listen: false)
                  .returnJawaban(index)[0]
                  .jawaban);
              print(Provider.of<JawabanPendaftaran>(context, listen: false)
                  .returnJawaban(index)[1]
                  .jawaban);
            }),
        itemCount: data,
        itemBuilder: (context, index, realindex) => DataPesertaItem(index));
  }
}
