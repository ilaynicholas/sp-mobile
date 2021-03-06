import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({ Key? key }) : super(key: key);

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFF00CDA6)]
        )
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: 120,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 4,
                    offset: const Offset(4, 8), // changes position of shadow
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  "This is your personal QR code. Show this whenever you enter establishments in Gapan City.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center
                ),
              )
            ),
            buildQrCode(),
            Container(
              padding: const EdgeInsets.all(10),
              height: 120,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 4,
                    offset: const Offset(4, 8), // changes position of shadow
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  "You may opt to take a screenshot of your QR code for future use.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center
                ),
              )
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8),
            //   child: ElevatedButton(
            //     onPressed: () async { // save image
            //       final controller = ScreenshotController();
            //       await controller.captureFromWidget(
            //         buildQrCode()
            //       ).then((value) => print("yay"))
            //       .onError((error, stackTrace) => print(error));
            //     },
            //     child: const Text(
            //         "DOWNLOAD",
            //         style: TextStyle(
            //             fontSize: 24.0,
            //             fontWeight: FontWeight.bold
            //           )
            //       ),
            //     style: ElevatedButton.styleFrom(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(25.0)
            //       ),
            //       primary: const Color(0xFF008999),
            //       onPrimary: Colors.white,
            //       minimumSize: const Size(300, 60)
            //     ),
            //   )
            // )
          ],
        ),
      )
    );
  }

  buildQrCode() {
    return QrImage(
      data: "GapanTrax: " + FirebaseAuth.instance.currentUser!.uid,
      version: QrVersions.auto,
      size: 300.0,
      backgroundColor: Colors.white
    );
  }
}