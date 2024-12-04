import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/services.dart';

class BarcodeScannerPageView extends StatefulWidget {
  const BarcodeScannerPageView({Key? key}) : super(key: key);

  @override
  _BarcodeScannerPageViewState createState() =>
      _BarcodeScannerPageViewState();
}

class _BarcodeScannerPageViewState extends State<BarcodeScannerPageView> {
  BarcodeCapture? capture;
  MobileScannerController controller = MobileScannerController(torchEnabled: false);
  bool isQRCodeScanned = false; // Track if QR code is scanned

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget cameraView() {
    return Stack(
      children: [
        MobileScanner(
          controller: controller,
          fit: BoxFit.cover,
          errorBuilder: (context, error, child) {
            return ScannerErrorWidget(error: error);
          },
          onDetect: (capture) {
            setState(() {
              this.capture = capture;
              isQRCodeScanned = true; // Set to true when QR code is detected
            });
            final qrCode = capture.barcodes.first.rawValue;
            if (qrCode != null) {
              handleQRCodeDetected(qrCode);
            }
          },
        ),
        if (isQRCodeScanned) // Show checkmark when QR code is scanned
          Positioned(
            top: 20,
            left: 20,
            child: Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 50,
            ),
          ),
        Positioned(
          bottom: 20,
          left: 20,
          child: FloatingActionButton(
            heroTag: "cameraSwitch", // Hero tag unik untuk tombol kamera
            onPressed: () {
              controller.switchCamera();
            },
            backgroundColor: Colors.blue,
            child: Icon(Icons.cameraswitch, color: Colors.white),
          ),
        ),
      ],
    );
  }

  void handleQRCodeDetected(String qrCode) {
    copyToClipboard(qrCode);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Berhasil membaca QR Code: $qrCode')),
    );
    // Setelah QR Code berhasil dipindai, kembali ke halaman sebelumnya
    Navigator.pop(context, true); // Mengirim true ke halaman profil
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('QR Code disalin ke clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'QR Code Scanner',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: cameraView(),
    );
  }
}

class ScannerErrorWidget extends StatelessWidget {
  const ScannerErrorWidget({Key? key, required this.error}) : super(key: key);

  final MobileScannerException error;

  @override
  Widget build(BuildContext context) {
    String errorMessage;

    switch (error.errorCode) {
      case MobileScannerErrorCode.controllerUninitialized:
        errorMessage = 'Controller tidak siap.';
        break;
      case MobileScannerErrorCode.permissionDenied:
        errorMessage = 'Izin kamera ditolak.';
        break;
      default:
        errorMessage = 'Kesalahan Umum.';
        break;
    }

    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Icon(Icons.error, color: Colors.white),
            ),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              error.errorDetails?.message ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}