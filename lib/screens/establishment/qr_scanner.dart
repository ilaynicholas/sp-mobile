import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../models/log.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({ Key? key }) : super(key: key);

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  Stream<DocumentSnapshot> stream = FirebaseFirestore.instance
      .collection('establishments')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  String? code;
  bool isValidCode = false;
  bool isApproved = false;

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
            StreamBuilder(
              stream: stream,
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!['isApproved']) {
                    return SizedBox(
                      height: 300,
                      child: MobileScanner(
                        fit: BoxFit.contain,
                        allowDuplicates: false,
                        onDetect: (barcode, args) {
                          code = barcode.rawValue;
                          setState(() {
                            isValidCode = checkCodeValidity(code!);
                          });
                        },
                      )
                    );
                  } else {
                    return const SizedBox(
                      height: 300,
                      child: Center(
                        child: Text("Establishment not yet approved. Cannot use QR code scanner.")
                      )
                    );
                  }
                }
                return const CircularProgressIndicator();
              }
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ElevatedButton(
                onPressed: isValidCode
                  ? () {
                      Log log = Log(
                        establishmentId: FirebaseAuth.instance.currentUser!.uid,
                        userId: factorCode(code!),
                        timestamp: Timestamp.now()
                      );
                      addLog(log);
                      setState(() { 
                        isValidCode = false;
                      });
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
      return true;
    }

    return false;
  }

  String factorCode(String code) {
    return code.replaceAll("GapanTrax: ", "");
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