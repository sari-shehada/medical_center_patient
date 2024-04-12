import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_center_patient/config/theme/app_colors.dart';
import 'package:medical_center_patient/core/extensions/date_time_extensions.dart';
import 'package:medical_center_patient/core/ui_utils/buttons/custom_icon_button.dart';
import 'package:medical_center_patient/core/ui_utils/spacing_utils.dart';
import 'package:medical_center_patient/core/widgets/custom_future_builder.dart';
import 'package:medical_center_patient/managers/medical_cases_manager.dart';
import 'package:medical_center_patient/models/medical_case_details.dart';

class MedicalCasesPage extends StatefulWidget {
  const MedicalCasesPage({super.key});

  @override
  State<MedicalCasesPage> createState() => _MedicalCasesPageState();
}

class _MedicalCasesPageState extends State<MedicalCasesPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    MedicalCasesManager.instance.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddVerticalSpacing(
          value: MediaQuery.paddingOf(context).top + 15.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.history,
                size: 38.sp,
              ),
              AddVerticalSpacing(value: 5.h),
              Text(
                'حالاتي الطبية',
                style: TextStyle(
                  fontSize: 22.sp,
                ),
              ),
            ],
          ),
        ),
        AddVerticalSpacing(value: 8.h),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => MedicalCasesManager.instance.updateHistory(),
            child: CustomFutureBuilder(
              future: MedicalCasesManager.instance.medicalCases,
              builder: (context, snapshot) => Column(
                children: [
                  TabBar(
                    controller: tabController,
                    indicatorWeight: .5.h,
                    tabs: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Text(
                          'الحالات الحالية',
                          style: TextStyle(
                            fontSize: 16.h,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Text(
                          'الحالات المنتهية',
                          style: TextStyle(
                            fontSize: 16.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        MedicalCaseListViewWidget(
                          cases: snapshot.currentCases,
                          widgetToDisplay: (medicalCase) => const Placeholder(),
                        ),
                        MedicalCaseListViewWidget(
                          cases: snapshot.endedCases,
                          widgetToDisplay: (medicalCase) =>
                              EndedMedicalCaseCard(
                            medicalCaseDetails: medicalCase,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          vertical: 5.h,
          horizontal: 5.w,
        ),
        itemCount: cases.length,
        itemBuilder: (context, index) => widgetToDisplay(
          cases[index],
        ),
        separatorBuilder: (context, index) => AddVerticalSpacing(value: 10.h),
      ),
    );
  }
}

class EndedMedicalCaseCard extends StatelessWidget {
  const EndedMedicalCaseCard({
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
      subtitle: Row(
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
      trailing: CustomIconButton(
        iconData: Icons.chat,
        onTap: () {},
      ),
    );
  }
}
