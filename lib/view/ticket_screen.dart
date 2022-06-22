import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/model/tiket_model.dart';
import 'package:cherryticketmobile/providerAPI/jawabanpendaftaran.dart';
import 'package:cherryticketmobile/view/formpendaftaran_screen.dart';
import 'package:cherryticketmobile/view/list/tiket_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicketScreen extends StatefulWidget {
  final List<Tiket> ticket;
  const TicketScreen(this.ticket, {Key key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    Provider.of<JawabanPendaftaran>(context, listen: false).initFormPeserta([]);

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
                title: Text("Ticket"),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  TiketView(widget.ticket),
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
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.payments_sharp,
                  color: indigo,
                  size: 15.0,
                ),
                label: const AutoSizeText(
                  'Choose',
                  style: TextStyle(fontSize: 18, color: indigo),
                  maxLines: 1,
                ),
                onPressed: () {
                  if (Provider.of<JawabanPendaftaran>(context, listen: false)
                      .items
                      .isEmpty) {
                    final snackBar = SnackBar(
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red[800],
                      content: const Text("Minimal one ticket for continue"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FPendaftaranScreen()),
                    );
                  }
                },
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
