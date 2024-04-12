import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_center_patient/core/services/url_launcher_service.dart';
import 'package:medical_center_patient/core/ui_utils/spacing_utils.dart';
import 'package:medical_center_patient/pages/home_page/models/disease_external_link.dart';

class DiseaseExternalLinkWidget extends StatelessWidget {
  const DiseaseExternalLinkWidget(
      {super.key, required this.diseaseExternalLink});

  final DiseaseExternalLink diseaseExternalLink;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => UrlLauncherService.launchUrl(
        url: diseaseExternalLink.externalLink.link,
      ),
      minLeadingWidth: 60.w,
      title: Text(
        diseaseExternalLink.externalLink.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 15.sp,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            diseaseExternalLink.externalLink.brief,
            maxLines: 2,
            style: TextStyle(
              fontSize: 11.sp,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          AddVerticalSpacing(value: 6.h),
          Text(
            'لمرضى: ${diseaseExternalLink.disease.name}',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.network(
          diseaseExternalLink.externalLink.imageUrl,
          width: 60.w,
        ),
      ),
    );
  }
}
