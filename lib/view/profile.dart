import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/components/changepassword_dialog.dart';
import 'package:cherryticketmobile/components/changepicture.dart';
import 'package:cherryticketmobile/components/changeprofile.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/data.dart';
import 'package:cherryticketmobile/components/keluar_dialog.dart';
import 'package:cherryticketmobile/model/peserta_model.dart';
import 'package:cherryticketmobile/providerAPI/peserta_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AutoSizeGroup myGroup;
  var actionGroup = AutoSizeGroup();
  var profilGroup = AutoSizeGroup();

  @override
  void initState() {
    myGroup = AutoSizeGroup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataPeserta = Provider.of<PesertaAPI>(context);
    final data = dataPeserta.items;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: gray,
      body: Container(
          color: gray,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    _backBgCover(),
                    _textProfile(),
                    _greetings(data),
                  ],
                ),
                const SizedBox(height: 50),
                Center(
                  child: Center(
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [_body(data), _action(data)],
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Container _backBgCover() {
    return Container(
      height: 150,
      decoration: const BoxDecoration(
        color: indigo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(90),
          bottomRight: Radius.circular(90),
        ),
      ),
    );
  }

  Container _action(Peserta data) {
    return Container(
      color: gray,
      width: MediaQuery.of(context).size.width - 50,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: 15.0,
                    ),
                    label: AutoSizeText(
                      'Change Password',
                      style: const TextStyle(fontSize: 18),
                      group: actionGroup,
                      maxLines: 1,
                    ),
                    onPressed: () {
                      showDialog<void>(
                          barrierColor: Colors.white.withOpacity(0.1),
                          context: context,
                          builder: (context) {
                            return const ChangePassword();
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  )),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  flex: 1,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 15.0,
                    ),
                    label: AutoSizeText(
                      'Change Profile',
                      style: const TextStyle(fontSize: 18),
                      group: actionGroup,
                      maxLines: 1,
                    ),
                    onPressed: () {
                      showDialog<void>(
                          barrierColor: Colors.white.withOpacity(0.1),
                          context: context,
                          builder: (context) {
                            return const ChangeProfile();
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  )),
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.camera,
                      color: Colors.white,
                      size: 15.0,
                    ),
                    label: AutoSizeText(
                      'Change Picture',
                      style: const TextStyle(fontSize: 18),
                      group: actionGroup,
                      maxLines: 1,
                    ),
                    onPressed: () {
                      showDialog<void>(
                          barrierColor: Colors.white.withOpacity(0.1),
                          context: context,
                          builder: (context) {
                            return ChangePicture(
                                data.gambar.toString() == 'null'
                                    ? image + '/GambarPeserta/default.png'
                                    : image + '/GambarPeserta/' + data.gambar);
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  )),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  flex: 1,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 15.0,
                    ),
                    label: AutoSizeText(
                      'Log Out',
                      style: const TextStyle(fontSize: 18),
                      group: actionGroup,
                      maxLines: 1,
                    ),
                    onPressed: () {
                      showDialog<void>(
                          barrierColor: Colors.white.withOpacity(0.1),
                          context: context,
                          builder: (context) {
                            return const KeluarDialog();
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: cherry,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Container _body(Peserta data) {
    return Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const AutoSizeText(
            "Id User",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          AutoSizeText(
            data.idpeserta.toString(),
            style: const TextStyle(
                fontSize: 18, color: indigo, fontWeight: FontWeight.w600),
          ),
          const Divider(
            color: Colors.black45,
          ),
          const AutoSizeText(
            "Full Name",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          AutoSizeText(
            (data.namadepan.toString() != "null" ? data.namadepan : "") +
                " " +
                (data.namabelakang.toString() != "null"
                    ? data.namabelakang
                    : ""),
            style: const TextStyle(
                fontSize: 18, color: indigo, fontWeight: FontWeight.w600),
          ),
          const Divider(
            color: Colors.black45,
          ),
          const AutoSizeText(
            "Email",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          AutoSizeText(
            data.email ?? "",
            style: const TextStyle(
                fontSize: 18, color: indigo, fontWeight: FontWeight.w600),
          ),
          const Divider(
            color: Colors.black45,
          ),
          const AutoSizeText(
            "Number Phone",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          AutoSizeText(
            data.nohp ?? "",
            style: const TextStyle(
                fontSize: 18, color: indigo, fontWeight: FontWeight.w600),
          ),
          const Divider(
            color: Colors.black45,
          ),
          const AutoSizeText(
            "Address",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          AutoSizeText(
            data.alamat.toString() != "null" ? data.alamat : "",
            style: const TextStyle(
                fontSize: 18, color: indigo, fontWeight: FontWeight.w600),
          ),
          const Divider(
            color: Colors.black45,
          ),
        ]));
  }

  Positioned _textProfile() {
    return Positioned(
        bottom: 75,
        child: Container(
          color: indigo,
          child: const Text('My Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.w500,
              )),
        ));
  }

  Positioned _greetings(Peserta data) {
    return Positioned(
        width: MediaQuery.of(context).size.width - 30,
        bottom: -65,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 140.0,
                height: 140.0,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: gray,
                  borderRadius: BorderRadius.all(Radius.circular(75.0)),
                ),
                child: Container(
                    width: 125.0,
                    height: 125.0,
                    decoration: const BoxDecoration(
                      color: indigo,
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                    ),
                    child: data.gambar.toString() == 'null'
                        ? Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: indigo,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      image + '/GambarPeserta/default.png'),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(487.0)),
                            ),
                          )
                        : Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: indigo,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      image + '/GambarPeserta/' + data.gambar),
                                  fit: BoxFit.cover),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(487.0)),
                            ),
                          )),
              ),
            ],
          ),
        ));
  }

  clear() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.clear();
  }
}
