import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sp_mobile/main.dart';
import 'package:sp_mobile/models/establishment.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileEstabScreen extends StatefulWidget {
  const ProfileEstabScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileEstabScreen> createState() => _ProfileEstabScreenState();
}

class _ProfileEstabScreenState extends State<ProfileEstabScreen> {
  late Future<Establishment> futureEstabDetails;

  @override
  void initState() {
    super.initState();
    futureEstabDetails = getEstabDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFF00CDA6)]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0)
                ),
                color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<Establishment>(
                      future: futureEstabDetails,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.name.toString(),
                            style: const TextStyle(
                              fontSize: 22,
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
                    FutureBuilder<Establishment>(
                      future: futureEstabDetails,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.barangay.toString() + ", " + snapshot.data!.municipality.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                            )
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
            
                        return const CircularProgressIndicator();
                      }
                    ),
                    FutureBuilder<Establishment>(
                      future: futureEstabDetails,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.number.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                            )
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
            
                        return const CircularProgressIndicator();
                      }
                    ),
                    const SizedBox(height:80),
                    const Text(
                      "Essential Links",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      child: const Text(
                        "\u2022 Batang Gapan Facebook Page",
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline
                        )
                      ),
                      onTap: () => launchUrl(Uri.parse('https://www.facebook.com/batanggapanako')),
                    ),
                    InkWell(
                      child: const Text(
                        "\u2022 Gapan City Official Website",
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline
                        )
                      ),
                      onTap: () => launchUrl(Uri.parse('https://www.cityofgapan.com/')),
                    ),
                     InkWell(
                      child: const Text(
                        "\u2022 Department of Health Official Website",
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline
                        )
                      ),
                      onTap: () => launchUrl(Uri.parse('https://doh.gov.ph/')),
                    ),
                    const SizedBox(height: 80),
                    const Text(
                      "Hotlines",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "\u2022 Local Hospital: 09759196958",
                      style: TextStyle(
                        fontSize: 16
                      )
                    ),
                    const Text(
                      "\u2022 City Hall: (044) 4860513",
                      style: TextStyle(
                        fontSize: 16
                      )
                    ),
                    const Text(
                      "\u2022 Vaccination Center: 09914485475",
                      style: TextStyle(
                        fontSize: 16
                      )
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => const InitializerWidget())
                            );
                          },
                          child: const Text(
                            "SIGN OUT",
                            style: TextStyle(
                                fontSize: 22.0,
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
                    )
                  ],
                ),
              ),
            )
          ]
        )
      ),
    );
  }

  Future<Establishment> getEstabDetails() async {
    dynamic data;

    await FirebaseFirestore.instance
      .collection('establishments')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
        if(documentSnapshot.exists) {
          data = documentSnapshot.data();
        } else {
          throw Exception("Failed to load establishment details");
        }
      });

    if(data != null) {
      return Establishment.fromJson(data);
    } else {
      throw Exception("Failed to load establishment details.");
    }
  }
}