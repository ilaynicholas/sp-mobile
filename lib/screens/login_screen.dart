import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFF00CDA6)]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
              )
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                  "REGISTER",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600
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
            ),
            const Padding(padding: EdgeInsets.only(top: 15.0)),
            const Text(
              "Do you own an establishment?",
              style: TextStyle(
                color: Colors.white
              )
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                  "Register as\nEstablishment",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  textAlign: TextAlign.center,
                ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)
                ),
                primary: Colors.white,
                onPrimary: const Color(0xFF008999),
                minimumSize: const Size(300, 60)
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 120.0))
          ],
        ),
      ),
    );
  }
}