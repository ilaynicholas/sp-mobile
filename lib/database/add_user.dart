import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser extends StatelessWidget {
  final String barangay;
  final String municipality;
  final String name;
  final String number;
  final int vaccinationStatus;

  AddUser(this.name, this.number, this.municipality, this.barangay, this.vaccinationStatus);

  @override
  Widget build(BuildContext context) {

    Future<void> addUser() {
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

    return TextButton(
      onPressed: addUser,
      child: const Text("Add User")
    );
  }
}