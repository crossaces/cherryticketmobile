import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/model/formpendaftaran_model.dart';
import 'package:cherryticketmobile/providerAPI/jawabanpendaftaran.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PertanyaanItem extends StatefulWidget {
  final Pertanyaan data;
  final int index;

  const PertanyaanItem(this.index, this.data, {Key key}) : super(key: key);

  @override
  State<PertanyaanItem> createState() => _PertanyaanItemState();
}

class _PertanyaanItemState extends State<PertanyaanItem> {
  TextEditingController idpeserta;
  TextEditingController pertanyaan;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: gray,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: widget.index == 0 ? true : false,
              child: const AutoSizeText(
                "Id Participant",
                style: TextStyle(
                    fontSize: 15, color: indigo, fontWeight: FontWeight.w600),
              )),
          const SizedBox(
            height: 5,
          ),
          Visibility(
            visible: widget.index == 0 ? true : false,
            child: TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly
              ],
              controller:
                  Provider.of<JawabanPendaftaran>(context, listen: false).checks
                      ? TextEditingController(
                          text: Provider.of<JawabanPendaftaran>(context,
                                  listen: false)
                              .returnIDPESERTA(Provider.of<JawabanPendaftaran>(
                          context,
                        ).i))
                      : idpeserta,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return 'This field must be fill';
                }
                return null;
              },
              onChanged: (input) {
                if (Provider.of<JawabanPendaftaran>(context, listen: false)
                        .checks !=
                    false) {
                  Provider.of<JawabanPendaftaran>(context, listen: false)
                      .initCheck(false);
                }

                if (input.isEmpty) {
                  Provider.of<JawabanPendaftaran>(context, listen: false)
                      .addIDPESERTA(
                          Provider.of<JawabanPendaftaran>(context,
                                  listen: false)
                              .i,
                          0);
                } else {
                  Provider.of<JawabanPendaftaran>(context, listen: false)
                      .addIDPESERTA(
                          Provider.of<JawabanPendaftaran>(context,
                                  listen: false)
                              .i,
                          int.parse(input));
                }
              },
              autofocus: false,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0)),
                hintText: 'Id Participant',
                labelStyle: const TextStyle(color: divider),
                prefixIcon: const Icon(Icons.people_alt, color: cherry),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          AutoSizeText(
            widget.data.pertanyaan,
            style: const TextStyle(
                fontSize: 15, color: indigo, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          Visibility(
            visible: widget.data.type == 'Dropdown' ? true : false,
            child: TextFormField(
              controller:
                  Provider.of<JawabanPendaftaran>(context, listen: false).checks
                      ? TextEditingController(
                          text: Provider.of<JawabanPendaftaran>(context,
                                  listen: false)
                              .returnJawaban(Provider.of<JawabanPendaftaran>(
                                      context,
                                      listen: false)
                                  .i)[widget.index]
                              .jawaban)
                      : pertanyaan,
              validator: (value) {
                if (value.isEmpty) {
                  return 'This field must be fill';
                }
                return null;
              },
              onChanged: (input) {
                if (Provider.of<JawabanPendaftaran>(context, listen: false)
                        .checks !=
                    false) {
                  Provider.of<JawabanPendaftaran>(context, listen: false)
                      .initCheck(false);
                } else {
                  if (input.isEmpty) {
                    Provider.of<JawabanPendaftaran>(context, listen: false)
                        .isiPertanyaan(
                            Provider.of<JawabanPendaftaran>(context,
                                    listen: false)
                                .i,
                            widget.index,
                            "");
                  } else {
                    Provider.of<JawabanPendaftaran>(context, listen: false)
                        .isiPertanyaan(
                            Provider.of<JawabanPendaftaran>(context,
                                    listen: false)
                                .i,
                            widget.index,
                            input);
                  }
                }

                print(
                  Provider.of<JawabanPendaftaran>(context, listen: false)
                          .returnJawaban(0)[widget.index]
                          .jawaban +
                      ' ' +
                      'formpertama',
                );
                print(Provider.of<JawabanPendaftaran>(context, listen: false)
                        .returnJawaban(1)[widget.index]
                        .jawaban +
                    ' ' +
                    'formkedua');
              },
              autofocus: false,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0)),
                hintText: 'Question - ' + (widget.index + 1).toString(),
                labelStyle: const TextStyle(color: divider),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
