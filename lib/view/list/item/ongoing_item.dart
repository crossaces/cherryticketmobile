import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/model/pendaftaran_model.dart';
import 'package:cherryticketmobile/view/googlemap.dart';
import 'package:cherryticketmobile/view/roomevent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OngoingItem extends StatefulWidget {
  final Pendaftaranpeserta data;
  final double lng;
  final double lat;
  const OngoingItem(this.data, this.lng, this.lat, {Key key}) : super(key: key);

  @override
  State<OngoingItem> createState() => _OngoingItemState();
}

class _OngoingItemState extends State<OngoingItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        Visibility(
                          visible: widget.data.event.modeevent != 'Offline'
                              ? true
                              : false,
                          child: Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.link,
                                  color: white,
                                  size: 16.0,
                                ),
                                label: const AutoSizeText(
                                  'Link',
                                  style: TextStyle(fontSize: 14, color: white),
                                  maxLines: 1,
                                ),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: widget.data.event.url));
                                  final snackBar = SnackBar(
                                    duration: const Duration(seconds: 1),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.green[800],
                                    content:
                                        const Text("Link Save To Clipboard"),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: widget.data.event.modeevent != 'Offline' &&
                                    widget.data.event.modeevent != 'Online'
                                ? true
                                : false,
                            child: const SizedBox(
                              width: 10,
                            )),
                        Visibility(
                          visible: widget.data.event.modeevent != 'Online'
                              ? true
                              : false,
                          child: Expanded(
                            flex: 1,
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.location_on,
                                color: white,
                                size: 16.0,
                              ),
                              label: const AutoSizeText(
                                'Location',
                                style: TextStyle(fontSize: 14, color: white),
                                maxLines: 1,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GoogleMapScreen(
                                          widget.lat,
                                          widget.lng,
                                          widget.data.event.idevent,
                                          widget.data.event.lat,
                                          widget.data.event.lng)),
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
                            visible: widget.data.event.modeevent != 'Online'
                                ? true
                                : false,
                            child: const SizedBox(
                              width: 10,
                            )),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.house,
                              color: white,
                              size: 16.0,
                            ),
                            label: const AutoSizeText(
                              'Go Room',
                              style: TextStyle(fontSize: 14, color: white),
                              maxLines: 1,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RoomEvent(
                                        widget.data, widget.lng, widget.lat)),
                              );
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
