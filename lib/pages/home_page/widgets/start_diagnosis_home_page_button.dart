import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_center_patient/config/theme/app_colors.dart';
import 'package:medical_center_patient/core/ui_utils/spacing_utils.dart';
import 'package:medical_center_patient/pages/navigation_controller.dart';

class StartDiagnosisHomePageButton extends StatelessWidget {
  const StartDiagnosisHomePageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: secondaryContainer,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5.h),
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: -20.w,
            child: Icon(
              Icons.monitor_heart,
              size: 130.sp,
              color: secondary.withOpacity(0.1),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.white.withOpacity(0.3),
              onTap: () => NavigationController.startNewDiagnosis(),
              borderRadius: BorderRadius.circular(10.r),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'هل من خطب ما؟',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    AddVerticalSpacing(value: 6.h),
                    Text(
                      'قم بإجراء فحص طبي ومن ثم متابعة الحالة مع أحد الأطباء لدينا',
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
