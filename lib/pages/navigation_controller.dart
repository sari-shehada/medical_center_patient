import 'package:get/get.dart';
import 'dashboard/dashboard.dart';
import 'diagnosis_details_page/diagnosis_details_page.dart';
import 'diagnosis_details_page/models/medical_diagnosis_details.dart';
import 'loader_page/loader_page.dart';
import 'login_page/login_page.dart';
import 'new_diagnosis/symptoms_selection_page.dart';
import 'sign_up_page/sign_up_page.dart';

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
