import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../models/log.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({ Key? key }) : super(key: key);

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  String? code;
  bool isValidCode = false;

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
              height: 170,
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
                  "Please scan the QR code of each customer that enters your establishment.\n\nFocus the camera on the QR code to scan it.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center
                ),
              )
            ),
            SizedBox(
              height: 300,
              child: MobileScanner(
                fit: BoxFit.contain,
                allowDuplicates: false,
                onDetect: (barcode, args) {
                  code = barcode.rawValue;
                  isValidCode = checkCodeValidity(code!);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ElevatedButton(
                onPressed: isValidCode
                  ? () {
                      Log log = Log(
                        establishmentId: "xveDc0fRVPbznYmLIWidn8yf2hq2", //FirebaseAuth.instance.currentUser!.uid
                        userId: code!,
                        timestamp: Timestamp.now()
                      );
                      addLog(log);
                    }
                  : null,
                child: const Text(
                    "UPLOAD",
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold
                      )
                  ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)
                  ),
                  primary: const Color(0xFF008999),
                  onPrimary: Colors.white,
                  minimumSize: const Size(300, 60)
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  bool checkCodeValidity(String code) {
    if (code.startsWith("GapanTrax: ")) {
      code = code.replaceAll("GapanTrax: ", "");
      return true;
    }

    return false;
  }

  addLog(Log log) async {
    await FirebaseFirestore.instance
      .collection("logs")
      .add({
        "establishmentId": log.establishmentId,
        "userId": log.userId,
        "timestamp": log.timestamp
    });
  }
}