import 'package:cherryticketmobile/model/tiket_model.dart';
import 'package:cherryticketmobile/providerAPI/transaksi_api.dart';
import 'package:cherryticketmobile/view/list/item/shimer_item.dart';
import 'package:cherryticketmobile/view/list/item/tiket_item.dart';
import 'package:cherryticketmobile/view/list/item/transaksi_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransaksiView extends StatefulWidget {
  const TransaksiView({Key key}) : super(key: key);

  @override
  _TransaksiViewState createState() => _TransaksiViewState();
}

class _TransaksiViewState extends State<TransaksiView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const TransaksiList();
  }
}

class TransaksiList extends StatelessWidget {
  const TransaksiList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataItem = Provider.of<TransaksiApi>(context);
    final data = dataItem.items;
    return SizedBox(
      height: MediaQuery.of(context).size.height - 80,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: data.isNotEmpty
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        itemCount: data.isNotEmpty ? data.length : 6,
        itemBuilder: data.isNotEmpty
            ? (ctx, i) => TransaksiItem(data[i])
            : (ctx, i) => const ShimmerItem(190, 220),
      ),
    );
  }
}
