import 'package:flutter/material.dart';
import '../core/services/http_service.dart';
import 'account_manager.dart';
import '../pages/diagnosis_details_page/models/medical_diagnosis_details.dart';

class DiagnosisHistoryManager with ChangeNotifier {
  DiagnosisHistoryManager._() {
    AccountManager.instance.addListener(
      () {
        if (!AccountManager.instance.isLoggedIn) {
          _diagnosisHistory = null;
        }
      },
    );
  }

  static DiagnosisHistoryManager instance = DiagnosisHistoryManager._();

  Future<List<MedicalDiagnosisDetails>> get diagnosisHistory => _getValue();

  Future<List<MedicalDiagnosisDetails>> _getValue() {
    _diagnosisHistory ??= getDiagnosisHistory();
    return _diagnosisHistory!;
  }

  Future<List<MedicalDiagnosisDetails>>? _diagnosisHistory;

  Future<List<MedicalDiagnosisDetails>> getDiagnosisHistory() async {
    final int? userId = AccountManager.instance.user?.id;
    if (userId == null) {
      throw Exception('User id is null');
    }
    List<MedicalDiagnosisDetails> result = await HttpService.parsedMultiGet(
      endPoint: 'patients/$userId/diagnosisHistory/',
      mapper: MedicalDiagnosisDetails.fromMap,
    );
    result.sort((a, b) =>
        b.diagnosis.diagnosisDateTime.compareTo(a.diagnosis.diagnosisDateTime));
    return result;
  }

  void updateHistory() {
    _diagnosisHistory = getDiagnosisHistory();
    notifyListeners();
  }
}
