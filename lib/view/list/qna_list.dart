import 'package:cherryticketmobile/providerAPI/qna_api.dart';
import 'package:cherryticketmobile/view/list/item/qna_item.dart';
import 'package:cherryticketmobile/view/list/item/shimer_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'item/qna_item.dart';

class QnaView extends StatefulWidget {
  const QnaView({Key key}) : super(key: key);

  @override
  _QnaViewState createState() => _QnaViewState();
}

class _QnaViewState extends State<QnaView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const QnaList();
  }
}

class QnaList extends StatelessWidget {
  const QnaList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final qnaItem = Provider.of<QnaAPI>(context);
    final qna = qnaItem.items;
    return SizedBox(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: qna.isNotEmpty
            ? const ClampingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        itemCount: qna.isNotEmpty ? qna.length : 6,
        itemBuilder: qna.isNotEmpty
            ? (ctx, i) => QnaItem(qna[i])
            : (ctx, i) => const ShimmerItem(190, 220),
      ),
    );
  }
}
