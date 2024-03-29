import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:medical_center_patient/config/theme/app_theme.dart';

import 'config/constants/string_constants.dart';
import 'core/services/shared_prefs_service.dart';
import 'pages/loader_page/loader_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();
  await ScreenUtil.ensureScreenSize();

  runApp(
    const Application(),
  );
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: false,
      useInheritedMediaQuery: true,
      designSize: const Size(390, 844),
      builder: (context, child) {
        return GetMaterialApp(
          title: StringConstants.appName,
          theme: lightTheme,
          locale: const Locale('ar'),
          home: const LoaderPage(),
        );
      },
    );
  }
}
