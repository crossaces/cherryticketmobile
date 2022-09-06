import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/model/formpendaftaran_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DialogPendaftaranItem extends StatefulWidget {
  final PertanyaanResponse data;
  const DialogPendaftaranItem(this.data, {Key key}) : super(key: key);

  @override
  State<DialogPendaftaranItem> createState() => _DialogPendaftaranItemState();
}

class _DialogPendaftaranItemState extends State<DialogPendaftaranItem> {
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
      padding: const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            widget.data.pertanyaan,
            style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          AutoSizeText(
            widget.data.jawaban,
            style: const TextStyle(
                fontSize: 18, color: indigo, fontWeight: FontWeight.w600),
          ),
          const Divider(
            color: Colors.black45,
          ),
        ],
      ),
    );
  }
}
