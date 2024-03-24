import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/constants/string_constants.dart';
import '../../core/services/shared_prefs_service.dart';
import '../../ui_utils/app_logo_widget.dart';
import '../../ui_utils/loaders/linear_loading_indicator_widget.dart';
import '../../ui_utils/spacing_utils.dart';
import '../navigation_controller.dart';

class LoaderPage extends StatelessWidget {
  const LoaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _performInitialLoading();
      },
    );
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLogoWidget(),
            AddVerticalSpacing(value: 130.h),
            Text(
              StringConstants.appNameAr,
              style: TextStyle(
                fontSize: 22.sp,
              ),
            ),
            AddVerticalSpacing(value: 10.h),
            const LinearLoadingIndicatorWidget(),
          ],
        ),
      ),
    );
  }

  Future<void> _performInitialLoading() async {
    int? userId = SharedPreferencesService.instance.getInt('userId');
    if (userId == null) {
      NavigationController.toLoginPage();
      return;
    }
  }
}
