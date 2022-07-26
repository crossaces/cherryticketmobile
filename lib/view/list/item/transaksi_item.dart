import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/components/uploadtransaksi.dart';
import 'package:cherryticketmobile/model/transaksi_model.dart';
import 'package:cherryticketmobile/view/list/transactionview_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransaksiItem extends StatefulWidget {
  final Transaksi data;

  const TransaksiItem(this.data, {Key key}) : super(key: key);

  @override
  State<TransaksiItem> createState() => _TransaksiItemState();
}

class _TransaksiItemState extends State<TransaksiItem> {
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
    return Hero(
      tag: widget.data.event.gambarevent,
      child: Column(
        children: [
          Container(
            width: 400,
            height: 200,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: gray,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: SizedBox(
              height: 20,
              width: 20,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  image + '/GambarEvent/' + widget.data.event.gambarevent,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: 400,
            height: 20,
            padding: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: widget.data.statustransaksi == 'Pending' ? cherry : indigo,
            ),
            child: Center(
              child: AutoSizeText(
                widget.data.statustransaksi,
                style: const TextStyle(
                    fontSize: 18, color: white, fontWeight: FontWeight.w600),
                maxLines: 1,
              ),
            ),
          ),
          Container(
            width: 400,
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AutoSizeText('Shopping',
                              textAlign: TextAlign.left,
                              softWrap: true,
                              maxLines: 2,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: indigo)),
                          const SizedBox(height: 5),
                          AutoSizeText(
                            (DateFormat("dd MMM yyy")
                                .format(
                                    DateTime.parse(widget.data.tgltransaksi))
                                .toString()),
                            textAlign: TextAlign.left,
                            softWrap: true,
                            maxLines: 5,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AutoSizeText('Total Transaction',
                              textAlign: TextAlign.left,
                              softWrap: true,
                              maxLines: 2,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: indigo)),
                          const SizedBox(height: 5),
                          AutoSizeText(
                            currencyFormatter
                                .format(widget.data.total)
                                .toString(),
                            textAlign: TextAlign.left,
                            softWrap: true,
                            maxLines: 5,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    color: divider,
                    thickness: 0.9,
                  ),
                  const AutoSizeText('Order',
                      textAlign: TextAlign.left,
                      softWrap: true,
                      maxLines: 2,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: cherry)),
                  OrderTransaksiView(widget.data.order),
                  const Divider(
                    color: divider,
                    thickness: 0.9,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(
                          Icons.payments_sharp,
                          color: white,
                          size: 15.0,
                        ),
                        label: const AutoSizeText(
                          'Pay',
                          style: TextStyle(fontSize: 18, color: white),
                          maxLines: 1,
                        ),
                        onPressed: () {
                          showDialog<void>(
                              barrierColor: Colors.white.withOpacity(0.1),
                              context: context,
                              builder: (context) {
                                return UploadTransaksi(
                                    widget.data.buktipembayaran.toString() ==
                                            'null'
                                        ? image + '/GambarPeserta/default.png'
                                        : image +
                                            '/GambarTransaksi/' +
                                            widget.data.buktipembayaran,
                                    widget.data.idtransaksi);
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          primary: cherry,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
