import 'package:flutter/material.dart';

class SymptomsScreen extends StatefulWidget {
  const SymptomsScreen({ Key? key }) : super(key: key);

  @override
  State<SymptomsScreen> createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends State<SymptomsScreen> {
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 56)),
                      const SizedBox(height: 56),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          'images/symptoms.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover
                        ),
                      ),
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
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Symptoms of COVID-19",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const Text(
                                "Mga Sintomas ng COVID-19",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontStyle: FontStyle.italic
                                )
                              ),
                              const Padding(padding: EdgeInsets.only(top: 24)),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromRGBO(0, 0, 0, 1)
                                  ),
                                  children: [
                                    TextSpan(text: "\u2022 Fever or chills "),
                                    TextSpan(text: "(lagnat o panginginig)", style: TextStyle(fontStyle: FontStyle.italic))
                                  ]
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black
                                  ),
                                  children: [
                                    TextSpan(text: "\u2022 Cough "),
                                    TextSpan(text: "(ubo)", style: TextStyle(fontStyle: FontStyle.italic))
                                  ]
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black
                                  ),
                                  children: [
                                    TextSpan(text: "\u2022 Shortness of breath "),
                                    TextSpan(text: "(kahirapan sa paghinga)", style: TextStyle(fontStyle: FontStyle.italic))
                                  ]
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black
                                  ),
                                  children: [
                                    TextSpan(text: "\u2022 Fatigue "),
                                    TextSpan(text: "(pagkapagod)", style: TextStyle(fontStyle: FontStyle.italic))
                                  ]
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black
                                  ),
                                  children: [
                                    TextSpan(text: "\u2022 Muscle aches "),
                                    TextSpan(text: "(pananakit ng kalamnan)", style: TextStyle(fontStyle: FontStyle.italic))
                                  ]
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black
                                  ),
                                  children: [
                                    TextSpan(text: "\u2022 Headache "),
                                    TextSpan(text: "(sakit ng ulo)", style: TextStyle(fontStyle: FontStyle.italic))
                                  ]
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black
                                  ),
                                  children: [
                                    TextSpan(text: "\u2022 Loss of taste or smell "),
                                    TextSpan(text: "(pagkawala ng panlasa o pang-amoy)", style: TextStyle(fontStyle: FontStyle.italic))
                                  ]
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black
                                  ),
                                  children: [
                                    TextSpan(text: "\u2022 Sore throat "),
                                    TextSpan(text: "(sakit sa lalamunan)", style: TextStyle(fontStyle: FontStyle.italic))
                                  ]
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black
                                  ),
                                  children: [
                                    TextSpan(text: "\u2022 Congestion or runny nose "),
                                    TextSpan(text: "(sipon)", style: TextStyle(fontStyle: FontStyle.italic))
                                  ]
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black
                                  ),
                                  children: [
                                    TextSpan(text: "\u2022 Nausea or vomiting "),
                                    TextSpan(text: "(pagduduwal o pagsusuka)", style: TextStyle(fontStyle: FontStyle.italic))
                                  ]
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(text: "\u2022 Diarrhea "),
                                    TextSpan(text: "(pagtatae)", style: TextStyle(fontStyle: FontStyle.italic))
                                  ]
                                ),
                              ),
                              const SizedBox(height: 36.0),
                              const Text(
                                "Source: Centers for Disease Control and Prevention",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontStyle: FontStyle.italic
                                )
                              )
                            ]
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}