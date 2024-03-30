import 'package:get/get.dart';
import 'package:medical_center_patient/pages/home_page/home_page.dart';
import 'package:medical_center_patient/pages/loader_page/loader_page.dart';
import 'package:medical_center_patient/pages/login_page/login_page.dart';
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

  static Future<void> toHomePage() async {
    Get.offAll(
      () => const HomePage(),
    );
  }
}
