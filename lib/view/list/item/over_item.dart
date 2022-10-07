import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/pendaftaran_model.dart';
import 'package:cherryticketmobile/providerAPI/peserta_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OverItem extends StatefulWidget {
  final Pendaftaranpeserta data;
  final double lng;
  final double lat;
  const OverItem(this.data, this.lng, this.lat, {Key key}) : super(key: key);

  @override
  State<OverItem> createState() => _OverItemState();
}

class _OverItemState extends State<OverItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataPeserta = Provider.of<PesertaAPI>(context);
    final data = dataPeserta.items;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: gray,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 6), // changes position of shadow
          ),
        ],
      ),
      child: Hero(
        tag: widget.data.event.gambarevent,
        child: Column(
          children: [
            Container(
              width: 400,
              height: 200,
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
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8),
                      child: AutoSizeText(widget.data.event.namaevent,
                          textAlign: TextAlign.left,
                          softWrap: true,
                          maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 30,
                              color: cherry)),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8),
                      child: AutoSizeText(
                          widget.data.event.namajenis +
                              ', ' +
                              widget.data.event.namagenre +
                              ', ' +
                              widget.data.event.modeevent,
                          textAlign: TextAlign.left,
                          softWrap: true,
                          maxLines: 2,
                          style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              color: Colors.black45)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.card_membership_outlined,
                              color: white,
                              size: 16.0,
                            ),
                            label: const AutoSizeText(
                              'Certificate',
                              style: TextStyle(fontSize: 14, color: white),
                              maxLines: 1,
                            ),
                            onPressed: () {
                              launch('https://cherryticket.com/api/generate/' +
                                  widget.data.event.idsertifikat.toString() +
                                  '/' +
                                  data.namadepan +
                                  ' ' +
                                  data.namabelakang);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: indigo,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
