import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sp_mobile/models/establishment.dart';

import 'establishment/navbar_estab.dart';

class RegisterEstabScreen extends StatefulWidget {
  const RegisterEstabScreen({ Key? key }) : super(key: key);

  @override
  State<RegisterEstabScreen> createState() => _RegisterEstabScreenState();
}

class _RegisterEstabScreenState extends State<RegisterEstabScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final numberController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  String? _selectedValueBarangay;

  List<String> barangays = [
    "Balante",
    "Bayanihan",
    "Bulak",
    "Bungo",
    "Kapalangan",
    "Mabuga",
    "Maburak",
    "Macabaklay",
    "Mahipon",
    "Malimba",
    "Mangino",
    "Marelo",
    "Pambuan",
    "Parcutela",
    "Puting Tubig",
    "San Lorenzo",
    "San Nicolas",
    "San Roque",
    "San Vicente",
    "Santa Cruz",
    "Santo Cristo Norte",
    "Santo Cristo Sur",
    "Santo Niño"
  ];

  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SingleChildScrollView(
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 50)),
              Row(
                children: [
                  const Spacer(),
                  Column(
                    children: const [
                      Text(
                        "GapanTrax",
                        style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF008999),
                        )
                      ),
                      Text(
                        "Contact Tracing Application of\nGapan City",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF008999),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const Spacer()
                ]
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      'images/syringe.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'images/face-mask.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover
                    ),
                  )
                ],
              ),
              const SizedBox(height:100),
              Center(
                child: Image.asset(
                  'images/estab.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)
                  ),
                  color: Colors.white
                ),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 20, 8, 10),
                        child: TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if(value == null || value.isEmpty) return "Please enter establishment name";
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            labelText: "Establishment Name",
                            labelStyle: TextStyle(fontSize: 14)
                          )
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            labelText: FirebaseAuth.instance.currentUser!.phoneNumber,
                            labelStyle: const TextStyle(fontSize: 14),
                          )
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: TextFormField(
                          enabled: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            labelText: "Gapan City",
                            labelStyle: TextStyle(fontSize: 14)
                          )
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: DropdownButtonFormField(
                          value: _selectedValueBarangay,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            labelText: "Barangay",
                            labelStyle: TextStyle(fontSize: 14)
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _selectedValueBarangay = value as String?;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              _selectedValueBarangay = value as String?;
                            });
                          },
                          validator: (value) {
                            if(value == null) return "Please select a barangay";
                            return null;
                          },
                          items: barangays.map((String val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(val)
                            );
                          }).toList()
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Establishment estab = Establishment(
                                name: nameController.text, 
                                number: FirebaseAuth.instance.currentUser!.phoneNumber,
                                municipality: "Gapan City", 
                                barangay: _selectedValueBarangay, 
                                isApproved: false
                              );

                              addEstablishment(
                                FirebaseAuth.instance.currentUser!.uid,
                                estab
                              );
                            }
                          },
                          child: 
                            isLoading ? const CircularProgressIndicator(color: Colors.white) : 
                              const Text(
                                "Register as\nEstablishment",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold
                                  ),
                                textAlign: TextAlign.center
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
                    ],
                  )
                )
              )
            ],
          )
        )
      )
    );
  }

  addEstablishment(uid, Establishment estab) async {
    setState(() {
      isLoading = true;
    });

    await FirebaseFirestore.instance
      .collection("establishments")
      .doc(uid)
      .set({
        'name': estab.name,
        'number': estab.number,
        'municipality': estab.municipality,
        'barangay': estab.barangay,
        'isApproved': estab.isApproved
      })
      .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error))));

    setState(() {
      isLoading = false;
    });

    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const EstabNavbar())
    );
  }
}