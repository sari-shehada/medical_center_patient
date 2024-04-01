import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_center_patient/config/theme/app_colors.dart';
import 'package:medical_center_patient/core/extensions/date_time_extensions.dart';
import 'package:medical_center_patient/core/ui_utils/spacing_utils.dart';
import 'package:medical_center_patient/pages/diagnosis_details_page/models/medical_diagnosis_details.dart';

class MedicalDiagnosisDetailsPage extends StatefulWidget {
  const MedicalDiagnosisDetailsPage(
      {super.key, required this.diagnosisDetails});

  final MedicalDiagnosisDetails diagnosisDetails;

  @override
  State<MedicalDiagnosisDetailsPage> createState() =>
      _MedicalDiagnosisDetailsPageState();
}

class _MedicalDiagnosisDetailsPageState
    extends State<MedicalDiagnosisDetailsPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

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
          padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 10.h),
          children: [
            Align(
              child: Text(
                widget.diagnosisDetails.diseaseDetails.disease.name,
                style: TextStyle(
                  fontSize: 30.sp,
                  color: primaryColor,
                ),
              ),
            ),
            AddVerticalSpacing(value: 5.h),
            Align(
              child: Text(
                'المرض المتنبأ به',
                style: TextStyle(
                  fontSize: 13.sp,
                ),
              ),
            ),
            TitleDetailsSpacedWidget(
              title: 'تاريخ التشخيص',
              details: widget.diagnosisDetails.diagnosis.diagnosisDateTime
                  .getDateOnly(),
            ),
            TitleDetailsSpacedWidget(
              title: 'تم طلب معاينة من قبل احد الأطباء؟',
              details: widget
                      .diagnosisDetails.diagnosis.isSubmittedForFurtherFollowup
                  ? 'نعم'
                  : 'لا',
            ),
            const CustomDivider(),
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
                mainAxisSpacing: 5.h,
                mainAxisExtent: 36.h,
                crossAxisSpacing: 6.w,
              ),
              shrinkWrap: true,
              itemCount: widget.diagnosisDetails.symptoms.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: primaryContainer,
                  ),
                  alignment: Alignment.center,
                  child: Text(widget.diagnosisDetails.symptoms[index].name),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey.withOpacity(0.5),
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
          Icon(
            Icons.history,
            color: Colors.grey.shade700,
          ),
          AddHorizontalSpacing(value: 6.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.grey.shade700,
            ),
          ),
          const Spacer(),
          Text(
            details,
            style: TextStyle(
              fontSize: 15.sp,
              color: secondary,
            ),
          ),
        ],
      ),
    );
  }
}
