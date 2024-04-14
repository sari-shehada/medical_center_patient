import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_center_patient/core/ui_utils/spacing_utils.dart';

class EmptyDiagnosisHistoryWidget extends StatelessWidget {
  const EmptyDiagnosisHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 75.sp,
            color: Colors.grey.shade700,
          ),
          AddVerticalSpacing(value: 25.h),
          Text(
            'لم يتم العثور على تشخيصات سابقة',
            style: TextStyle(
              fontSize: 17.sp,
              color: Colors.grey.shade700,
            ),
          ),
          AddVerticalSpacing(value: 170.h),
        ],
      ),
    );
  }
}
