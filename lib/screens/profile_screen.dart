import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<NewUser> futureUserDetails;

  List<String> vaccinationStatuses = [
    "Fully vaccinated with booster shot",
    "Fully vaccinated without booster shot",
    "One dose only",
    "Not yet vaccinated"
  ];

  @override
  void initState() {
    super.initState();
    futureUserDetails = getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFF00CDA6)]
        )
      ),
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 56)),
          const SizedBox(height: 56),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
              color: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<NewUser>(
                    future: futureUserDetails,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!.name.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF13677D)
                          )
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      return const CircularProgressIndicator();
                    }
                  ),
                  FutureBuilder<NewUser>(
                    future: futureUserDetails,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!.barangay.toString() + ", " + snapshot.data!.municipality.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          )
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      return const CircularProgressIndicator();
                    }
                  ),
                  FutureBuilder<NewUser>(
                    future: futureUserDetails,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!.number.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          )
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      return const CircularProgressIndicator();
                    }
                  ),
                  FutureBuilder<NewUser>(
                    future: futureUserDetails,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          vaccinationStatuses[snapshot.data!.vaccinationStatus],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      return const CircularProgressIndicator();
                    }
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ElevatedButton(
                        onPressed: () { // update vaccination status page
                        
                        },
                        child: const Text(
                            "UPDATE VACCINATION STATUS",
                            style: TextStyle(
                                fontSize: 18.0,
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
                    ),
                  ),
                  const SizedBox(height:40),
                  const Text(
                    "Essential Links",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    child: const Text(
                      "\u2022 Batang Gapan Facebook Page",
                      style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.underline
                      )
                    ),
                    onTap: () => launchUrl(Uri.parse('https://www.facebook.com/batanggapanako')),
                  ),
                  InkWell(
                    child: const Text(
                      "\u2022 Gapan City Official Website",
                      style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.underline
                      )
                    ),
                    onTap: () => launchUrl(Uri.parse('https://www.cityofgapan.com/')),
                  ),
                   InkWell(
                    child: const Text(
                      "\u2022 Department of Health Official Website",
                      style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.underline
                      )
                    ),
                    onTap: () => launchUrl(Uri.parse('https://doh.gov.ph/')),
                  ),
                  const SizedBox(height: 60),
                  const Text(
                    "Hotlines",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "\u2022 Local Hospital: 09759196958",
                    style: TextStyle(
                      fontSize: 18
                    )
                  ),
                  const Text(
                    "\u2022 City Hall: (044) 4860513",
                    style: TextStyle(
                      fontSize: 18
                    )
                  ),
                  const Text(
                    "\u2022 Vaccination Center: 09914485475",
                    style: TextStyle(
                      fontSize: 18
                    )
                  )
                ],
              ),
            ),
          )
        ]
      )
    );
  }

  Future<NewUser> getUserDetails() async {
    dynamic data;

    await FirebaseFirestore.instance
      .collection('users')
      .doc("RbdBr0tRI2O8lDdK1ad7VV440O12")
      .get()
      .then((DocumentSnapshot documentSnapshot) {
        if(documentSnapshot.exists) {
          data = documentSnapshot.data();
        } else {
          throw Exception("Failed to load user details");
        }
      });

    if(data != null) {
      return NewUser.fromJson(data);
    } else {
      throw Exception("Failed to load user details.");
    }
  }
}