import 'package:cherryticketmobile/providerAPI/jawabanpendaftaran.dart';
import 'package:cherryticketmobile/view/list/item/shimer_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'item/order_item.dart';

class OrderView extends StatefulWidget {
  const OrderView({Key key}) : super(key: key);

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const OrderList();
  }
}

class OrderList extends StatelessWidget {
  const OrderList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderItem = Provider.of<JawabanPendaftaran>(context);
    final order = orderItem.orders;
    return SizedBox(
      height: MediaQuery.of(context).size.height - 120,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: order.isNotEmpty
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        itemCount: order.isNotEmpty ? order.length : 6,
        itemBuilder: order.isNotEmpty
            ? (ctx, i) => OrderItem(order[i])
            : (ctx, i) => const ShimmerItem(190, 220),
      ),
    );
  }
}
