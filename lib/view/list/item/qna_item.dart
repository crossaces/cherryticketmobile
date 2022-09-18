import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/model/qna_model.dart';
import 'package:flutter/material.dart';

class QnaItem extends StatefulWidget {
  final Qna data;
  const QnaItem(this.data, {Key key}) : super(key: key);

  @override
  State<QnaItem> createState() => _QnaItemState();
}

class _QnaItemState extends State<QnaItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 25,
      padding: const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        color: gray,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            widget.data.namapeserta,
            style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          AutoSizeText(
            widget.data.pertanyaan,
            style: const TextStyle(
                fontSize: 15, color: indigo, fontWeight: FontWeight.w600),
          ),
          const Divider(
            color: Colors.black45,
          ),
        ],
      ),
    );
  }
}
