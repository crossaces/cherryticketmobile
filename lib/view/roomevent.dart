import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/addqna_dialog.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/components/dialogdatapendaftaran.dart';
import 'package:cherryticketmobile/model/pendaftaran_model.dart';
import 'package:cherryticketmobile/providerAPI/form_evaluasi_api.dart';
import 'package:cherryticketmobile/providerAPI/pendaftaran_api.dart';
import 'package:cherryticketmobile/providerAPI/peserta_api.dart';
import 'package:cherryticketmobile/providerAPI/qna_api.dart';
import 'package:cherryticketmobile/view/evaluation.dart';
import 'package:cherryticketmobile/view/list/item/qr_code_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'list/qna_list.dart';

class RoomEvent extends StatefulWidget {
  final Pendaftaranpeserta data;
  final double lng;
  final double lat;
  const RoomEvent(this.data, this.lng, this.lat, {Key key}) : super(key: key);

  @override
  State<RoomEvent> createState() => _RoomEventState();
}

class _RoomEventState extends State<RoomEvent> {
  String temp;

  @override
  void initState() {
    Provider.of<FormEvaluasiAPI>(context, listen: false)
        .fetch(widget.data.event.idevent);

    Provider.of<QnaAPI>(context, listen: false)
        .fetch(widget.data.event.idevent.toString());
    setState(() {
      temp = widget.data.event.statusevent;
    });
    super.initState();
  }

  Future<void> _pullRefresh() async {
    Provider.of<QnaAPI>(context, listen: false)
        .fetch(widget.data.event.idevent.toString());
    Provider.of<PendaftaranpesertaAPI>(context, listen: false).fetch();

    setState(() {
      temp = Provider.of<PendaftaranpesertaAPI>(context, listen: false)
          .findByIdGoing(widget.data.idpendaftaran)
          .event
          .statusevent;
    });
  }

  @override
  Widget build(BuildContext context) {
    final front =
        Provider.of<PesertaAPI>(context, listen: false).items.namadepan;
    final back =
        Provider.of<PesertaAPI>(context, listen: false).items.namabelakang;
    return Scaffold(
      backgroundColor: gray,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: indigo,
        title: const AutoSizeText(
          "Event Room",
          style: TextStyle(color: white),
          textAlign: TextAlign.center,
          maxLines: 2,
          maxFontSize: 16,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: cherry,
        onRefresh: _pullRefresh,
        child: SingleChildScrollView(
          physics: temp == 'QnA' && widget.data.event.qna == 1
              ? const ClampingScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: gray,
                borderRadius: BorderRadius.circular(12.0),
              ),
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
                          image +
                              '/GambarEvent/' +
                              widget.data.event.gambarevent,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 400,
                          height: 20,
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          decoration: const BoxDecoration(color: cherry),
                          child: Center(
                            child: AutoSizeText(
                              temp,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: white,
                                  fontWeight: FontWeight.w600),
                              maxLines: 1,
                            ),
                          ),
                        ),
                      )
                    ],
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
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
                                                            widget.data.event
                                                                .tglacaramulai))
                                                        .toString()) +
                                                    (widget.data.event
                                                                .tglacaraselesai
                                                                .toString() ==
                                                            'null'
                                                        ? ""
                                                        : " - " +
                                                            DateFormat("dd MMM yyy")
                                                                .format(DateTime.parse(
                                                                    widget
                                                                        .data
                                                                        .event
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
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
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
                                                widget.data.event.waktumulai
                                                        .substring(0, 5) +
                                                    ' - ' +
                                                    widget
                                                        .data.event.waktuselesai
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        color: white,
                                        child: const AutoSizeText(
                                            'Venue & Location',
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
                                        color: white,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                                color: white,
                                                width: 150,
                                                child: AutoSizeText(
                                                    widget.data.event.namakota +
                                                        ', ' +
                                                        widget.data.event
                                                            .namalokasi,
                                                    textAlign: TextAlign.left,
                                                    softWrap: true,
                                                    maxLines: 5,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10,
                                                        color:
                                                            Colors.black45))),
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
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: temp == 'Check-In' ? true : false,
                                child: Expanded(
                                  flex: 1,
                                  child: ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.login,
                                      color: white,
                                      size: 16.0,
                                    ),
                                    label: const AutoSizeText(
                                      'Check-In',
                                      style:
                                          TextStyle(fontSize: 14, color: white),
                                      maxLines: 1,
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => QRViewExample(
                                                widget.data,
                                                widget.lat,
                                                widget.lng,
                                                "Check-In")),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: temp == 'Check-In' ? true : false,
                                child: const SizedBox(
                                  width: 10,
                                ),
                              ),
                              Visibility(
                                visible:
                                    temp == 'QnA' && widget.data.event.qna == 1
                                        ? true
                                        : false,
                                child: Expanded(
                                  flex: 1,
                                  child: ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.question_answer,
                                      color: white,
                                      size: 16.0,
                                    ),
                                    label: const AutoSizeText(
                                      'QnA',
                                      style:
                                          TextStyle(fontSize: 14, color: white),
                                      maxLines: 1,
                                    ),
                                    onPressed: () {
                                      showDialog<void>(
                                          barrierColor:
                                              Colors.white.withOpacity(0.1),
                                          context: context,
                                          builder: (context) {
                                            return AddQNA(front + ' ' + back,
                                                widget.data.event.idevent);
                                          });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.deepOrange[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible:
                                    temp == 'QnA' && widget.data.event.qna == 1
                                        ? true
                                        : false,
                                child: const SizedBox(
                                  width: 10,
                                ),
                              ),
                              Visibility(
                                visible: temp == 'Check-Out' ? true : false,
                                child: Expanded(
                                  flex: 1,
                                  child: ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.logout,
                                      color: white,
                                      size: 16.0,
                                    ),
                                    label: const AutoSizeText(
                                      'Check-Out',
                                      style:
                                          TextStyle(fontSize: 14, color: white),
                                      maxLines: 1,
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => QRViewExample(
                                                widget.data,
                                                widget.lat,
                                                widget.lng,
                                                "Check-Out")),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: temp == 'Check-Out' ? true : false,
                                child: const SizedBox(
                                  width: 10,
                                ),
                              ),
                              Visibility(
                                visible: temp == 'Evaluation' &&
                                        widget.data.event.evaluasi == 1
                                    ? true
                                    : false,
                                child: Expanded(
                                  flex: 1,
                                  child: ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.feedback,
                                      color: white,
                                      size: 16.0,
                                    ),
                                    label: const AutoSizeText(
                                      'Evaluation',
                                      style:
                                          TextStyle(fontSize: 14, color: white),
                                      maxLines: 1,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EvaluationScreen(
                                                    widget.data.idpendaftaran)),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.brown[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: temp == 'Evaluation' &&
                                        widget.data.event.evaluasi == 1
                                    ? true
                                    : false,
                                child: const SizedBox(
                                  width: 10,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.notes_rounded,
                                    color: white,
                                    size: 16.0,
                                  ),
                                  label: const AutoSizeText(
                                    'My Data',
                                    style:
                                        TextStyle(fontSize: 14, color: white),
                                    maxLines: 1,
                                  ),
                                  onPressed: () {
                                    showDialog<void>(
                                        barrierColor:
                                            Colors.white.withOpacity(0.1),
                                        context: context,
                                        builder: (context) {
                                          return DialogPendaftaran(
                                              widget.data.datapertanyaan);
                                        });
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
                  Visibility(
                    visible: temp == 'QnA' && widget.data.event.qna == 1
                        ? true
                        : false,
                    child: const SizedBox(
                      height: 10,
                    ),
                  ),
                  Visibility(
                    visible: temp == 'QnA' && widget.data.event.qna == 1
                        ? true
                        : false,
                    child: const AutoSizeText("Question From Participant",
                        textAlign: TextAlign.left,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: cherry)),
                  ),
                  Visibility(
                    visible: temp == 'QnA' && widget.data.event.qna == 1
                        ? true
                        : false,
                    child: const SizedBox(
                      height: 10,
                    ),
                  ),
                  Visibility(
                      visible: temp == 'QnA' && widget.data.event.qna == 1
                          ? true
                          : false,
                      child: const QnaView()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
