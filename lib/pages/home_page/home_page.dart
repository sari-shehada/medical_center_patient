import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_center_patient/config/theme/app_colors.dart';
import 'package:medical_center_patient/core/extensions/date_time_extensions.dart';
import 'package:medical_center_patient/core/services/http_service.dart';
import 'package:medical_center_patient/core/ui_utils/spacing_utils.dart';
import 'package:medical_center_patient/core/widgets/custom_future_builder.dart';
import 'package:medical_center_patient/managers/account_manager.dart';
import 'package:medical_center_patient/pages/diagnosis_details_page/models/medical_diagnosis_details.dart';
import 'package:medical_center_patient/pages/home_page/widgets/home_page_top_header_widget.dart';
import 'package:medical_center_patient/pages/navigation_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<MedicalDiagnosisDetails>> diagnosisHistory;

  @override
  void initState() {
    diagnosisHistory = getDiagnosisHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddVerticalSpacing(
          value: MediaQuery.paddingOf(context).top + 15.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: const HomePageTopHeaderWidget(),
        ),
        AddVerticalSpacing(value: 8.h),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              diagnosisHistory = getDiagnosisHistory();
              setState(() {});
            },
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              children: [
                AddVerticalSpacing(value: 10.h),
                const StartDiagnosisHomePageButton(),
                AddVerticalSpacing(value: 10.h),
                Row(
                  children: [
                    const Icon(Icons.history),
                    AddHorizontalSpacing(value: 5.w),
                    const Text('سجل التشخيصات:'),
                  ],
                ),
                AddVerticalSpacing(value: 10.h),
                CustomFutureBuilder(
                  future: diagnosisHistory,
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

  Future<List<MedicalDiagnosisDetails>> getDiagnosisHistory() async {
    final int userId = AccountManager.instance.user!.id;
    return await HttpService.parsedMultiGet(
      endPoint: 'patients/$userId/diagnosisHistory/',
      mapper: MedicalDiagnosisDetails.fromMap,
    );
  }
}

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
                    color: secondary,
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
                    color: secondary,
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

class StartDiagnosisHomePageButton extends StatelessWidget {
  const StartDiagnosisHomePageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: secondaryContainer,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5.h),
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: -20.w,
            // top: -15.h,
            child: Icon(
              Icons.monitor_heart,
              size: 130.sp,
              color: secondary.withOpacity(0.1),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.white.withOpacity(0.3),
              onTap: () => NavigationController.startNewDiagnosis(),
              borderRadius: BorderRadius.circular(10.r),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'هل من خطب ما؟',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    AddVerticalSpacing(value: 6.h),
                    Text(
                      'قم بإجراء فحص طبي ومن ثم متابعة الحالة مع أحد الأطباء لدينا',
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
