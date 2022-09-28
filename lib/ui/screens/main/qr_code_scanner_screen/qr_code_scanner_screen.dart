import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:seaweed/constant/app_string.dart';
import 'package:seaweed/theme/app_colors.dart';
import 'package:seaweed/ui/screens/main/qr_code_scanner_screen/qr_code_controller.dart';
import 'package:seaweed/ui/widgets/app_progress_view.dart';
import 'package:seaweed/utils/extension.dart';

class QrCodeScannerScreen extends StatefulWidget {
  QrCodeScannerScreen({Key? key}) : super(key: key);

  @override
  State<QrCodeScannerScreen> createState() => _QrCodeScannerScreenState();
}

class _QrCodeScannerScreenState extends State<QrCodeScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;

  final QrCodeController qrCodeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: appBlack,
              size: 30,
            )),
        backgroundColor: appWhite,
        title: qrCodeText.appTextSifonn(
            color: appBlack, fontWeight: FontWeight.w700, size: 22),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          GetBuilder<QrCodeController>(builder: (ctrl) {
            return Stack(
              children: [
                Column(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Stack(
                        children: [
                          QRView(
                            key: qrKey,
                            overlay: QrScannerOverlayShape(),
                            onQRViewCreated: _onQRViewCreated,
                          ),
                          Positioned(
                            top: Get.size.height * 0.19,
                            width: Get.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Scan Qr Code",
                                  style: appTextStyleSifonFont(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Get.size.height * 0.030,
                                      color: Colors.white),
                                ),
                                (5.0).addHSpace(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
          Obx(
            () => qrCodeController.isLoading.value
                ? const AppProgress()
                : SizedBox(),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.qrCodeController.qrController = controller;
    setState(() {
      controller.resumeCamera();
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        qrCodeController.scanCode(scanData.code);
      });
    });
  }

  @override
  void dispose() {
    qrCodeController.qrController?.dispose();
    super.dispose();
  }
}
