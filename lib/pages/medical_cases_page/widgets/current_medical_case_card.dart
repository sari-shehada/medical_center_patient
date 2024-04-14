import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medical_center_patient/config/theme/app_colors.dart';
import 'package:medical_center_patient/core/extensions/date_time_extensions.dart';
import 'package:medical_center_patient/core/ui_utils/buttons/custom_icon_button.dart';
import 'package:medical_center_patient/models/medical_case_details.dart';

import '../../medical_case_messages_page/medical_case_messages_page.dart';

class CurrentMedicalCaseCard extends StatelessWidget {
  const CurrentMedicalCaseCard({
    super.key,
    required this.medicalCaseDetails,
  });

  final MedicalCaseDetails medicalCaseDetails;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      title: Row(
        children: [
          Text(
            medicalCaseDetails.disease.name,
            style: TextStyle(
              fontSize: 24.sp,
              color: primaryColor,
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: Colors.grey.shade400,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 6.w,
              vertical: 1.h,
            ),
            child: Text(
              medicalCaseDetails.patientDiagnosis.diagnosisDateTime
                  .getDateOnly(),
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Roboto',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            medicalCaseDetails.medicalCase.status == 'pending'
                ? 'الحالة لا تزال بانتظار التعيين من قبل أحد الأطباء'
                : 'تم أخذ الحالة من قبل أحد الأطباء',
            style: TextStyle(
              fontSize: 14.sp,
              color: secondaryColor,
            ),
          ),
          if (medicalCaseDetails.medicalCase.takenBy != null)
            Row(
              children: [
                Text(
                  'الطبيب المختص',
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
                const Spacer(),
                Text(
                  medicalCaseDetails.assignedDoctor!.fullName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
        ],
      ),
      trailing: medicalCaseDetails.medicalCase.takenBy != null
          ? CustomIconButton(
              iconData: Icons.chat,
              onTap: () => Get.to(
                () => MedicalCaseChatPage(
                  medicalCaseDetails: medicalCaseDetails,
                ),
              ),
            )
          : null,
    );
  }
}
