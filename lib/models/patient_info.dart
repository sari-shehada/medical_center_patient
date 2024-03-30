import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PatientInfo {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final bool isMale;
  final DateTime dateOfBirth;
  PatientInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.isMale,
    required this.dateOfBirth,
  });

  factory PatientInfo.fromMap(Map<String, dynamic> map) {
    return PatientInfo(
      id: map['id'] as int,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      username: map['username'] as String,
      isMale: map['isMale'] as bool,
      dateOfBirth: DateTime.parse(map['dateOfBirth']),
    );
  }

  factory PatientInfo.fromJson(String source) =>
      PatientInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
