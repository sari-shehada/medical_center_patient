import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/services/http_service.dart';
import '../../core/services/snackbar_service.dart';
import '../../core/ui_utils/buttons/custom_filled_button.dart';
import '../../core/widgets/custom_divider.dart';
import '../../core/widgets/title_details_spaced_widget.dart';
import '../../managers/account_manager.dart';
import '../../managers/diagnosis_history_manager.dart';
import '../../managers/medical_cases_manager.dart';
import 'widgets/external_links_list_widget.dart';
import 'widgets/recommended_medicines_list_widget.dart';
import '../../config/theme/app_colors.dart';
import '../../core/extensions/date_time_extensions.dart';
import '../../core/ui_utils/spacing_utils.dart';
import 'models/medical_diagnosis_details.dart';

class MedicalDiagnosisDetailsPage extends StatefulWidget {
  const MedicalDiagnosisDetailsPage({
    super.key,
    required this.diagnosisDetails,
  });

  final MedicalDiagnosisDetails diagnosisDetails;

  @override
  State<MedicalDiagnosisDetailsPage> createState() =>
      _MedicalDiagnosisDetailsPageState();
}

class _MedicalDiagnosisDetailsPageState
    extends State<MedicalDiagnosisDetailsPage> with TickerProviderStateMixin {
  late TabController tabController;

  late MedicalDiagnosisDetails diagnosisDetails;
  @override
  void initState() {
    tabController = TabController(vsync: this, length: 2);
    diagnosisDetails = widget.diagnosisDetails;
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
                details:
                    diagnosisDetails.diagnosis.isSubmittedForFurtherFollowup
                        ? 'نعم'
                        : 'لا',
              ),
              AnimatedSize(
                duration: 400.milliseconds,
                curve: Curves.fastLinearToSlowEaseIn,
                child: diagnosisDetails.diagnosis.isSubmittedForFurtherFollowup
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Align(
                          child: CustomFilledButton(
                            height: 40.h,
                            width: MediaQuery.sizeOf(context).width * .85,
                            borderRadiusValue: 10.r,
                            onTap: submitMedicalCase,
                            buttonStatus: submitMedicalCaseButtonStatus,
                            child: 'طلب معاينة الحالة',
                          ),
                        ),
                      ),
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

  Rx<CustomButtonStatus> submitMedicalCaseButtonStatus =
      CustomButtonStatus.enabled.obs;
  Future<void> submitMedicalCase() async {
    try {
      int userId = AccountManager.instance.user!.id;
      submitMedicalCaseButtonStatus.value = CustomButtonStatus.processing;
      var result = await HttpService.rawFullResponsePost(
        endPoint:
            'patients/$userId/diagnostics/${widget.diagnosisDetails.diagnosis.id}/submitMedicalCase/',
      );
      if (result.statusCode == 404) {
        Get.back();
        SnackBarService.showErrorSnackbar(
          'لم يتم العثور على هذا التشخيص, ربما تم حذفه من قبلك',
        );
        return;
      }
      if (result.statusCode == 400) {
        SnackBarService.showNeutralSnackbar(
          'لقد قمت مسبقاً بتقديم طلب المتابعة',
        );
      }
      if (result.statusCode == 200) {
        SnackBarService.showSuccessSnackbar(
          'لقد تم تقديم الطلب بنجاح',
        );
      }
      markCaseAsSubmitted();
    } finally {
      submitMedicalCaseButtonStatus.value = CustomButtonStatus.enabled;
    }
  }

  void markCaseAsSubmitted() {
    diagnosisDetails = diagnosisDetails.copyWith(
      diagnosis: diagnosisDetails.diagnosis.copyWith(
        isSubmittedForFurtherFollowup: true,
      ),
    );
    DiagnosisHistoryManager.instance.updateHistory();
    MedicalCasesManager.instance.updateHistory();
    setState(() {});
  }
}
