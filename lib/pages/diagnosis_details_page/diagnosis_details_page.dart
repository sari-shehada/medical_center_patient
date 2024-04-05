import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_center_patient/core/services/url_launcher_service.dart';
import 'package:medical_center_patient/models/external_link.dart';
import 'package:medical_center_patient/models/medicine.dart';
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
    required this.icon,
    required this.title,
    required this.details,
  });

  final IconData icon;
  final String title;
  final String details;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
      child: Row(
        children: [
          Icon(
            icon,
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

class ExternalLinksListWidget extends StatelessWidget {
  const ExternalLinksListWidget({
    super.key,
    required this.externalLinks,
  });
  final List<ExternalLink> externalLinks;
  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        externalLinks.length,
        (index) {
          ExternalLink link = externalLinks[index];
          return ListTile(
            onTap: () => UrlLauncherService.launchUrl(
              url: link.link,
            ),
            minLeadingWidth: 25.w,
            title: Text(
              link.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
            subtitle: Text(
              link.brief,
              maxLines: 2,
              style: TextStyle(
                fontSize: 11.sp,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                link.imageUrl,
              ),
            ),
          );
        },
      ),
    );
  }
}

class RecommendedMedicinesListWidget extends StatelessWidget {
  const RecommendedMedicinesListWidget({
    super.key,
    required this.medicines,
  });
  final List<Medicine> medicines;
  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        medicines.length,
        (index) {
          Medicine medicine = medicines[index];
          return ListTile(
            minLeadingWidth: 25.w,
            title: Text(
              medicine.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
            // subtitle: Text(
            //   medicine.brief,
            //   maxLines: 2,
            //   style: TextStyle(
            //     fontSize: 11.sp,
            //   ),
            //   overflow: TextOverflow.ellipsis,
            // ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                medicine.imageUrl,
              ),
            ),
          );
        },
      ),
    );
  }
}
