// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:medical_center_patient/models/disease.dart';
import 'package:medical_center_patient/models/external_link.dart';
import 'package:medical_center_patient/models/medicine.dart';

class DiseaseDetails {
  final Disease disease;
  final List<Medicine> suggestedMedicines;
  final List<ExternalLink> externalLinks;
  DiseaseDetails({
    required this.disease,
    required this.suggestedMedicines,
    required this.externalLinks,
  });

  DiseaseDetails copyWith({
    Disease? disease,
    List<Medicine>? suggestedMedicines,
    List<ExternalLink>? externalLinks,
  }) {
    return DiseaseDetails(
      disease: disease ?? this.disease,
      suggestedMedicines: suggestedMedicines ?? this.suggestedMedicines,
      externalLinks: externalLinks ?? this.externalLinks,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'disease': disease.toMap(),
      'suggestedMedicines': suggestedMedicines.map((x) => x.toMap()).toList(),
      'externalLinks': externalLinks.map((x) => x.toMap()).toList(),
    };
  }

  factory DiseaseDetails.fromMap(Map<String, dynamic> map) {
    return DiseaseDetails(
      disease: Disease.fromMap(map['disease'] as Map<String, dynamic>),
      suggestedMedicines: List<Medicine>.from(
        (map['suggestedMedicines']).map<Medicine>(
          (x) => Medicine.fromMap(x as Map<String, dynamic>),
        ),
      ),
      externalLinks: List<ExternalLink>.from(
        (map['externalLinks']).map<ExternalLink>(
          (x) => ExternalLink.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DiseaseDetails.fromJson(String source) =>
      DiseaseDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DiseaseDetails(disease: $disease, suggestedMedicines: $suggestedMedicines, externalLinks: $externalLinks)';

  @override
  bool operator ==(covariant DiseaseDetails other) {
    if (identical(this, other)) return true;

    return other.disease == disease &&
        listEquals(other.suggestedMedicines, suggestedMedicines) &&
        listEquals(other.externalLinks, externalLinks);
  }

  @override
  int get hashCode =>
      disease.hashCode ^ suggestedMedicines.hashCode ^ externalLinks.hashCode;
}
