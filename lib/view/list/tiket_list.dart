import 'package:cherryticketmobile/model/tiket_model.dart';
import 'package:cherryticketmobile/view/list/item/shimer_item.dart';
import 'package:cherryticketmobile/view/list/item/tiket_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TiketView extends StatefulWidget {
  final List<Tiket> data;
  const TiketView(this.data, {Key key}) : super(key: key);

  @override
  _TiketViewState createState() => _TiketViewState();
}

class _TiketViewState extends State<TiketView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Tiketist(widget.data);
  }
}

class Tiketist extends StatelessWidget {
  final List<Tiket> data;
  const Tiketist(
    this.data, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 160,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: data.isNotEmpty
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        itemCount: data.isNotEmpty ? data.length : 6,
        itemBuilder: data.isNotEmpty
            ? (ctx, i) => TiketItem(data[i])
            : (ctx, i) => const ShimmerItem(190, 220),
      ),
    );
  }
}
