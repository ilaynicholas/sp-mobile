import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({ Key? key }) : super(key: key);

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final numberController = TextEditingController();
  final municipalityController = TextEditingController();
  final barangayController = TextEditingController();
  final vaccinationStatusController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    numberController.dispose();
    numberController.dispose();
    municipalityController.dispose();
    barangayController.dispose();
    vaccinationStatusController.dispose();
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
                  Container(
                    width: 85,
                    height: 85,
                    decoration: const BoxDecoration(
                      color: Color(0xFF008999),
                      shape: BoxShape.circle
                    )
                  ),
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
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Container(
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: TextFormField(
                          controller: firstNameController,
                          validator: (value) {
                            if(value == null || value.isEmpty) return "Please enter your first name";
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "First Name",
                            hintStyle: TextStyle(fontSize: 14)
                          )
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: TextFormField(
                          controller: middleNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Middle Name (optional)",
                            hintStyle: TextStyle(fontSize: 14)
                          )
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: TextFormField(
                          controller: lastNameController,
                          validator: (value) {
                            if(value == null || value.isEmpty) return "Please enter your last name";
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Last Name",
                            hintStyle: TextStyle(fontSize: 14)
                          )
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: TextFormField(
                          controller: numberController,
                          validator: (value) {
                            if(value == null || value.isEmpty) return "Please enter your mobile number";
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Mobile Number",
                            hintStyle: TextStyle(fontSize: 14)
                          )
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: TextFormField(
                          controller: municipalityController,
                          validator: (value) {
                            if(value == null || value.isEmpty) return "Please select your municipality";
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Municipality",
                            hintStyle: TextStyle(fontSize: 14)
                          )
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: TextFormField(
                          controller: barangayController,
                          validator: (value) {
                            if(value == null || value.isEmpty) return "Please select your barangay";
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Barangay",
                            hintStyle: TextStyle(fontSize: 14)
                          )
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: TextFormField(
                          controller: vaccinationStatusController,
                          validator: (value) {
                            if(value == null || value.isEmpty) return "Please select your vaccination status";
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Are you vaccinated?",
                            hintStyle: TextStyle(fontSize: 14)
                          )
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              addUser(
                                firstNameController.text + middleNameController.text + lastNameController.text,
                                numberController.text,
                                municipalityController.text,
                                barangayController.text,
                                int.parse(vaccinationStatusController.text)
                              );
                              // await auth.signInAnonymously();
                            }
                          },
                          child: const Text(
                              "SUBMIT",
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
                      ),
                    ]
                  ),
                ),
              )
            ],
          )
        ),
      )
    );
  }

  Future<void> addUser(name, number, municipality, barangay, vaccinationStatus) {
      return FirebaseFirestore.instance
        .collection("users")
        .add({
          'name': name,
          'number': number,
          'municipality': municipality,
          'barangay': barangay,
          'vaccinationStatus': vaccinationStatus
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    }
}