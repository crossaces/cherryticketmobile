import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/providerAPI/api_service.dart';
import 'package:cherryticketmobile/providerAPI/qna_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddQNA extends StatefulWidget {
  final String namapeserta;
  final int idevent;
  const AddQNA(this.namapeserta, this.idevent, {Key key}) : super(key: key);

  @override
  _AddQNA createState() => _AddQNA();
}

class _AddQNA extends State<AddQNA> {
  bool color;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  var qna = TextEditingController();
  bool status = false;
  String question;

  @override
  void initState() {
    super.initState();
    question = "";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: gray,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 10,
      title: const Text(
        'QnA',
        textAlign: TextAlign.center,
        style: TextStyle(color: indigo),
      ),
      content: Form(
        key: globalFormKey,
        child: Container(
          color: gray,
          height: 180,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (input) => question = input,
                controller: qna,
                autofocus: false,
                cursorColor: indigo,
                maxLines: 10,
                minLines: 5,
                style: const TextStyle(color: indigo),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10.0),
                  isDense: true,
                  filled: true,
                  fillColor: white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0)),
                  hintText: 'Question',
                  labelText: 'Question',
                  labelStyle: const TextStyle(color: cherry),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CupertinoSwitch(
                    activeColor: cherry,
                    value: status,
                    onChanged: (value) {
                      setState(() {
                        status = value;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Hide Name",
                    style: TextStyle(
                        fontSize: 13,
                        color: status ? cherry : indigo,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel', style: TextStyle(color: indigo))),
            TextButton(
              onPressed: () {
                setState(() {
                  APIService apiService = APIService();
                  apiService
                      .addQNA(status ? "Anonymous" : widget.namapeserta,
                          question, widget.idevent)
                      .then((value) {
                    if (value['message'] == 'Add Qna Event Success') {
                      final snackBar = SnackBar(
                        duration: const Duration(milliseconds: 2000),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green[800],
                        content: Text("${value['message']}"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context);
                      Provider.of<QnaAPI>(context, listen: false)
                          .fetch(widget.idevent.toString());
                    } else {
                      final snackBar = SnackBar(
                        duration: const Duration(milliseconds: 2000),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red[800],
                        content: Text("${value['message']}"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                });
              },
              child: const Text(
                'Ask',
                style: TextStyle(color: cherry),
              ),
            ),
          ],
        )
      ],
    );
  }
}
