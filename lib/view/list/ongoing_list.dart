import 'package:cherryticketmobile/providerAPI/pendaftaran_api.dart';
import 'package:cherryticketmobile/view/list/item/ongoing_item.dart';
import 'package:cherryticketmobile/view/list/item/shimer_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OngoingView extends StatefulWidget {
  final double lng;
  final double lat;
  const OngoingView(this.lng, this.lat, {Key key}) : super(key: key);

  @override
  _OngoingViewState createState() => _OngoingViewState();
}

class _OngoingViewState extends State<OngoingView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OngoingList(widget.lng, widget.lat);
  }
}

class OngoingList extends StatelessWidget {
  final double lng;
  final double lat;
  const OngoingList(
    this.lng,
    this.lat, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataItem = Provider.of<PendaftaranpesertaAPI>(context);
    final data = dataItem.going;
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
            ? (ctx, i) => OngoingItem(data[i], lng, lat)
            : (ctx, i) => const ShimmerItem(190, 220),
      ),
    );
  }
}
