import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_navbar.dart';
import '../models/user.dart';
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

  FirebaseAuth auth = FirebaseAuth.instance;

  String? _selectedValueBarangay;
  String? _selectedValueStatus;
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
  List<String> vaccinationStatuses = [
    "Fully vaccinated with booster shot",
    "Fully vaccinated without booster shot",
    "One dose only",
    "Not yet vaccinated"
  ];

  @override
  void dispose() {
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 20, 8, 10),
                        child: TextFormField(
                          controller: firstNameController,
                          validator: (value) {
                            if(value == null || value.isEmpty) return "Please enter your first name";
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            labelText: "First Name",
                            labelStyle: TextStyle(fontSize: 14)
                          )
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: TextFormField(
                          controller: middleNameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            labelText: "Middle Name (optional)",
                            labelStyle: TextStyle(fontSize: 14)
                          )
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: TextFormField(
                          controller: lastNameController,
                          validator: (value) {
                            if(value == null || value.isEmpty) return "Please enter your last name";
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            labelText: "Last Name",
                            labelStyle: TextStyle(fontSize: 14)
                          )
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: TextFormField(
                          controller: numberController,
                          validator: (value) {
                            if(value == null || value.isEmpty) return "Please enter your mobile number";
                            if(value.length != 9) return "Please enter 11 digits";
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            labelText: "Mobile Number (09XXXXXXXXX)",
                            labelStyle: TextStyle(fontSize: 14),
                            prefixText: "09"
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
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: DropdownButtonFormField(
                          value: _selectedValueStatus,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            labelText: "Are you vaccinated?",
                            labelStyle: TextStyle(fontSize: 14)
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              _selectedValueStatus = value as String;
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              _selectedValueStatus = value as String;
                            });
                          },
                          validator: (value) {
                            if(value == null) return "Please select a vaccination status";
                            return null;
                          },
                          items: vaccinationStatuses.map((String val) {
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
                              await auth.signInAnonymously();
                              NewUser newUser = NewUser(
                                name: middleNameController.text == "" ? firstNameController.text + " " + lastNameController.text : firstNameController.text + " " + middleNameController.text + " " + lastNameController.text,
                                number: "09" + numberController.text,
                                municipality: "Gapan City",
                                barangay: _selectedValueBarangay,
                                vaccinationStatus: vaccinationStatuses.indexOf(_selectedValueStatus!)
                              );
                              addUser(
                                FirebaseAuth.instance.currentUser!.uid,
                                newUser
                              );
                              
                            }
                          },
                          child: const Text(
                              "REGISTER",
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

  Future<void> addUser(uid, NewUser newUser) {
      return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set({
          'name': newUser.name,
          'number': newUser.number,
          'municipality': newUser.municipality,
          'barangay': newUser.barangay,
          'vaccinationStatus': newUser.vaccinationStatus
        })
        .then((value) => Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => const UserNavbar())))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error))));
    }
}