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
    final dataLists = Provider.of<JawabanPendaftaran>(context, listen: false);
    final data = dataLists.items ?? [];

    return CarouselSlider.builder(
      options: CarouselOptions(
          height: 25,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          viewportFraction: 0.55,
          onPageChanged: (index, reason) {
            Provider.of<JawabanPendaftaran>(context, listen: false)
                .initCheck(true);
            Provider.of<JawabanPendaftaran>(context, listen: false)
                .changeindex(index);
          }),
      itemCount: data.isNotEmpty ? data.length : 6,
      itemBuilder: data.isNotEmpty
          ? (context, index, realindex) => DataPesertaItem(data[index], index)
          : (context, index, realindex) => const ShimmerItem(40, 200),
    );
  }
}
