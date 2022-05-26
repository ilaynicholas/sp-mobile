// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sp_mobile/screens/establishment/navbar_estab.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/user/navbar_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GapanTrax',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      debugShowCheckedModeBanner: false,
      home: const InitializerWidget()
    );
  }
}

class InitializerWidget extends StatefulWidget {
  const InitializerWidget({ Key? key }) : super(key: key);

  @override
  State<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  late FirebaseAuth _auth;
  late User? _user;
  bool isLoading = true;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  late ConfirmationResult confirmationResult;

  bool isOtp = false;

  @override
  void initState(){
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      if (_user == null) {
        if (!isOtp) {
          return buildMobileForm(context);
        } else {
          return buildOtpForm(context);
        }
      } else {
        return FutureBuilder<int>(
          future: isUserOrEstab(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              if(data == 0) {
                return const LoginScreen();
              } else if(data == 1) {
                return const UserNavbar();
              } else if(data == 2){
                return const EstabNavbar();
              }
            }

            return const Scaffold(
              body: Center(child: CircularProgressIndicator())
            );
          },
        );
      }
    }
  }

  buildMobileForm(context) {
    final formKey = GlobalKey<FormState>();
    final el = window.document.getElementById('__ff-recaptcha-container');
    if(el != null) {
      el.style.visibility = 'hidden';
    }
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFF00CDA6)]
          )
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Spacer(),
              const Text(
                "GapanTrax",
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF008999),
                )
              ),
              const Text(
                "Contact Tracing Application of\nGapan City",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF008999),
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextFormField(
                  controller: phoneController,
                  validator: (value) {
                    if(value == null || value.isEmpty) return "Please enter your mobile number";
                    if(value.length != 10) return "Please enter 10 digits";
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: "Mobile Number (+63XXXXXXXXXX)",
                    labelStyle: TextStyle(fontSize: 14),
                    prefixText: "+63",
                  ),
                )
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
                  if (formKey.currentState!.validate()) {
                    confirmationResult = await _auth.signInWithPhoneNumber("+63" + phoneController.text);
                    setState(() {
                      isOtp = true;
                    });
                  }
                },
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }

  buildOtpForm(context) {
    final formKey = GlobalKey<FormState>();
    final el = window.document.getElementById('__ff-recaptcha-container');
    if(el != null) {
      el.style.visibility = 'hidden';
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFF00CDA6)]
          )
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Spacer(),
              const Text(
                "GapanTrax",
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF008999),
                )
              ),
              const Text(
                "Contact Tracing Application of\nGapan City",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF008999),
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextFormField(
                  controller: otpController,
                  validator: (value) {
                    if(value == null || value.isEmpty) return "Please enter the OTP";
                    if(value.length != 6) return "Please enter 6 digits";
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    labelText: "OTP",
                    labelStyle: TextStyle(fontSize: 14),
                  )
                )
              ),
              const SizedBox(
                height: 16,
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
                  if (formKey.currentState!.validate()) {
                    await confirmationResult.confirm(otpController.text);
                    setState(() {
                      _auth = FirebaseAuth.instance;
                      _user = _auth.currentUser;
                      isOtp = false;
                    });
                  }
                },
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }

  Future<int> isUserOrEstab() async {
    int checker = 0;

    await FirebaseFirestore.instance
      .collection('users')
      .doc(_user!.uid)
      .get()
      .then((value) => {
        if (value.exists) {
          checker = 1
        }
      });

    await FirebaseFirestore.instance
      .collection('establishments')
      .doc(_user!.uid)
      .get()
      .then((value) => {
        if (value.exists) {
          checker = 2
        }
      });

    return checker;
  }
}