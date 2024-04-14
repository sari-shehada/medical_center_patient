import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_center_patient/core/ui_utils/spacing_utils.dart';
import 'package:medical_center_patient/managers/medical_cases_manager.dart';
import 'package:medical_center_patient/models/medical_case_details.dart';
import 'package:medical_center_patient/pages/medical_cases_page/widgets/empty_medical_case_widget.dart';
import 'package:medical_center_patient/pages/medical_cases_page/widgets/ended_medical_case_card.dart';

class MedicalCaseListViewWidget extends StatelessWidget {
  const MedicalCaseListViewWidget({
    super.key,
    required this.cases,
    required this.widgetToDisplay,
  });

  final List<MedicalCaseDetails> cases;
  final Widget Function(MedicalCaseDetails medicalCase) widgetToDisplay;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => MedicalCasesManager.instance.updateHistory(),
      child: cases.isEmpty
          ? EmptyMedicalCasesWidget(
              isEnded: (widgetToDisplay is EndedMedicalCaseCard Function(
                  MedicalCaseDetails medicalCase)),
            )
          : ListView.separated(
              padding: EdgeInsets.symmetric(
                vertical: 5.h,
                horizontal: 5.w,
              ),
              itemCount: cases.length,
              itemBuilder: (context, index) => widgetToDisplay(
                cases[index],
              ),
              separatorBuilder: (context, index) =>
                  AddVerticalSpacing(value: 10.h),
            ),
    );
  }
}
