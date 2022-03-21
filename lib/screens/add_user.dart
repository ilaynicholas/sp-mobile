import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser extends StatelessWidget {
  final String barangay;
  final String municipality;
  final String name;
  final String number;
  final int vaccinationStatus;

  AddUser(this.barangay, this.municipality, this.name, this.number, this.vaccinationStatus);

  @override
  Widget build(BuildContext context) {
    // CollectionReference users = FirebaseFirestore.instance.collection("users");

    // return FutureBuilder<DocumentSnapshot>(
    //   future: users.doc().get(),
    //   builder:
    //     (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //       if (snapshot.hasError) {
    //         return Text("Something went wrong");
    //       }

    //       if (snapshot.hasData && !snapshot.data!.exists) {
    //         return Text("Document does not exist");
    //       }

    //       if (snapshot.connectionState == ConnectionState.done) {
    //         Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
    //         return Text("Full Name: ${data['name']} ${data['barangay']}");
    //       }

    //       return Text("loading");
    //     }
    // );

    Future<void> addUser() {
      return FirebaseFirestore.instance
        .collection("users")
        .add({
          'barangay': barangay,
          'municipality': municipality,
          'name': name,
          'number': number,
          'vaccinationStatus': vaccinationStatus
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addUser,
      child: const Text("Add User")
    );
  }
}