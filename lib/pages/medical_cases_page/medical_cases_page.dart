import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/ui_utils/spacing_utils.dart';
import '../../core/widgets/custom_future_builder.dart';
import '../../managers/medical_cases_manager.dart';
import 'widgets/current_medical_case_card.dart';
import 'widgets/ended_medical_case_card.dart';
import 'widgets/medical_case_list_widget_widget.dart';

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
                Icons.chat,
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
                          widgetToDisplay: (medicalCase) =>
                              CurrentMedicalCaseCard(
                            medicalCaseDetails: medicalCase,
                          ),
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
