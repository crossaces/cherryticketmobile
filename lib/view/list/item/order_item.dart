import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/model/formpendaftaran_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatefulWidget {
  final Order data;

  const OrderItem(this.data, {Key key}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  NumberFormat currencyFormatter;
  @override
  void initState() {
    setState(() {
      currencyFormatter = NumberFormat.currency(
        locale: 'id',
        symbol: 'Rp ',
        decimalDigits: 2,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 25,
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            widget.data.namatiket,
            style: const TextStyle(
                color: cherry, fontSize: 14, fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 5,
          ),
          AutoSizeText(
            widget.data.fasilitas,
            style: const TextStyle(
                color: indigo, fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const Divider(
            height: 20,
            thickness: 0.8,
            indent: 0,
            endIndent: 0,
            color: divider,
          ),
          Row(
            children: [
              AutoSizeText(
                currencyFormatter.format(widget.data.subtotal).toString(),
                style: const TextStyle(
                    color: indigo, fontSize: 14, fontWeight: FontWeight.w800),
              ),
              const Spacer(),
              AutoSizeText(
                widget.data.jumlah.toString() + ' Ticket',
                style: const TextStyle(
                    color: indigo, fontSize: 14, fontWeight: FontWeight.w800),
              ),
            ],
          )
        ],
      ),
    );
  }
}
