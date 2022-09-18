import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/model/formpendaftaran_model.dart';
import 'package:cherryticketmobile/view/list/item/dialogpendaftaran_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DialogPendaftaran extends StatefulWidget {
  final List<PertanyaanResponse> data;
  const DialogPendaftaran(this.data, {Key key}) : super(key: key);

  @override
  _DialogPendaftaran createState() => _DialogPendaftaran();
}

class _DialogPendaftaran extends State<DialogPendaftaran> {
  bool color;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        elevation: 10,
        title: const Text(
          'My Data',
          textAlign: TextAlign.center,
          style: TextStyle(color: indigo),
        ),
        content: Container(
            color: white,
            width: MediaQuery.of(context).size.width,
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 400,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: widget.data.isNotEmpty
                      ? const AlwaysScrollableScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10.0),
                  itemCount: widget.data.length,
                  itemBuilder: (ctx, i) =>
                      DialogPendaftaranItem(widget.data[i], i)),
            )),
        actions: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            TextButton(
                onPressed: () => Navigator.pop(context, 'Close'),
                child:
                    const Text('Close', style: TextStyle(color: Colors.green))),
          ]),
        ]);
  }

  clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
