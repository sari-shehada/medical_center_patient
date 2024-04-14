import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/services/url_launcher_service.dart';
import '../../../models/external_link.dart';

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
            minLeadingWidth: 50.w,
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
                width: 50.w,
              ),
            ),
          );
        },
      ),
    );
  }
}
