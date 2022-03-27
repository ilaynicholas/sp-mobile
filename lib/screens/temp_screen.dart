import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

enum MobileVerificationState {
  showMobileFormState,
  showOtpFormState,
}

class TempScreen extends StatefulWidget {
  const TempScreen({ Key? key }) : super(key: key);

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  MobileVerificationState currentState = MobileVerificationState.showMobileFormState;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String verificationId;
  bool showLoading = false;

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential = await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if(authCredential.user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message!),
        duration: const Duration(seconds: 5)
      ));
    }
  }

  getMobileFormWidget(context) {
    return Column(
      children: [
        const Spacer(),
        TextField(
          controller: phoneController,
          decoration: const InputDecoration(
            hintText: "+63"
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          child: const Text("SEND OTP"),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )
            ),
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF008999))
          ),
          onPressed: () async {
            setState(() {
              showLoading = true;
            });

            await _auth.verifyPhoneNumber(
              phoneNumber: phoneController.text,
              verificationCompleted: (phoneAuthCredential) async {
                setState(() {
                  showLoading = false;
                });
              },
              verificationFailed: (verificationFailed) async {
                setState(() {
                  showLoading = false;
                });

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(verificationFailed.message!),
                  duration: const Duration(seconds: 5)
                ));
              },
              codeSent: (verificationId, resendingToken) async {
                setState(() {
                  showLoading = false;
                  currentState = MobileVerificationState.showOtpFormState;
                  this.verificationId = verificationId;
                });
              },
              codeAutoRetrievalTimeout: (verificationId) async {
                setState(() {
                  showLoading = false;
                });
              }
            );
          },
        ),
        const Spacer()
      ]
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        const Spacer(),
        TextField(
          controller: otpController,
          decoration: const InputDecoration(
            hintText: "Enter OTP"
          ),
        ),
        const SizedBox(
          height: 16
        ),
        ElevatedButton(
          child: const Text("VERIFY"),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )
            ),
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF008999))
          ),
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: otpController.text
            );

            signInWithPhoneAuthCredential(phoneAuthCredential);
          },
        ),
        const Spacer()
      ],
    );
  }

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: showLoading 
          ? const Center(
            child: CircularProgressIndicator()
          )
          : currentState == MobileVerificationState.showMobileFormState
            ? getMobileFormWidget(context)
            : getOtpFormWidget(context),
        padding: const EdgeInsets.all(16)
      )
    );
  }
}