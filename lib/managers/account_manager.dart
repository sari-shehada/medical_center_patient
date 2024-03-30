import 'package:medical_center_patient/core/services/http_service.dart';
import 'package:medical_center_patient/core/services/shared_prefs_service.dart';
import 'package:medical_center_patient/models/patient_info.dart';

class AccountManager {
  AccountManager._({
    this.user,
    required this.isLoggedIn,
  });

  PatientInfo? user;
  bool isLoggedIn;

  static late AccountManager instance;

  static Future<AccountManager> init() async {
    final int? userId = _getUserIdFromLocalStorage();
    if (userId == null) {
      instance = AccountManager._(user: null, isLoggedIn: false);
      return instance;
    }
    final PatientInfo user = await _getPatientInfo(userId);
    instance = AccountManager._(user: user, isLoggedIn: true);
    return instance;
  }

  Future<void> login(PatientInfo userInfo) async {
    await _saveUserIdToLocalStorage(userInfo.id);
    user = userInfo;
    isLoggedIn = true;
  }

  static Future<PatientInfo> _getPatientInfo(int id) async {
    return await HttpService.parsedGet(
      endPoint: 'patients/$id/',
      mapper: PatientInfo.fromJson,
    );
  }

  static int? _getUserIdFromLocalStorage() {
    return SharedPreferencesService.instance.getInt('userId');
  }

  static Future<void> _saveUserIdToLocalStorage(int id) async {
    SharedPreferencesService.instance.setInt(
      key: 'userId',
      value: id,
    );
  }
}