// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:medical_center_patient/models/disease_details.dart';
import 'package:medical_center_patient/models/patient_medical_diagnosis.dart';
import 'package:medical_center_patient/models/symptom.dart';

class MedicalDiagnosisDetails {
  final List<Symptom> symptoms;
  final PatientMedicalDiagnosis diagnosis;
  final DiseaseDetails diseaseDetails;
  MedicalDiagnosisDetails({
    required this.symptoms,
    required this.diagnosis,
    required this.diseaseDetails,
  });

  MedicalDiagnosisDetails copyWith({
    List<Symptom>? symptoms,
    PatientMedicalDiagnosis? diagnosis,
    DiseaseDetails? diseaseDetails,
  }) {
    return MedicalDiagnosisDetails(
      symptoms: symptoms ?? this.symptoms,
      diagnosis: diagnosis ?? this.diagnosis,
      diseaseDetails: diseaseDetails ?? this.diseaseDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'symptoms': symptoms.map((x) => x.toMap()).toList(),
      'diagnosis': diagnosis.toMap(),
      'diseaseDetails': diseaseDetails.toMap(),
    };
  }

  factory MedicalDiagnosisDetails.fromMap(Map<String, dynamic> map) {
    return MedicalDiagnosisDetails(
      symptoms: List<Symptom>.from(
        (map['symptoms'] as List).map<Symptom>(
          (x) => Symptom.fromMap(x as Map<String, dynamic>),
        ),
      ),
      diagnosis: PatientMedicalDiagnosis.fromMap(
          map['diagnosis'] as Map<String, dynamic>),
      diseaseDetails:
          DiseaseDetails.fromMap(map['diseaseDetails'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicalDiagnosisDetails.fromJson(String source) =>
      MedicalDiagnosisDetails.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MedicalDiagnosisDetails(symptoms: $symptoms, diagnosis: $diagnosis, diseaseDetails: $diseaseDetails)';

  @override
  bool operator ==(covariant MedicalDiagnosisDetails other) {
    if (identical(this, other)) return true;

    return listEquals(other.symptoms, symptoms) &&
        other.diagnosis == diagnosis &&
        other.diseaseDetails == diseaseDetails;
  }

  @override
  int get hashCode =>
      symptoms.hashCode ^ diagnosis.hashCode ^ diseaseDetails.hashCode;
}
