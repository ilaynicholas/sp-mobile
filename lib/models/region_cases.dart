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