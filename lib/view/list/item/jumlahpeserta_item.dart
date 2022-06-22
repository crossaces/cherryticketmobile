import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/model/formpendaftaran_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataPesertaItem extends StatefulWidget {
  final int index;
  final Jawaban data;
  const DataPesertaItem(this.data, this.index, {Key key}) : super(key: key);

  @override
  _DataPesertaItemState createState() => _DataPesertaItemState();
}

class _DataPesertaItemState extends State<DataPesertaItem> {
  bool color;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: cherry,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: AutoSizeText(
                  "Participant Ticket"
                          ' - ' +
                      widget.data.namatiket,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600, color: white),
                ),
              ),
            )));
  }
}
