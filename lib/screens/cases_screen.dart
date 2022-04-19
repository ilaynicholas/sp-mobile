import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CasesScreen extends StatefulWidget {
  const CasesScreen({ Key? key }) : super(key: key);

  @override
  State<CasesScreen> createState() => _CasesScreenState();
}

class _CasesScreenState extends State<CasesScreen> {
  late Future<Cases> futureCases;

  @override
  void initState() {
    super.initState();
    futureCases = fetchCases();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFF00CDA6)]
        )
      ),
      child: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 56)),
            const SizedBox(height: 56),
            Container(
              height: 80,
              width: 350,
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
                children: const [
                  Text(
                    "COVID-19 Cases",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                    ),
                  ),
                  Text(
                    "Central Luzon",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF13677D)
                    )
                  )
                ],
              )
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    height: 80,
                    width: 200,
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
                    child: const Text(
                      "New Cases",
                    )
                  )
                ),
                const SizedBox(width: 10),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    height: 80,
                    width: 120,
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
                    child: const Text(
                      "Active"
                    )
                  )
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    height: 80,
                    width: 200,
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
                    child: const Text(
                      "Recoveries",
                    )
                  )
                ),
                const SizedBox(width: 10),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    height: 80,
                    width: 120,
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
                    child: const Text(
                      "Deaths"
                    )
                  )
                )
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Source: Department of Health",
              style: TextStyle(
                fontSize: 14.0,
                fontStyle: FontStyle.italic
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 80,
              width: 350,
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
                children: const [
                  Text(
                    "COVID-19 Cases",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                    ),
                  ),
                  Text(
                    "Philippines",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF13677D)
                    )
                  )
                ],
              )
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    height: 80,
                    width: 200,
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
                          "Active Cases",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                        ),
                        FutureBuilder<Cases>(
                          future: futureCases,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!.activeCases.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36,
                                  color: Color(0xFFFF0000)
                                )
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }

                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          }
                        )
                      ],
                    )
                  )
                ),
                const SizedBox(width: 10),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    height: 80,
                    width: 120,
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
                          "Recoveries",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                        ),
                        FutureBuilder<Cases>(
                          future: futureCases,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!.recoveries.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36,
                                  color: Color(0xFF008999)
                                )
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }

                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          }
                        )
                      ],
                    )
                  )
                )
              ],
            ),
            const SizedBox(height: 20)
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly
        ),
      )
    );
  }

  Future<Cases> fetchCases() async {
    final response = await http.get(Uri.parse("https://covid19-api-philippines.herokuapp.com/api/summary"));

    if(response.statusCode == 200) {
      return Cases.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load cases");
    }
  }

  Future<RegionCases> fetchRegionCases() async {
    final response = await http.get(Uri.parse("https://covid19-api-philippines.herokuapp.com/api/summary?region+iii:+central+luzon"));

    if(response.statusCode == 200) {
      return RegionCases.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load cases");
    }
  }
}

class Cases {
  final int activeCases;
  final int recoveries;

  const Cases({
    required this.activeCases,
    required this.recoveries
  });

  factory Cases.fromJson(Map<String, dynamic> json) {
    return Cases(
      activeCases: json['data']['active_cases'],
      recoveries: json['data']['recoveries']
    );
  }
}

class RegionCases {
  final int activeCases;
  final int totalCases;
  final int recoveries;
  final int deaths;

  const RegionCases({
    required this.activeCases,
    required this.totalCases,
    required this.recoveries,
    required this.deaths
  });

  factory RegionCases.fromJson(Map<String, dynamic> json) {
    return RegionCases(
      activeCases: json['data']['active_cases'],
      totalCases: json['data']['total'],
      recoveries: json['data']['recoveries'],
      deaths: json['data']['deaths']
    );
  }
}