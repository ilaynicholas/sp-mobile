import 'package:flutter/material.dart';
import 'package:sp_mobile/screens/register_user_screen.dart';
import 'register_estab_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({ Key? key }) : super(key: key);

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
            const Spacer(),
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                color: Color(0xFF008999),
                shape: BoxShape.circle
              )
            ),
            const Padding(padding: EdgeInsets.only(top: 15)),
            const Text(
              "GapanTrax",
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF008999),
              )
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
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
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'images/syringe.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'images/face-mask.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover
                  ),
                )
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterUserScreen())
                );
              },
              child: const Text(
                  "REGISTER",
                  style: TextStyle(
                      fontSize: 24.0,
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterEstabScreen())
                );
              },
              child: const Text(
                  "Register as\nEstablishment",
                  style: TextStyle(
                      fontSize: 18.0,
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
            const Padding(padding: EdgeInsets.only(bottom: 100.0))
          ],
        ),
      ),
    );
  }
}