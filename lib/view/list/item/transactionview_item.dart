import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderTransaksiItem extends StatefulWidget {
  final OrderTransaksi data;

  const OrderTransaksiItem(this.data, {Key key}) : super(key: key);

  @override
  State<OrderTransaksiItem> createState() => _OrderTransaksiItemState();
}

class _OrderTransaksiItemState extends State<OrderTransaksiItem> {
  NumberFormat currencyFormatter;

  @override
  void initState() {
    setState(() {
      currencyFormatter = NumberFormat.currency(
        locale: 'id',
        symbol: 'Rp.',
        decimalDigits: 2,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AutoSizeText(
            widget.data.jumlah.toString() +
                ' ' +
                widget.data.namatiket +
                ' ' +
                currencyFormatter.format(widget.data.subtotal).toString(),
            textAlign: TextAlign.left,
            softWrap: true,
            maxLines: 2,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 12, color: indigo)),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
