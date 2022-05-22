import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StatusWidget extends StatefulWidget {
  const StatusWidget({ Key? key }) : super(key: key);

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  Stream<DocumentSnapshot> documentStream = FirebaseFirestore.instance.collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: documentStream,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if(snapshot.hasData) {
          if(snapshot.data!['covidStatus'] == 0) {
            return RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: const [
                  TextSpan(
                    text: "You are COVID-19 ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    )
                  ),
                  TextSpan(
                    text: "NEGATIVE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF2FA804)
                    )
                  )
                ]
              ),
            );
          } else if(snapshot.data!['covidStatus'] == 1) {
            return RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: const [
                  TextSpan(
                    text: "You are COVID-19 ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    )
                  ),
                  TextSpan(
                    text: "POSITIVE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFFFF0000)
                    )
                  )
                ]
              ),
            );
          } else if(snapshot.data!['covidStatus'] == 2) {
            return RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: const [
                  TextSpan(
                    text: "You are a ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    )
                  ),
                  TextSpan(
                    text: "CLOSE CONTACT",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFFBCBF1D)
                    )
                  )
                ]
              ),
            );
          }
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      }
    );
  }
}