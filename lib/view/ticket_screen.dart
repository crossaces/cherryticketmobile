import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/model/tiket_model.dart';

import 'package:cherryticketmobile/view/list/genre_list.dart';
import 'package:cherryticketmobile/view/list/tiket_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicketScreen extends StatefulWidget {
  final List<Tiket> ticket;
  const TicketScreen(this.ticket, {Key key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen>
    with SingleTickerProviderStateMixin {
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
                  'Buy',
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
