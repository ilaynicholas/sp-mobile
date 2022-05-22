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
        return const LoginScreen();
      } else {
        return FutureBuilder<bool>(
          future: isUser(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              if(data == true) {
                return const UserNavbar();
              } else {
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

  Future<bool> isUser() async {
    bool check = false;
    await FirebaseFirestore.instance
      .collection('users')
      .doc(_user!.uid)
      .get()
      .then((value) => {
        if (value.exists) {
          check = true
        }
      });

    return check;
  }
}