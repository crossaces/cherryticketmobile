import 'package:cherryticketmobile/providerAPI/pendaftaran_api.dart';
import 'package:cherryticketmobile/view/list/item/over_item.dart';
import 'package:cherryticketmobile/view/list/item/shimer_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverView extends StatefulWidget {
  final double lng;
  final double lat;
  const OverView(this.lng, this.lat, {Key key}) : super(key: key);

  @override
  _OverViewState createState() => _OverViewState();
}

class _OverViewState extends State<OverView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverList(widget.lng, widget.lat);
  }
}

class OverList extends StatelessWidget {
  final double lng;
  final double lat;
  const OverList(
    this.lng,
    this.lat, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataItem = Provider.of<PendaftaranpesertaAPI>(context);
    final data = dataItem.over;
    return SizedBox(
      height: MediaQuery.of(context).size.height - 19,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: data.isNotEmpty
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        itemCount: data.isNotEmpty ? data.length : 6,
        itemBuilder: data.isNotEmpty
            ? (ctx, i) => OverItem(data[i], lng, lat)
            : (ctx, i) => const ShimmerItem(190, 220),
      ),
    );
  }
}
