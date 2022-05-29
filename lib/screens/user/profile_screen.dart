import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sp_mobile/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Stream<DocumentSnapshot> documentStream = FirebaseFirestore.instance.collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .snapshots();

  late Future<NewUser> futureUserDetails;

  List<String> vaccinationStatuses = [
    "Fully vaccinated with booster shot",
    "Fully vaccinated without booster shot",
    "One dose only",
    "Not yet vaccinated"
  ];

  int? _status = 0;

  @override
  void initState() {
    super.initState();
    futureUserDetails = getUserDetails();
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
          children: [
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
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
                    FutureBuilder<NewUser>(
                      future: futureUserDetails,
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
                    FutureBuilder<NewUser>(
                      future: futureUserDetails,
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
                    StreamBuilder<DocumentSnapshot>(
                      stream: documentStream,
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            vaccinationStatuses[snapshot.data!['vaccinationStatus']],
                            style: const TextStyle(
                              fontSize: 16,
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
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => _buildPopupDialog(context)
                            );
                          },
                          child: const Text(
                              "UPDATE VACCINATION STATUS",
                              style: TextStyle(
                                  fontSize: 16.0,
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
                    const SizedBox(height: 60),
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

  Future<NewUser> getUserDetails() async {
    dynamic data;

    await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
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

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text("Select your vaccination status"),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List<Widget>.generate(4, (int index) {
              return RadioListTile<int>(
                title: Text(vaccinationStatuses[index]),
                value: index,
                groupValue: _status,
                onChanged: (int? value) {
                  setState(() => _status = value);
                }
              );
            }),
          );
        },
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            updateVaccinationStatus();
          },
          child: const Text('Save'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0)
            ),
            primary: const Color(0xFF008999),
            onPrimary: Colors.white
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0)
            ),
            primary: const Color(0xFFFF0000),
            onPrimary: Colors.white
          ),
        ),
      ],
    );
  }

  updateVaccinationStatus() async {
    await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({'vaccinationStatus': _status})
      .then(Navigator.of(context).pop)
      .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error))));
  }
}