import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cherryticketmobile/view/navigation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/components/progress_hud.dart';
import 'package:cherryticketmobile/model/peserta_model.dart';
import 'package:cherryticketmobile/providerAPI/api_service.dart';
import 'package:cherryticketmobile/providerAPI/peserta_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadTransaksi extends StatefulWidget {
  final String imagedata;
  final int idtransaksi;
  const UploadTransaksi(this.imagedata, this.idtransaksi, {Key key})
      : super(key: key);

  @override
  _UploadTransaksi createState() => _UploadTransaksi();
}

class _UploadTransaksi extends State<UploadTransaksi> {
  bool color;
  File imageprofil;
  bool isApiCallProcess = false;
  Peserta requestModel;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);

      setState(() {
        imageprofil = imageTemporary;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image:$e');
    }
  }

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
    var actionGroup = AutoSizeGroup();
    return AlertDialog(
      backgroundColor: gray,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 10,
      title: const Text(
        'Upload Picture Transaction',
        textAlign: TextAlign.center,
        style: TextStyle(color: indigo),
      ),
      content: Container(
        color: gray,
        height: 250,
        width: 200,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: imageprofil == null
                    ? Container(
                        width: 105,
                        height: 105,
                        decoration: BoxDecoration(
                          color: indigo,
                          image: DecorationImage(
                              image: NetworkImage(widget.imagedata),
                              fit: BoxFit.cover),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(487.0)),
                        ),
                      )
                    : Container(
                        width: 105,
                        height: 105,
                        decoration: BoxDecoration(
                          color: indigo,
                          image: DecorationImage(
                              image: FileImage(imageprofil), fit: BoxFit.fill),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(487.0)),
                        ),
                      )),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                flex: 1,
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.photo_size_select_actual_rounded,
                    color: Colors.white,
                    size: 15.0,
                  ),
                  label: AutoSizeText(
                    'Gallery',
                    style: const TextStyle(fontSize: 18),
                    group: actionGroup,
                    maxLines: 1,
                  ),
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                  style: ElevatedButton.styleFrom(
                    maximumSize: const Size(double.infinity, double.infinity),
                    minimumSize: const Size(double.infinity, double.infinity),
                    primary: indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                flex: 1,
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.camera,
                    color: Colors.white,
                    size: 15.0,
                  ),
                  label: AutoSizeText(
                    'Take Picture',
                    style: const TextStyle(fontSize: 18),
                    group: actionGroup,
                    maxLines: 1,
                  ),
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  style: ElevatedButton.styleFrom(
                    maximumSize: const Size(double.infinity, double.infinity),
                    minimumSize: const Size(double.infinity, double.infinity),
                    primary: cherry,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ))
          ],
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
                  setState(() {
                    isApiCallProcess = true;
                  });
                  if (imageprofil != null) {
                    APIService apiService = APIService();
                    apiService
                        .uploadTransksi(imageprofil, widget.idtransaksi)
                        .then((value) {
                      setState(() {
                        isApiCallProcess = false;
                      });
                      if (value == 200) {
                        final snackBar = SnackBar(
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green[800],
                          content: const Text("Update Photo Successfull"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const NavigationBottom()));
                      } else {
                        final snackBar = SnackBar(
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red[800],
                          content: const Text("Update Photo Failed"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  } else {
                    final snackBar = SnackBar(
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red[800],
                      content: const Text("Choose Image"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              },
              child: const Text(
                'Upload',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        )
      ],
    );
  }
}
