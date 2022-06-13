import 'package:cherryticketmobile/components/color.dart';

import 'package:cherryticketmobile/providerAPI/event.dart';
import 'package:cherryticketmobile/providerAPI/peserta.dart';
import 'package:cherryticketmobile/view/eventshowitem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetEventWithToken extends StatefulWidget {
  const GetEventWithToken({Key key}) : super(key: key);

  @override
  _GetEventWithToken createState() => _GetEventWithToken();
}

class _GetEventWithToken extends State<GetEventWithToken> {
  bool color;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  var tokenEvent = TextEditingController();

  String token;

  @override
  void initState() {
    super.initState();
    token = "";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: gray,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 10,
      title: const Text(
        'Search Event Private',
        textAlign: TextAlign.center,
        style: TextStyle(color: indigo),
      ),
      content: Form(
        key: globalFormKey,
        child: Container(
          color: gray,
          height: 50,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: tokenEvent,
                onChanged: (input) => token = input,
                autofocus: false,
                style: const TextStyle(color: indigo),
                cursorColor: indigo,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10.0),
                  isDense: true,
                  filled: true,
                  fillColor: white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0)),
                  hintText: 'Unique Code',
                  labelText: 'UniqueCode',
                  labelStyle: const TextStyle(color: Colors.black38),
                ),
              ),
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
                  if (Provider.of<EventAPI>(context, listen: false)
                          .findByToken(token) !=
                      null) {
                    Navigator.pop(context, 'Cancel');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventShowItem(
                              Provider.of<EventAPI>(context, listen: false)
                                  .findByToken(token)
                                  .idevent)),
                    );
                  } else {
                    final snackBar = SnackBar(
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red[800],
                      content: const Text("Event Not Found"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              },
              child: const Text(
                'Search',
                style: TextStyle(color: cherry),
              ),
            ),
          ],
        )
      ],
    );
  }
}
