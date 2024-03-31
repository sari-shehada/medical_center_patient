import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_center_patient/core/extensions/date_time_extensions.dart';
import 'package:medical_center_patient/core/services/http_service.dart';
import 'package:medical_center_patient/core/ui_utils/buttons/custom_filled_button.dart';
import 'package:medical_center_patient/core/ui_utils/spacing_utils.dart';
import 'package:medical_center_patient/core/widgets/custom_future_builder.dart';
import 'package:medical_center_patient/managers/account_manager.dart';
import 'package:medical_center_patient/pages/diagnosis_details_page/diagnosis_details_page.dart';
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
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
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
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                children: [
                  const UserInfoWidget(),
                  AddVerticalSpacing(value: 10.h),
                  CustomFilledButton(
                    onTap: () => NavigationController.startNewDiagnosis(),
                    child: 'القيام بفحص جديد',
                  ),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
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
      title: Text(diagnosisDetails.diseaseDetails.disease.name),
      subtitle: Row(
        children: [
          const Text(
            'تاريخ التشخيص',
          ),
          const Spacer(),
          Text(
            diagnosisDetails.diagnosis.diagnosisDateTime.getDateOnly(),
          ),
        ],
      ),
    );
  }
}

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مرحباً ${AccountManager.instance.user!.firstName}',
          style: TextStyle(
            fontSize: 24.sp,
          ),
        ),
        TitleDetailsSpacedWidget(
          title: 'تاريخ الميلاد',
          details: AccountManager.instance.user!.dateOfBirth.getDateOnly(),
        ),
        TitleDetailsSpacedWidget(
          title: 'الجنس',
          details: AccountManager.instance.user!.isMale ? 'ذكر' : 'انثى',
        ),
      ],
    );
  }
}
