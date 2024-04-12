// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:medical_center_patient/core/extensions/date_time_extensions.dart';

class DoctorInfo {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final DateTime dateOfBirth;
  final DateTime careerStartDate;
  final bool isMale;
  DoctorInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.dateOfBirth,
    required this.careerStartDate,
    required this.isMale,
  });

  DoctorInfo copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? username,
    DateTime? dateOfBirth,
    DateTime? careerStartDate,
    bool? isMale,
  }) {
    return DoctorInfo(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      careerStartDate: careerStartDate ?? this.careerStartDate,
      isMale: isMale ?? this.isMale,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'dateOfBirth': dateOfBirth.getDateOnly(),
      'careerStartDate': careerStartDate.getDateOnly(),
      'isMale': isMale,
    };
  }

  String get fullName => '$firstName $lastName';
  factory DoctorInfo.fromMap(Map<String, dynamic> map) {
    return DoctorInfo(
      id: map['id'] as int,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      username: map['username'] as String,
      dateOfBirth: DateTime.parse(map['dateOfBirth']),
      careerStartDate: DateTime.parse(map['careerStartDate']),
      isMale: map['isMale'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorInfo.fromJson(String source) =>
      DoctorInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DoctorInfo(id: $id, firstName: $firstName, lastName: $lastName, username: $username, dateOfBirth: $dateOfBirth, careerStartDate: $careerStartDate, isMale: $isMale)';
  }

  @override
  bool operator ==(covariant DoctorInfo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.username == username &&
        other.dateOfBirth == dateOfBirth &&
        other.careerStartDate == careerStartDate &&
        other.isMale == isMale;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        username.hashCode ^
        dateOfBirth.hashCode ^
        careerStartDate.hashCode ^
        isMale.hashCode;
  }
}
