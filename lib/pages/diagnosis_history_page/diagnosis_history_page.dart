import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_center_patient/core/ui_utils/spacing_utils.dart';
import 'package:medical_center_patient/core/widgets/custom_future_builder.dart';
import 'package:medical_center_patient/managers/diagnosis_history_manager.dart';
import 'package:medical_center_patient/pages/diagnosis_history_page/widgets/medical_diagnosis_widget.dart';

class DiagnosisHistoryPage extends StatefulWidget {
  const DiagnosisHistoryPage({super.key});

  @override
  State<DiagnosisHistoryPage> createState() => _DiagnosisHistoryPageState();
}

class _DiagnosisHistoryPageState extends State<DiagnosisHistoryPage> {
  @override
  void initState() {
    DiagnosisHistoryManager.instance.addListener(() {
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
                'سجل التشخيصات',
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
            onRefresh: () async =>
                DiagnosisHistoryManager.instance.updateHistory(),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              children: [
                AddVerticalSpacing(value: 10.h),
                CustomFutureBuilder(
                  future: DiagnosisHistoryManager.instance.diagnosisHistory,
                  builder: (context, snapshot) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      snapshot.length,
                      (index) => MedicalDiagnosisWidget(
                        diagnosisDetails: snapshot[index],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
