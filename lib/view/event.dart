import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/providerAPI/pendaftaran_api.dart';
import 'package:cherryticketmobile/view/list/item/nodata_item.dart';
import 'package:cherryticketmobile/view/list/ongoing_list.dart';
import 'package:cherryticketmobile/view/list/transaksi_list.dart';
import 'package:cherryticketmobile/view/list/upcoming_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key key}) : super(key: key);
  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen>
    with SingleTickerProviderStateMixin {
  Location _location;
  double lat;
  double lng;
  TabController tabController;
  @override
  void initState() {
    setState(() {
      _location = Location();
    });
    _location.onLocationChanged.listen((event) {
      setState(() {
        lng = event.longitude;
        lat = event.latitude;
      });
    });
    tabController = TabController(length: 3, initialIndex: 0, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                TabBar(
                    indicatorColor: cherry,
                    unselectedLabelColor: indigo,
                    labelColor: cherry,
                    tabs: const [
                      Tab(text: 'Upcoming'),
                      Tab(text: 'Ongoing'),
                      Tab(
                        text: 'Complete',
                      )
                    ],
                    controller: tabController),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 120,
                  child: TabBarView(
                    children: [
                      Provider.of<PendaftaranpesertaAPI>(context).cekcomings
                          ? const NoDataItem("Upcoming Event Not Found")
                          : UpcomingView(lng, lat),
                      Provider.of<PendaftaranpesertaAPI>(context).cekgoings
                          ? const NoDataItem("Upcoming Event Not Found")
                          : OngoingView(lng, lat),
                      const TransaksiView()
                    ],
                    controller: tabController,
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
