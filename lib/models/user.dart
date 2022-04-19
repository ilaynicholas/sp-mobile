class NewUser {
  final String name;
  final String number;
  final String municipality;
  final String? barangay;
  final int vaccinationStatus;

  const NewUser({
    required this.name,
    required this.number,
    required this.municipality,
    required this.barangay,
    required this.vaccinationStatus
  });
}