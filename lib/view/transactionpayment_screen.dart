import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/components/progress_hud.dart';
import 'package:cherryticketmobile/components/uploadtransaksi.dart';
import 'package:cherryticketmobile/providerAPI/api_service.dart';
import 'package:cherryticketmobile/providerAPI/jawabanpendaftaran.dart';
import 'package:cherryticketmobile/view/list/order_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionPayment extends StatefulWidget {
  final String logo;
  final String method;
  final String number;
  const TransactionPayment(this.logo, this.number, this.method, {Key key})
      : super(key: key);

  @override
  State<TransactionPayment> createState() => _TransactionPaymentState();
}

class _TransactionPaymentState extends State<TransactionPayment>
    with SingleTickerProviderStateMixin {
  NumberFormat currencyFormatter;
  bool isApiCallProcess = false;
  bool button = true;
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
    return ProgressHUD(
        child: _upInit(context), inAsyncCall: isApiCallProcess, opacity: 0.3);
  }

  Widget _upInit(BuildContext context) {
    return Scaffold(
        backgroundColor: gray,
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                backgroundColor: indigo,
                pinned: true,
                title: Text("Payment"),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Container(
                          color: gray,
                          child: Image.network(
                            widget.logo,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Spacer(),
                        Text(widget.number,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: indigo,
                                fontWeight: FontWeight.w600,
                                fontSize: 16)),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: widget.number));
                            final snackBar = SnackBar(
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green[800],
                              content: const Text("Number Save To Clipboard"),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child:
                              const Icon(Icons.copy, size: 15, color: cherry),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    color: indigo,
                    indent: 10,
                    endIndent: 10,
                    thickness: 0.3,
                  ),
                  const OrderView(),
                ]),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: indigo,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Transaction',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      )),
                  Text(
                      currencyFormatter
                          .format(Provider.of<JawabanPendaftaran>(context)
                              .jumlahHarga)
                          .toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.payments_sharp,
                  color: indigo,
                  size: 15.0,
                ),
                label: const AutoSizeText(
                  'Pay',
                  style: TextStyle(fontSize: 18, color: indigo),
                  maxLines: 1,
                ),
                onPressed: button
                    ? () {
                        setState(() {
                          isApiCallProcess = true;
                        });
                        APIService apiService = APIService();
                        apiService
                            .createTransaksi(
                                Provider.of<JawabanPendaftaran>(context,
                                        listen: false)
                                    .items,
                                Provider.of<JawabanPendaftaran>(context,
                                        listen: false)
                                    .orders,
                                widget.method)
                            .then((value) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                          if (value['message'] ==
                              'Create Transaction Success') {
                            final snackBar = SnackBar(
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green[800],
                              content: Text("${value['message']}"),
                            );
                            setState(() {
                              button = false;
                            });
                            showDialog<void>(
                                barrierColor: Colors.white.withOpacity(0.1),
                                context: context,
                                builder: (context) {
                                  return UploadTransaksi(
                                      value['data']['BUKTI_PEMBAYARAN']
                                                  .toString() ==
                                              'null'
                                          ? image + '/GambarPeserta/default.png'
                                          : image +
                                              '/GambarTransaksi/' +
                                              value['data']['BUKTI_PEMBAYARAN'],
                                      value['data']['ID_TRANSAKSI']);
                                });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            final snackBar = SnackBar(
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red[800],
                              content: Text("${value['message']}"),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  primary: gray,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
