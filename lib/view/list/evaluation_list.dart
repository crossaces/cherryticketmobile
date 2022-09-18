import 'package:cherryticketmobile/providerAPI/form_evaluasi_api.dart';
import 'package:cherryticketmobile/view/list/item/evaluation_item.dart';
import 'package:cherryticketmobile/view/list/item/shimer_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EvaluationView extends StatefulWidget {
  const EvaluationView({Key key}) : super(key: key);

  @override
  _EvaluationViewState createState() => _EvaluationViewState();
}

class _EvaluationViewState extends State<EvaluationView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const EvaluationList();
  }
}

class EvaluationList extends StatefulWidget {
  const EvaluationList({
    Key key,
  }) : super(key: key);

  @override
  State<EvaluationList> createState() => _EvaluationListState();
}

class _EvaluationListState extends State<EvaluationList> {
  @override
  Widget build(BuildContext context) {
    final pertanyaan =
        Provider.of<FormEvaluasiAPI>(context).items.datapertanyaan;
    return SizedBox(
      height: MediaQuery.of(context).size.height - 160,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: pertanyaan.isNotEmpty
            ? const ClampingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        itemCount: pertanyaan.isNotEmpty ? pertanyaan.length : 6,
        itemBuilder: pertanyaan.isNotEmpty
            ? (ctx, index) => EvaluationItem(index, pertanyaan[index])
            : (ctx, i) => const ShimmerItem(190, 220),
      ),
    );
  }
}
