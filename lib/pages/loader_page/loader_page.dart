import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../managers/account_manager.dart';

import '../../config/constants/string_constants.dart';
import '../../core/ui_utils/app_logo_widget.dart';
import '../../core/ui_utils/loaders/linear_loading_indicator_widget.dart';
import '../../core/ui_utils/spacing_utils.dart';
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
            AddVerticalSpacing(value: 130.h),
            AppLogoWidget(
              size: 200.sp,
            ),
            AddVerticalSpacing(value: 100.h),
            const LinearLoadingIndicatorWidget(),
            AddVerticalSpacing(value: 10.h),
            Text(
              StringConstants.appNameAr,
              style: TextStyle(
                fontSize: 25.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performInitialLoading() async {
    await AccountManager.init();
    if (!AccountManager.instance.isLoggedIn) {
      NavigationController.toLoginPage();
      return;
    }
    NavigationController.toDashboard();
  }
}
