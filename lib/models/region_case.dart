class RegionCase {
  final int activeCases;
  final int totalCases;
  final int recoveries;
  final int deaths;

  const RegionCase({
    required this.activeCases,
    required this.totalCases,
    required this.recoveries,
    required this.deaths
  });

  factory RegionCase.fromJson(Map<String, dynamic> json) {
    return RegionCase(
      activeCases: json['data']['active_cases'],
      totalCases: json['data']['total'],
      recoveries: json['data']['recoveries'],
      deaths: json['data']['deaths']
    );
  }
}