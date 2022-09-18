import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/model/formevaluasi_model.dart';
import 'package:cherryticketmobile/providerAPI/form_evaluasi_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EvaluationItem extends StatefulWidget {
  final PertanyaanE data;
  final int index;

  const EvaluationItem(this.index, this.data, {Key key}) : super(key: key);

  @override
  State<EvaluationItem> createState() => _EvaluationItemState();
}

class _EvaluationItemState extends State<EvaluationItem> {
  TextEditingController pertanyaan;
  TextEditingController dropdown;
  @override
  void initState() {
    pertanyaan = TextEditingController(
        text: widget.data.jawaban != "" ? widget.data.jawaban : pertanyaan);
    super.initState();
  }

  List<String> init(List<OptionsE> data) {
    List<String> temp = [];
    for (var i = 0; i < data.length; i++) {
      temp.add(data[i].option);
    }
    return temp;
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
          widget.data.type != "Text"
              ? const SizedBox(
                  height: 0,
                )
              : TextFormField(
                  controller: Provider.of<FormEvaluasiAPI>(context).checks
                      ? TextEditingController(text: widget.data.jawaban)
                      : pertanyaan,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field must be fill';
                    }
                    return null;
                  },
                  onChanged: (input) {
                    if (Provider.of<FormEvaluasiAPI>(context, listen: false)
                            .checks !=
                        false) {
                      Provider.of<FormEvaluasiAPI>(context, listen: false)
                          .initCheck(false);
                    }

                    Provider.of<FormEvaluasiAPI>(context, listen: false)
                        .isiPertanyaan(widget.index, input);
                  },
                  autofocus: false,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Question - ' + (widget.index + 1).toString(),
                    labelStyle: const TextStyle(color: divider),
                  ),
                ),
          widget.data.type != "Dropdown"
              ? const SizedBox(
                  height: 0,
                )
              : DropdownButtonFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field must be fill';
                    }
                    return null;
                  },
                  onChanged: (input) {
                    Provider.of<FormEvaluasiAPI>(context, listen: false)
                        .isiPertanyaan(widget.index, input);
                  },
                  value: widget.data.jawaban.toString() == ""
                      ? dropdown
                      : widget.data.jawaban,
                  autofocus: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Question - ' + (widget.index + 1).toString(),
                    labelStyle: const TextStyle(color: divider),
                  ),
                  items: widget.data.options.map((e) {
                    return DropdownMenuItem<Object>(
                        value: e.option,
                        child: Text(
                            e.option.toString() == "null" ? "" : e.option,
                            style: const TextStyle(color: indigo)));
                  }).toList()),
          widget.data.type != "Double Choice"
              ? const SizedBox(
                  height: 0,
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.data.options
                      .map((data) => RadioListTile(
                            contentPadding: const EdgeInsets.all(0),
                            activeColor: cherry,
                            title: Text(
                              data.option.toString() == "null"
                                  ? "heheheh"
                                  : data.option,
                              style: const TextStyle(
                                  color: indigo,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                            groupValue: widget.data.jawaban,
                            value: data.option,
                            onChanged: (value) {
                              Provider.of<FormEvaluasiAPI>(context,
                                      listen: false)
                                  .isiPertanyaan(widget.index, value);
                            },
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }
}
