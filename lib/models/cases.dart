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