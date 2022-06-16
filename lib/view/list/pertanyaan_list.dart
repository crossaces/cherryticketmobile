import 'package:cherryticketmobile/model/formpendaftaran_model.dart';
import 'package:cherryticketmobile/providerAPI/jawabanpendaftaran.dart';
import 'package:cherryticketmobile/view/list/item/pertanyaan_item.dart';
import 'package:cherryticketmobile/view/list/item/shimer_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PertanyaanView extends StatefulWidget {
  const PertanyaanView({Key key}) : super(key: key);

  @override
  _PertanyaanViewState createState() => _PertanyaanViewState();
}

class _PertanyaanViewState extends State<PertanyaanView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const PertanyaanList();
  }
}

class PertanyaanList extends StatefulWidget {
  const PertanyaanList({
    Key key,
  }) : super(key: key);

  @override
  State<PertanyaanList> createState() => _PertanyaanListState();
}

class _PertanyaanListState extends State<PertanyaanList> {
  @override
  Widget build(BuildContext context) {
    List<Pertanyaan> pertanyaan = Provider.of<JawabanPendaftaran>(context)
        .returnPertanyaan(Provider.of<JawabanPendaftaran>(context).i);

    return SizedBox(
      height: MediaQuery.of(context).size.height - 160,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: pertanyaan.isNotEmpty
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        itemCount: pertanyaan.isNotEmpty ? pertanyaan.length : 6,
        itemBuilder: pertanyaan.isNotEmpty
            ? (ctx, index) => PertanyaanItem(index, pertanyaan[index])
            : (ctx, i) => const ShimmerItem(190, 220),
      ),
    );
  }
}
