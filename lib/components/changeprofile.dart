import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/progress_hud.dart';
import 'package:cherryticketmobile/model/peserta_model.dart';
import 'package:cherryticketmobile/providerAPI/auth.dart';
import 'package:cherryticketmobile/providerAPI/peserta.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({Key key}) : super(key: key);

  @override
  _ChangeProfile createState() => _ChangeProfile();
}

class _ChangeProfile extends State<ChangeProfile> {
  bool color;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  var phonecontroller = TextEditingController();
  var namadepancontroller = TextEditingController();
  var namabelakangcontroller = TextEditingController();
  var alamatcontroller = TextEditingController();
  bool isApiCallProcess = false;
  Peserta requestModel;

  @override
  void initState() {
    super.initState();
    requestModel = Peserta();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: _upInit(context), inAsyncCall: isApiCallProcess, opacity: 0.3);
  }

  Widget _upInit(BuildContext context) {
    final dataPeserta = Provider.of<PesertaAPI>(context);
    final data = dataPeserta.items;
    namadepancontroller = TextEditingController(
        text: data.namadepan.toString() == "null" ? "" : data.namadepan);
    namabelakangcontroller = TextEditingController(
        text: data.namabelakang.toString() == "null" ? "" : data.namabelakang);
    alamatcontroller = TextEditingController(
        text: data.alamat.toString() == "null" ? "" : data.alamat);
    phonecontroller = TextEditingController(
        text: data.nohp.toString() == "null" ? "" : data.nohp);
    requestModel = Provider.of<PesertaAPI>(context).items;
    return AlertDialog(
      backgroundColor: gray,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 10,
      title: const Text(
        'Change Profile',
        textAlign: TextAlign.center,
        style: TextStyle(color: indigo),
      ),
      content: Form(
        key: globalFormKey,
        child: Container(
          color: gray,
          height: 290,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: namadepancontroller,
                onChanged: (input) => requestModel.namadepan = input,
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
                  hintText: 'First Name',
                  labelText: 'First Name',
                  labelStyle: const TextStyle(color: cherry),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: namabelakangcontroller,
                onChanged: (input) => requestModel.namabelakang = input,
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
                  hintText: 'Last Name',
                  labelText: 'Last Name',
                  labelStyle: const TextStyle(color: cherry),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (input) => requestModel.nohp = input,
                validator: (value) {
                  RegExp regExp = RegExp(r'^(?:[+0]8)?[0-9]{10,11}$');
                  if (value.isEmpty) {
                    return 'This field must be fill';
                  } else if (!regExp.hasMatch(value)) {
                    return "Enter a valid number phone";
                  }
                  return null;
                },
                controller: phonecontroller,
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
                  hintText: 'Number Phone',
                  labelText: 'Number Phone',
                  labelStyle: const TextStyle(color: cherry),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (input) => requestModel.alamat = input,
                controller: alamatcontroller,
                autofocus: false,
                cursorColor: indigo,
                maxLines: 5,
                minLines: 3,
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
                  hintText: 'Address',
                  labelText: 'Address',
                  labelStyle: const TextStyle(color: cherry),
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
                child: const Text('Cancel',
                    style: TextStyle(color: Colors.green))),
            TextButton(
              onPressed: () {
                setState(() {
                  if (globalFormKey.currentState.validate()) {
                    setState(() {
                      isApiCallProcess = true;
                    });

                    APIService apiService = APIService();
                    apiService.changeprofile(requestModel).then((value) {
                      setState(() {
                        isApiCallProcess = false;
                      });
                      if (value['message'] == 'Update User Successfully') {
                        final snackBar = SnackBar(
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green[800],
                          content: Text("${value['message']}"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        setState(() {
                          Provider.of<PesertaAPI>(context, listen: false)
                              .fetch();
                          Navigator.pop(context);
                        });
                      } else {
                        final snackBar = SnackBar(
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red[800],
                          content: Text("${value['message']}"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  }
                });
              },
              child: const Text(
                'Change',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        )
      ],
    );
  }
}
