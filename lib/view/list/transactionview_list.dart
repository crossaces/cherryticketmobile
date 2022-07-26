import 'package:cherryticketmobile/model/order_model.dart';
import 'package:cherryticketmobile/view/list/item/shimer_item.dart';
import 'package:cherryticketmobile/view/list/item/transactionview_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderTransaksiView extends StatefulWidget {
  final List<Order> data;
  const OrderTransaksiView(this.data, {Key key}) : super(key: key);

  @override
  _OrderTransaksiViewState createState() => _OrderTransaksiViewState();
}

class _OrderTransaksiViewState extends State<OrderTransaksiView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrderTransaksiList(widget.data);
  }
}

class OrderTransaksiList extends StatelessWidget {
  final List<Order> data;
  const OrderTransaksiList(
    this.data, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: data.isNotEmpty
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      itemCount: data.isNotEmpty ? data.length : 6,
      itemBuilder: data.isNotEmpty
          ? (ctx, i) => OrderTransaksiItem(data[i])
          : (ctx, i) => const ShimmerItem(190, 220),
    );
  }
}
