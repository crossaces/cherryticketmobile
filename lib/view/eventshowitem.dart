import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/formpendaftaran_model.dart';
import 'package:cherryticketmobile/providerAPI/event_api.dart';
import 'package:cherryticketmobile/providerAPI/form_pendaftaran_api.dart';
import 'package:cherryticketmobile/view/googlemap.dart';
import 'package:cherryticketmobile/view/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:html/dom.dart' as dom;
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EventShowItem extends StatefulWidget {
  final int idevent;
  const EventShowItem(this.idevent, {Key key}) : super(key: key);

  @override
  State<EventShowItem> createState() => _EventShowItemState();
}

class _EventShowItemState extends State<EventShowItem>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  Location _location;
  Formpendaftaran data;
  double lat;
  double lng;
  @override
  void initState() {
    Provider.of<FormPendaftaranAPI>(context, listen: false)
        .fetch(widget.idevent);
    tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    setState(() {
      _location = Location();
    });
    _location.onLocationChanged.listen((event) {
      setState(() {
        lng = event.longitude;
        lat = event.latitude;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loadEvent =
        Provider.of<EventAPI>(context, listen: false).findById(widget.idevent);
    return Scaffold(
        backgroundColor: gray,
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: indigo,
                expandedHeight: 220,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: loadEvent.gambarevent,
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              scale: 2,
                              fit: BoxFit.fill,
                              image: NetworkImage(image +
                                  '/GambarEvent/' +
                                  loadEvent.gambarevent)),
                        )),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: AutoSizeText(loadEvent.namaevent,
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
                        loadEvent.namajenis +
                            ', ' +
                            loadEvent.namagenre +
                            ', ' +
                            loadEvent.modeevent,
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
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                child: const AutoSizeText('Date & Time',
                                    textAlign: TextAlign.left,
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: indigo)),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.calendar_today_outlined,
                                      color: Colors.black45,
                                      size: 13,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    AutoSizeText(
                                        (DateFormat("dd MMM yyy")
                                                .format(DateTime.parse(
                                                    loadEvent.tglacaramulai))
                                                .toString()) +
                                            (loadEvent.tglacaraselesai
                                                        .toString() ==
                                                    'null'
                                                ? ""
                                                : " - " +
                                                    DateFormat("dd MMM yyy")
                                                        .format(DateTime.parse(
                                                            loadEvent
                                                                .tglacaraselesai))
                                                        .toString()),
                                        textAlign: TextAlign.left,
                                        softWrap: true,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                            color: Colors.black45)),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.access_time_outlined,
                                      color: Colors.black45,
                                      size: 13,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    AutoSizeText(
                                        loadEvent.waktumulai.substring(0, 5) +
                                            ' - ' +
                                            loadEvent.waktuselesai
                                                .substring(0, 5),
                                        textAlign: TextAlign.left,
                                        softWrap: true,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                            color: Colors.black45)),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: gray,
                                child: const AutoSizeText('Venue & Location',
                                    textAlign: TextAlign.left,
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: indigo)),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                color: gray,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.black45,
                                      size: 13,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        color: gray,
                                        width: 150,
                                        child: AutoSizeText(
                                            loadEvent.namakota +
                                                ', ' +
                                                loadEvent.namalokasi,
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            maxLines: 5,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color: Colors.black45))),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ))
                    ],
                  ),
                  TabBar(
                      indicatorColor: cherry,
                      unselectedLabelColor: indigo,
                      labelColor: cherry,
                      tabs: const [
                        Tab(text: 'Description'),
                        Tab(
                          text: 'Terms and conditions',
                        )
                      ],
                      controller: tabController),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          width: double.infinity,
                          child: Html(
                            customTextAlign: (_) => TextAlign.justify,
                            useRichText: true,
                            linkStyle: const TextStyle(
                              color: cherry,
                            ),
                            data: loadEvent.deskripsi.toString() == null
                                ? "No Description"
                                : loadEvent.deskripsi,
                            onLinkTap: (url) {
                              launch(url);
                            },
                            customTextStyle:
                                // ignore: missing_return
                                (dom.Node node, TextStyle baseStyle) {
                              if (node is dom.Element) {
                                switch (node.localName) {
                                  case 'h1':
                                    return baseStyle.merge(const TextStyle(
                                      fontSize: 20,
                                      color: cherry,
                                      fontWeight: FontWeight.bold,
                                    ));
                                  case 'p':
                                    return baseStyle.merge(const TextStyle(
                                      fontSize: 13,
                                      color: indigo,
                                      fontWeight: FontWeight.w600,
                                    ));
                                  case 'h2':
                                    return baseStyle.merge(const TextStyle(
                                      fontSize: 18,
                                      color: cherry,
                                      fontWeight: FontWeight.w900,
                                    ));
                                  case 'h3':
                                    return baseStyle.merge(const TextStyle(
                                      fontSize: 16,
                                      color: cherry,
                                      fontWeight: FontWeight.w700,
                                    ));
                                }
                              }
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          width: double.infinity,
                          child: Html(
                            customTextAlign: (_) => TextAlign.justify,
                            useRichText: true,
                            linkStyle: const TextStyle(
                              color: cherry,
                            ),
                            data: loadEvent.deskripsi.toString() == null
                                ? "No terms and conditions"
                                : loadEvent.syarat,
                            onLinkTap: (url) {
                              launch(url);
                            },
                            customTextStyle:
                                // ignore: missing_return
                                (dom.Node node, TextStyle baseStyle) {
                              if (node is dom.Element) {
                                switch (node.localName) {
                                  case 'h1':
                                    return baseStyle.merge(const TextStyle(
                                      fontSize: 20,
                                      color: cherry,
                                      fontWeight: FontWeight.bold,
                                    ));
                                  case 'p':
                                    return baseStyle.merge(const TextStyle(
                                      fontSize: 13,
                                      color: indigo,
                                      fontWeight: FontWeight.w600,
                                    ));
                                  case 'h2':
                                    return baseStyle.merge(const TextStyle(
                                      fontSize: 18,
                                      color: cherry,
                                      fontWeight: FontWeight.w900,
                                    ));
                                  case 'h3':
                                    return baseStyle.merge(const TextStyle(
                                      fontSize: 16,
                                      color: cherry,
                                      fontWeight: FontWeight.w700,
                                    ));
                                }
                              }
                            },
                          ),
                        ),
                      ],
                      controller: tabController,
                    ),
                  )
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
              Visibility(
                visible: loadEvent.modeevent != 'Online' ? true : false,
                child: Expanded(
                  flex: 1,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.location_on,
                      color: white,
                      size: 15.0,
                    ),
                    label: const AutoSizeText(
                      'Location',
                      style: TextStyle(fontSize: 18, color: white),
                      maxLines: 1,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GoogleMapScreen(
                                lat,
                                lng,
                                loadEvent.idevent,
                                loadEvent.lat,
                                loadEvent.lng)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: cherry,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: loadEvent.modeevent != 'Online' ? true : false,
                child: const SizedBox(
                  width: 10,
                ),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.phone_android,
                    color: white,
                    size: 15.0,
                  ),
                  label: const AutoSizeText(
                    'Phone',
                    style: TextStyle(fontSize: 18, color: white),
                    maxLines: 1,
                  ),
                  onPressed: () {
                    String url = "https://wa.me/" +
                        loadEvent.numberphone +
                        "/?text=Hello";
                    launch(url);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.payments_sharp,
                    color: indigo,
                    size: 15.0,
                  ),
                  label: const AutoSizeText(
                    'Ticket',
                    style: TextStyle(fontSize: 18, color: indigo),
                    maxLines: 1,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TicketScreen(loadEvent.tiket)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: gray,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
