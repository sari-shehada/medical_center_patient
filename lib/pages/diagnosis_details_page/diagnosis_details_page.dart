import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_center_patient/config/theme/app_colors.dart';
import 'package:medical_center_patient/core/extensions/date_time_extensions.dart';
import 'package:medical_center_patient/core/ui_utils/spacing_utils.dart';
import 'package:medical_center_patient/pages/diagnosis_details_page/models/medical_diagnosis_details.dart';

class MedicalDiagnosisDetailsPage extends StatelessWidget {
  const MedicalDiagnosisDetailsPage(
      {super.key, required this.diagnosisDetails});

  final MedicalDiagnosisDetails diagnosisDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفاصيل التشخيص المرضي',
          style: TextStyle(fontSize: 17.sp),
        ),
        titleSpacing: 0,
      ),
      body: SizedBox.expand(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 9.w),
          children: [
            Text(
              'المرض المتنبأ به',
              style: TextStyle(
                fontSize: 13.sp,
              ),
            ),
            AddVerticalSpacing(value: 10.h),
            Text(
              diagnosisDetails.diseaseDetails.disease.name,
              style: TextStyle(
                fontSize: 27.sp,
                color: primaryColor,
              ),
            ),
            const Divider(),
            TitleDetailsSpacedWidget(
              title: 'تاريخ التشخيص',
              details:
                  diagnosisDetails.diagnosis.diagnosisDateTime.getDateOnly(),
            ),
            TitleDetailsSpacedWidget(
              title: 'تم طلب معاينة من قبل احد الأطباء؟',
              details: diagnosisDetails.diagnosis.isSubmittedForFurtherFollowup
                  ? 'نعم'
                  : 'لا',
            ),
            const Divider(),
            Text(
              'الأعراض المدخلة:',
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
            AddVerticalSpacing(value: 10.h),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 40.h,
                crossAxisSpacing: 6.w,
              ),
              shrinkWrap: true,
              itemCount: diagnosisDetails.symptoms.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: primaryContainer,
                  ),
                  alignment: Alignment.center,
                  child: Text(diagnosisDetails.symptoms[index].name),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class TitleDetailsSpacedWidget extends StatelessWidget {
  const TitleDetailsSpacedWidget({
    super.key,
    required this.title,
    required this.details,
  });

  final String title;
  final String details;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
      child: Row(
        children: [
          Text(title),
          const Spacer(),
          Text(details),
        ],
      ),
    );
  }
}
