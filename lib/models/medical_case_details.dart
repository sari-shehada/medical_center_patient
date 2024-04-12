// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:medical_center_patient/models/disease.dart';
import 'package:medical_center_patient/models/doctor_info.dart';
import 'package:medical_center_patient/models/medical_case.dart';
import 'package:medical_center_patient/models/patient_medical_diagnosis.dart';
import 'package:medical_center_patient/models/symptom.dart';

class MedicalCaseDetails {
  final MedicalCase medicalCase;
  final PatientMedicalDiagnosis patientDiagnosis;
  final Disease disease;
  final List<Symptom> symptoms;
  final DoctorInfo? assignedDoctor;
  final int numberOfUnreadMessages;
  MedicalCaseDetails({
    required this.medicalCase,
    required this.patientDiagnosis,
    required this.disease,
    required this.symptoms,
    this.assignedDoctor,
    required this.numberOfUnreadMessages,
  });

  MedicalCaseDetails copyWith({
    MedicalCase? medicalCase,
    PatientMedicalDiagnosis? patientDiagnosis,
    Disease? disease,
    List<Symptom>? symptoms,
    DoctorInfo? assignedDoctor,
    int? numberOfUnreadMessages,
  }) {
    return MedicalCaseDetails(
      medicalCase: medicalCase ?? this.medicalCase,
      patientDiagnosis: patientDiagnosis ?? this.patientDiagnosis,
      disease: disease ?? this.disease,
      symptoms: symptoms ?? this.symptoms,
      assignedDoctor: assignedDoctor ?? this.assignedDoctor,
      numberOfUnreadMessages:
          numberOfUnreadMessages ?? this.numberOfUnreadMessages,
    );
  }

  factory MedicalCaseDetails.fromMap(Map<String, dynamic> map) {
    return MedicalCaseDetails(
      medicalCase:
          MedicalCase.fromMap(map['medicalCase'] as Map<String, dynamic>),
      patientDiagnosis: PatientMedicalDiagnosis.fromMap(
          map['patientDiagnosis'] as Map<String, dynamic>),
      disease: Disease.fromMap(map['disease'] as Map<String, dynamic>),
      symptoms: List<Symptom>.from(
        (map['symptoms'] as List).map<Symptom>(
          (x) => Symptom.fromMap(x as Map<String, dynamic>),
        ),
      ),
      assignedDoctor: map['assignedDoctor'] != null
          ? DoctorInfo.fromMap(map['assignedDoctor'] as Map<String, dynamic>)
          : null,
      numberOfUnreadMessages: map['numberOfUnreadMessages'] as int,
    );
  }

  factory MedicalCaseDetails.fromJson(String source) =>
      MedicalCaseDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MedicalCaseDetails(medicalCase: $medicalCase, patientDiagnosis: $patientDiagnosis, disease: $disease, symptoms: $symptoms, assignedDoctor: $assignedDoctor, numberOfUnreadMessages: $numberOfUnreadMessages)';
  }

  @override
  bool operator ==(covariant MedicalCaseDetails other) {
    if (identical(this, other)) return true;

    return other.medicalCase == medicalCase &&
        other.patientDiagnosis == patientDiagnosis &&
        other.disease == disease &&
        listEquals(other.symptoms, symptoms) &&
        other.assignedDoctor == assignedDoctor &&
        other.numberOfUnreadMessages == numberOfUnreadMessages;
  }

  @override
  int get hashCode {
    return medicalCase.hashCode ^
        patientDiagnosis.hashCode ^
        disease.hashCode ^
        symptoms.hashCode ^
        assignedDoctor.hashCode ^
        numberOfUnreadMessages.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'medicalCase': medicalCase.toMap(),
      'patientDiagnosis': patientDiagnosis.toMap(),
      'disease': disease.toMap(),
      'symptoms': symptoms.map((x) => x.toMap()).toList(),
      'assignedDoctor': assignedDoctor?.toMap(),
      'numberOfUnreadMessages': numberOfUnreadMessages,
    };
  }

  String toJson() => json.encode(toMap());
}
