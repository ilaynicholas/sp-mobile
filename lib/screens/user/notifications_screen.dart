import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({ Key? key }) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  Stream<DocumentSnapshot> documentStream = FirebaseFirestore.instance.collection('users')
    .doc("RbdBr0tRI2O8lDdK1ad7VV440O12")
    .snapshots();
    
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFF00CDA6)]
        )
      ),
      child: Center(
        child: Container(
          height: 250,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 4,
                offset: const Offset(4, 8), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "About your current COVID-19 status",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              StreamBuilder<DocumentSnapshot>(
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
                                fontSize: 16
                              )
                            ),
                            TextSpan(
                              text: "NEGATIVE",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF2FA804)
                              )
                            ),
                            TextSpan(
                              text: ". Please continue to practice preventive measures to protect yourself and your loved ones from the virus. Keep safe!",
                              style: TextStyle(
                                fontSize: 16
                              )
                            ),
                          ]
                        ),
                      );
                    } else if(snapshot.data!['covidStatus'] == 1) {
                      return RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: const [
                            TextSpan(
                              text: "The result of your swab test is ",
                              style: TextStyle(
                                fontSize: 16
                              )
                            ),
                            TextSpan(
                              text: "POSITIVE",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFFFF0000)
                              )
                            ),
                            TextSpan(
                              text: ". If you are experiencing any symptoms, please go to the nearest hospital. If you are asymptomatic, please self-quarantine for 14 days. Keep safe!",
                              style: TextStyle(
                                fontSize: 16
                              )
                            ),
                          ]
                        ),
                      );
                    } else if(snapshot.data!['covidStatus'] == 2) {
                      return RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: const [
                            TextSpan(
                              text: "You may have been ",
                              style: TextStyle(
                                fontSize: 16
                              )
                            ),
                            TextSpan(
                              text: "IN CONTACT",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFFBCBF1D)
                              )
                            ),
                            TextSpan(
                              text: " with an individual infected with COVID-19. If you are experiencing any symptoms, please go to the nearest hospital. If you are asymptomatic, Please self-quarantine for 14 days. Keep safe!",
                              style: TextStyle(
                                fontSize: 16
                              )
                            ),
                          ]
                        ),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const CircularProgressIndicator();
                }
              )
            ],
          )
        )
      )
    );
  }
}