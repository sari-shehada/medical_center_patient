// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:medical_center_patient/core/extensions/date_time_extensions.dart';

class PatientMedicalDiagnosis {
  final int id;
  final int diseaseId;
  final int patientId;
  final DateTime diagnosisDateTime;
  final bool isSubmittedForFurtherFollowup;
  PatientMedicalDiagnosis({
    required this.id,
    required this.diseaseId,
    required this.patientId,
    required this.diagnosisDateTime,
    required this.isSubmittedForFurtherFollowup,
  });

  PatientMedicalDiagnosis copyWith({
    int? id,
    int? diseaseId,
    int? patientId,
    DateTime? diagnosisDateTime,
    bool? isSubmittedForFurtherFollowup,
  }) {
    return PatientMedicalDiagnosis(
      id: id ?? this.id,
      diseaseId: diseaseId ?? this.diseaseId,
      patientId: patientId ?? this.patientId,
      diagnosisDateTime: diagnosisDateTime ?? this.diagnosisDateTime,
      isSubmittedForFurtherFollowup:
          isSubmittedForFurtherFollowup ?? this.isSubmittedForFurtherFollowup,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'diseaseId': diseaseId,
      'patientId': patientId,
      'diagnosisDateTime': diagnosisDateTime.getDateOnly(),
      'isSubmittedForFurtherFollowup': isSubmittedForFurtherFollowup,
    };
  }

  factory PatientMedicalDiagnosis.fromMap(Map<String, dynamic> map) {
    return PatientMedicalDiagnosis(
      id: map['id'] as int,
      diseaseId: map['diseaseId'] as int,
      patientId: map['patientId'] as int,
      diagnosisDateTime: DateTime.parse(map['diagnosisDateTime']),
      isSubmittedForFurtherFollowup:
          map['isSubmittedForFurtherFollowup'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientMedicalDiagnosis.fromJson(String source) =>
      PatientMedicalDiagnosis.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MedicalDiagnosis(id: $id, diseaseId: $diseaseId, patientId: $patientId, diagnosisDateTime: $diagnosisDateTime, isSubmittedForFurtherFollowup: $isSubmittedForFurtherFollowup)';
  }

  @override
  bool operator ==(covariant PatientMedicalDiagnosis other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.diseaseId == diseaseId &&
        other.patientId == patientId &&
        other.diagnosisDateTime == diagnosisDateTime &&
        other.isSubmittedForFurtherFollowup == isSubmittedForFurtherFollowup;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        diseaseId.hashCode ^
        patientId.hashCode ^
        diagnosisDateTime.hashCode ^
        isSubmittedForFurtherFollowup.hashCode;
  }
}
