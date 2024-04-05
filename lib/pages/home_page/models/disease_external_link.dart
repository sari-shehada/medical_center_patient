// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:medical_center_patient/models/disease.dart';
import 'package:medical_center_patient/models/external_link.dart';

class DiseaseExternalLink {
  final ExternalLink externalLink;
  final Disease disease;
  DiseaseExternalLink({
    required this.externalLink,
    required this.disease,
  });

  DiseaseExternalLink copyWith({
    ExternalLink? externalLink,
    Disease? disease,
  }) {
    return DiseaseExternalLink(
      externalLink: externalLink ?? this.externalLink,
      disease: disease ?? this.disease,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'externalLink': externalLink.toMap(),
      'disease': disease.toMap(),
    };
  }

  factory DiseaseExternalLink.fromMap(Map<String, dynamic> map) {
    return DiseaseExternalLink(
      externalLink:
          ExternalLink.fromMap(map['externalLink'] as Map<String, dynamic>),
      disease: Disease.fromMap(map['disease'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory DiseaseExternalLink.fromJson(String source) =>
      DiseaseExternalLink.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DiseaseExternalLink(externalLink: $externalLink, disease: $disease)';

  @override
  bool operator ==(covariant DiseaseExternalLink other) {
    if (identical(this, other)) return true;

    return other.externalLink == externalLink && other.disease == disease;
  }

  @override
  int get hashCode => externalLink.hashCode ^ disease.hashCode;
}
