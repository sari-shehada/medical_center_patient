import 'package:flutter/material.dart';
import 'package:medical_center_patient/models/medical_case_details.dart';
import 'package:medical_center_patient/models/separated_medical_cases.dart';
import '../core/services/http_service.dart';
import 'account_manager.dart';

class MedicalCasesManager with ChangeNotifier {
  MedicalCasesManager._() {
    AccountManager.instance.addListener(
      () {
        if (!AccountManager.instance.isLoggedIn) {
          _medicalCases = null;
        }
      },
    );
  }

  static MedicalCasesManager instance = MedicalCasesManager._();

  Future<SeparatedMedicalCases> get medicalCases => _getValue();

  Future<SeparatedMedicalCases> _getValue() {
    _medicalCases ??= getMedicalCases();
    return _medicalCases!;
  }

  Future<SeparatedMedicalCases>? _medicalCases;

  Future<SeparatedMedicalCases> getMedicalCases() async {
    final int? userId = AccountManager.instance.user?.id;
    if (userId == null) {
      throw Exception('User id is null');
    }
    List<MedicalCaseDetails> result = await HttpService.parsedMultiGet(
      endPoint: 'patients/$userId/medicalCases/',
      mapper: MedicalCaseDetails.fromMap,
    );
    result.sort(
      (a, b) => b.patientDiagnosis.diagnosisDateTime.compareTo(
        a.patientDiagnosis.diagnosisDateTime,
      ),
    );

    return SeparatedMedicalCases(
      currentCases: result
          .where((element) => element.medicalCase.status != 'ended')
          .toList(),
      endedCases: result
          .where((element) => element.medicalCase.status == 'ended')
          .toList(),
    );
  }

  void updateHistory() {
    _medicalCases = getMedicalCases();
    notifyListeners();
  }
}
