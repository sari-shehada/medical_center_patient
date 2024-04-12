import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_center_patient/core/widgets/custom_divider.dart';
import 'package:medical_center_patient/core/widgets/title_details_spaced_widget.dart';
import 'package:medical_center_patient/pages/diagnosis_details_page/widgets/external_links_list_widget.dart';
import 'package:medical_center_patient/pages/diagnosis_details_page/widgets/recommended_medicines_list_widget.dart';
import '../../config/theme/app_colors.dart';
import '../../core/extensions/date_time_extensions.dart';
import '../../core/ui_utils/spacing_utils.dart';
import 'models/medical_diagnosis_details.dart';

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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                icon: Icons.history,
                title: 'تاريخ التشخيص',
                details: widget.diagnosisDetails.diagnosis.diagnosisDateTime
                    .getDateOnly(),
              ),
              TitleDetailsSpacedWidget(
                icon: Icons.monitor_heart_outlined,
                title: 'تم طلب معاينة من قبل احد الأطباء؟',
                details: widget.diagnosisDetails.diagnosis
                        .isSubmittedForFurtherFollowup
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
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.h,
                  mainAxisExtent: 36.h,
                  crossAxisSpacing: 6.w,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                  vertical: 10.h,
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
              const CustomDivider(),
              TabBar(
                controller: tabController,
                tabs: [
                  SizedBox(
                    height: 30.h,
                    child: const Text('أدوية مقترحة'),
                  ),
                  SizedBox(
                    height: 30.h,
                    child: const Text('بعض المقالات المفيدة'),
                  ),
                ],
              ),
              AddVerticalSpacing(value: 10.h),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    RecommendedMedicinesListWidget(
                      medicines: widget
                          .diagnosisDetails.diseaseDetails.suggestedMedicines,
                    ),
                    ExternalLinksListWidget(
                      externalLinks:
                          widget.diagnosisDetails.diseaseDetails.externalLinks,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
