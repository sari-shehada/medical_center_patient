import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/theme/app_colors.dart';
import '../../core/ui_utils/spacing_utils.dart';
import 'widgets/home_page_top_header_widget.dart';
import '../navigation_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddVerticalSpacing(
          value: MediaQuery.paddingOf(context).top + 15.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: const HomePageTopHeaderWidget(),
        ),
        AddVerticalSpacing(value: 8.h),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            children: [
              AddVerticalSpacing(value: 10.h),
              const StartDiagnosisHomePageButton(),
            ],
          ),
        ),
      ],
    );
  }
}

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
