import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/view/list/datapeserta_list.dart';
import 'package:cherryticketmobile/view/list/pertanyaan_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FPendaftaranScreen extends StatefulWidget {
  const FPendaftaranScreen({Key key}) : super(key: key);

  @override
  State<FPendaftaranScreen> createState() => _FPendaftaranScreenState();
}

class _FPendaftaranScreenState extends State<FPendaftaranScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
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
                    height: 20,
                  ),
                  const DataPesertaView(),
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
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
