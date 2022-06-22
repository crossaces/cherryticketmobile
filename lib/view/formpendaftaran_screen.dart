import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/paymentmehotd.dart';
import 'package:cherryticketmobile/providerAPI/jawabanpendaftaran.dart';
import 'package:cherryticketmobile/view/list/datapeserta_list.dart';
import 'package:cherryticketmobile/view/list/pertanyaan_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FPendaftaranScreen extends StatefulWidget {
  const FPendaftaranScreen({Key key}) : super(key: key);

  @override
  State<FPendaftaranScreen> createState() => _FPendaftaranScreenState();
}

class _FPendaftaranScreenState extends State<FPendaftaranScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController pertanyaan = TextEditingController(text: "");
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
    return Scaffold(
        backgroundColor: gray,
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                backgroundColor: indigo,
                pinned: true,
                title: Text("Form Register"),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(
                    height: 10,
                  ),
                  const DataPesertaView(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: indigo,
                    indent: 10,
                    endIndent: 10,
                    thickness: 1,
                  ),
                  const PertanyaanView()
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
                onPressed: () {
                  showDialog<void>(
                      barrierColor: Colors.white.withOpacity(0.1),
                      context: context,
                      builder: (context) {
                        return const PaymentMethod();
                      });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
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
