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
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Cases>(
            future: futureCases,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.activeCases.toString());
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
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