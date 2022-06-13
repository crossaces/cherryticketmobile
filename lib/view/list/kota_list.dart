import 'package:cherryticketmobile/providerAPI/kota.dart';
import 'package:cherryticketmobile/view/list/item/kota_item.dart';
import 'package:cherryticketmobile/view/list/item/shimer_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'item/kota_item.dart';

class KotaView extends StatefulWidget {
  const KotaView({Key key}) : super(key: key);

  @override
  _KotaViewState createState() => _KotaViewState();
}

class _KotaViewState extends State<KotaView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const KotaList();
  }
}

class KotaList extends StatelessWidget {
  const KotaList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kotaItem = Provider.of<KotaAPI>(context);
    final kota = kotaItem.items;
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: kota.isNotEmpty
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        itemCount: kota.isNotEmpty ? kota.length : 6,
        itemBuilder: kota.isNotEmpty
            ? (ctx, i) => KotaItem(kota[i])
            : (ctx, i) => const ShimmerItem(150, 220),
      ),
    );
  }
}
