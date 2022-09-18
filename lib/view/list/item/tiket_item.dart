import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/model/formpendaftaran_model.dart';
import 'package:cherryticketmobile/model/tiket_model.dart';
import 'package:cherryticketmobile/providerAPI/event_api.dart';
import 'package:cherryticketmobile/providerAPI/form_pendaftaran_api.dart';
import 'package:cherryticketmobile/providerAPI/jawabanpendaftaran.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TiketItem extends StatefulWidget {
  final Tiket data;

  const TiketItem(this.data, {Key key}) : super(key: key);

  @override
  State<TiketItem> createState() => _TiketItemState();
}

class _TiketItemState extends State<TiketItem> {
  String harga = "";
  NumberFormat currencyFormatter;
  List<Pertanyaan> data;
  @override
  void initState() {
    setState(() {
      data = Provider.of<FormPendaftaranAPI>(context, listen: false)
          .items
          .datapertanyaan;
    });
    setState(() {
      Provider.of<EventAPI>(context, listen: false)
          .initTiket(widget.data.idtiket, widget.data.idevent);
      currencyFormatter = NumberFormat.currency(
        locale: 'id',
        symbol: 'Rp ',
        decimalDigits: 2,
      );
    });
    super.initState();
  }

  List<Pertanyaan> init(List<Pertanyaan> data) {
    List<Pertanyaan> temp = [];
    for (var i = 0; i < data.length; i++) {
      temp.add(Pertanyaan(
          pertanyaan: data[i].pertanyaan,
          jawaban: "",
          type: data[i].type,
          nomor: data[i].nomor,
          options: data[i].options));
    }

    return temp;
  }

  @override
  Widget build(BuildContext context) {
    int batastiket =
        Provider.of<EventAPI>(context).findById(widget.data.idevent).batastiket;

    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            widget.data.namatiket,
            style: const TextStyle(
                color: cherry, fontSize: 14, fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 5,
          ),
          AutoSizeText(
            widget.data.fasilitas,
            style: const TextStyle(
                color: indigo, fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const Divider(
            height: 20,
            thickness: 2,
            indent: 0,
            endIndent: 0,
            color: divider,
          ),
          Row(
            children: [
              AutoSizeText(
                currencyFormatter.format(widget.data.harga).toString(),
                style: const TextStyle(
                    color: indigo, fontSize: 14, fontWeight: FontWeight.w800),
              ),
              const Spacer(),
              Container(
                width: 100,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  border: Border.all(color: indigo, width: 1.5),
                  color: white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      iconSize: 15,
                      icon: const Icon(Icons.remove),
                      color: indigo,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        if (Provider.of<EventAPI>(context, listen: false)
                                .jumlahBeli(
                                    widget.data.idtiket, widget.data.idevent) <=
                            0) {
                          final snackBar = SnackBar(
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red[800],
                            content: const Text("Can't be minus"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          Provider.of<EventAPI>(context, listen: false)
                              .minusTiket(
                                  widget.data.idtiket, widget.data.idevent);
                          Provider.of<JawabanPendaftaran>(context,
                                  listen: false)
                              .removeFormPeserta(widget.data.idtiket);
                        }
                      },
                    ),
                    const Spacer(),
                    AutoSizeText(
                      Provider.of<EventAPI>(context)
                          .jumlahBeli(widget.data.idtiket, widget.data.idevent)
                          .toString(),
                      style: const TextStyle(color: indigo),
                    ),
                    const Spacer(),
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        iconSize: 15,
                        icon: const Icon(Icons.add),
                        color: indigo,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          if (Provider.of<JawabanPendaftaran>(context,
                                      listen: false)
                                  .items
                                  .length >=
                              batastiket) {
                            final snackBar = SnackBar(
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red[800],
                              content: Text("Maximal tiket one email is " +
                                  batastiket.toString()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            if (widget.data.stok >
                                Provider.of<EventAPI>(context, listen: false)
                                    .jumlahBeli(widget.data.idtiket,
                                        widget.data.idevent)) {
                              Provider.of<EventAPI>(context, listen: false)
                                  .plusTiket(
                                      widget.data.idtiket, widget.data.idevent);
                              Provider.of<JawabanPendaftaran>(context,
                                      listen: false)
                                  .addFormPeserta(
                                Jawaban(
                                  fasilitas: widget.data.fasilitas,
                                  namatiket: widget.data.namatiket,
                                  idevent: widget.data.idevent,
                                  datapertanyaan: init(data),
                                  nomor: Provider.of<JawabanPendaftaran>(
                                              context,
                                              listen: false)
                                          .items
                                          .length +
                                      1,
                                  harga: widget.data.harga,
                                  idpeserta: 0,
                                  idtiket: widget.data.idtiket,
                                ),
                              );
                              // for (var i = 0;
                              //     i <
                              //         Provider.of<JawabanPendaftaran>(context,
                              //                 listen: false)
                              //             .orders
                              //             .length;
                              //     i++) {
                              //   print(Provider.of<JawabanPendaftaran>(context,
                              //           listen: false)
                              //       .orders[i]
                              //       .jumlah);
                              //   print(Provider.of<JawabanPendaftaran>(context,
                              //           listen: false)
                              //       .orders[i]
                              //       .subtotal);
                              // }
                            } else {
                              final snackBar = SnackBar(
                                duration: const Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.red[800],
                                content: const Text("Ticket not enough"),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        }),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
