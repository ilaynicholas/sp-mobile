class Case {
  final int activeCases;
  final int recoveries;

  const Case({
    required this.activeCases,
    required this.recoveries
  });

  factory Case.fromJson(Map<String, dynamic> json) {
    return Case(
      activeCases: json['data']['active_cases'],
      recoveries: json['data']['recoveries']
    );
  }
}