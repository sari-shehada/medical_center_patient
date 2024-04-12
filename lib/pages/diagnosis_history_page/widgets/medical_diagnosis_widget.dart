import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/theme/app_colors.dart';
import '../../../core/extensions/date_time_extensions.dart';
import '../../diagnosis_details_page/models/medical_diagnosis_details.dart';
import '../../navigation_controller.dart';

class MedicalDiagnosisWidget extends StatelessWidget {
  const MedicalDiagnosisWidget({
    super.key,
    required this.diagnosisDetails,
  });

  final MedicalDiagnosisDetails diagnosisDetails;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => NavigationController.toDiagnosisDetailsPage(
        diagnosisDetails: diagnosisDetails,
      ),
      title: Text(
        diagnosisDetails.diseaseDetails.disease.name,
        style: TextStyle(
          fontSize: 19.sp,
          color: primaryColor,
        ),
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  'تاريخ التشخيص',
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
                const Spacer(),
                Text(
                  diagnosisDetails.diagnosis.diagnosisDateTime.getDateOnly(),
                  style: const TextStyle(
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 10.h,
            width: 1.w,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            color: Colors.grey,
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  'عدد الأعراض المدخلة',
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
                const Spacer(),
                Text(
                  diagnosisDetails.symptoms.length.toString(),
                  style: const TextStyle(
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
