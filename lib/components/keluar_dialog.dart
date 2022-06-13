import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/view/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeluarDialog extends StatefulWidget {
  const KeluarDialog({Key key}) : super(key: key);

  @override
  _KeluarDialog createState() => _KeluarDialog();
}

class _KeluarDialog extends State<KeluarDialog> {
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
          'Logout',
          textAlign: TextAlign.center,
          style: TextStyle(color: indigo),
        ),
        content: Container(
            color: white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Are you sure log out ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54)),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
        actions: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel',
                    style: TextStyle(color: Colors.green))),
            TextButton(
                onPressed: () {
                  setState(() {
                    clear();
                  });
                  Navigator.pop(context, 'Cancel');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                  final snackBar = SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.green[800],
                    duration: const Duration(milliseconds: 800),
                    content: const Text("Log Out Successfully"),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child:
                    const Text('Log Out', style: TextStyle(color: Colors.red)))
          ]),
        ]);
  }

  clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
