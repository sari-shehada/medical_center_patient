import 'package:get/get.dart';
import 'package:medical_center_patient/pages/dashboard/dashboard.dart';
import 'package:medical_center_patient/pages/diagnosis_details_page/diagnosis_details_page.dart';
import 'package:medical_center_patient/pages/diagnosis_details_page/models/medical_diagnosis_details.dart';
import 'package:medical_center_patient/pages/loader_page/loader_page.dart';
import 'package:medical_center_patient/pages/login_page/login_page.dart';
import 'package:medical_center_patient/pages/new_diagnosis/symptoms_selection_page.dart';
import 'package:medical_center_patient/pages/sign_up_page/sign_up_page.dart';

abstract class NavigationController {
  static Future<void> toLoginPage({
    bool offAll = true,
  }) async {
    if (offAll) {
      Get.offAll(() => const LoginPage());
      return;
    }
    Get.to(() => const LoginPage());
  }

  static Future<void> toSignUpPage() async {
    Get.offAll(() => const SignUpPage());
  }

  static Future<void> toLoaderPage() async {
    Get.offAll(
      () => const LoaderPage(),
    );
  }

  static Future<void> toDashboard() async {
    Get.offAll(
      () => const Dashboard(),
    );
  }

  static Future<void> startNewDiagnosis() async {
    Get.to(
      () => const SymptomsSelectionPage(),
    );
  }

  static Future<void> toDiagnosisDetailsPage({
    required MedicalDiagnosisDetails diagnosisDetails,
  }) async {
    Get.to(
      () => MedicalDiagnosisDetailsPage(
        diagnosisDetails: diagnosisDetails,
      ),
    );
  }
}
