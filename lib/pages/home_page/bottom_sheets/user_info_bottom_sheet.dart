import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/theme/app_colors.dart';
import '../../../core/ui_utils/buttons/custom_filled_button.dart';
import '../../../core/ui_utils/spacing_utils.dart';
import '../../../managers/account_manager.dart';
import '../../../models/patient_info.dart';

class UserInfoBottomSheet extends StatelessWidget {
  const UserInfoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final PatientInfo user = AccountManager.instance.user!;
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.r),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4.h,
            width: MediaQuery.sizeOf(context).width * .25,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
          AddVerticalSpacing(value: 25.h),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: CircleAvatar(
              radius: 35.sp,
              backgroundColor: user.isMale ? primaryColor : Colors.pink,
              child: Icon(
                user.isMale ? Icons.male : Icons.female,
                size: 30.sp,
              ),
            ),
          ),
          AddVerticalSpacing(value: 12.h),
          Text(
            '${user.firstName} ${user.lastName}',
            style: TextStyle(
              fontSize: 17.sp,
            ),
          ),
          AddVerticalSpacing(value: 25.h),
          CustomFilledButton(
            width: MediaQuery.sizeOf(context).width * .45,
            height: 40.h,
            borderRadiusValue: 10.r,
            backgroundColor: Colors.red.shade100,
            labelColor: Colors.red.shade800,
            onTap: () => AccountManager.instance.logout(),
            child: 'تسجيل الخروج',
          ),
          AddVerticalSpacing(value: 20.h),
        ],
      ),
    );
  }
}
