import 'dart:developer';

import 'package:cherryticketmobile/components/color.dart';
import 'package:cherryticketmobile/model/pendaftaran_model.dart';
import 'package:cherryticketmobile/providerAPI/api_service.dart';
import 'package:cherryticketmobile/view/roomevent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  final Pendaftaranpeserta data;
  final double lng;
  final double lat;
  final String status;
  const QRViewExample(this.data, this.lat, this.lng, this.status, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 1, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: cherry,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code.toString() == widget.data.event.qrcode) {
        controller.pauseCamera();
        if (widget.status == "Check-In") {
          APIService apiService = APIService();
          apiService.checkin(widget.data.idpendaftaran).then((value) {
            if (value['message'] == 'Check-In Successfully') {
              final snackBar = SnackBar(
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green[800],
                content: Text("${value['message']}"),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
        } else {
          APIService apiService = APIService();
          apiService.checkout(widget.data.idpendaftaran).then((value) {
            if (value['message'] == 'Check-Out Successfully') {
              final snackBar = SnackBar(
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green[800],
                content: Text("${value['message']}"),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  RoomEvent(widget.data, widget.lat, widget.lng)),
        );
        controller.resumeCamera();
      } else {
        controller.pauseCamera();
        final snackBar = SnackBar(
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red[800],
          content: const Text("Wrong Event QRcode"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        controller.resumeCamera();
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
