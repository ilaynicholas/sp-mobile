// class Case {
//   final int activeCases;
//   final int recoveries;

//   const Case({
//     required this.activeCases,
//     required this.recoveries
//   });

//   factory Case.fromJson(Map<String, dynamic> json) {
//     return Case(
//       activeCases: json['data']['active_cases'],
//       recoveries: json['data']['recoveries']
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Log {
  final String establishmentId;
  final String userId;
  final Timestamp timestamp;

  const Log({
    required this.establishmentId,
    required this.userId,
    required this.timestamp
  });

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      establishmentId: json['establishmentId'],
      userId: json['userId'],
      timestamp: json['timestamp']
    );
  }
}