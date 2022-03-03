//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:qr_code_scanner/qr_code_scanner.dart';

/*
class ExpectedScanResult {
  final String wristbandID;
  final bool isValid;
  ExpectedScanResult(this.wristbandID, this.isValid);
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final recognisedCodes = <ExpectedScanResult>[
    ExpectedScanResult('Wallet Page', true),
  ];

final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
Barcode? result;
QRViewController? controller;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(children: [
        QRView(
            cameraFacing: CameraFacing.back,
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderRadius: 10,
              borderWidth: 5,
              borderColor: Colors.white,
            ),
          ),
      ],)
    )
  }

    void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    final expectedCodes = recognisedCodes.map((e) => e.wristbandID);
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      //REPLACE WITH FIREBASE QUERY?
      if (expectedCodes.any((element) => scanData.code == element)) {
        //An ID is found
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => 
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

*/