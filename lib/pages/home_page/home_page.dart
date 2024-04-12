import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_center_patient/config/theme/app_colors.dart';
import 'package:medical_center_patient/core/services/http_service.dart';
import 'package:medical_center_patient/core/ui_utils/loaders/linear_loading_indicator_widget.dart';
import 'package:medical_center_patient/core/widgets/custom_divider.dart';
import 'package:medical_center_patient/core/widgets/custom_future_builder.dart';
import 'package:medical_center_patient/pages/home_page/models/disease_external_link.dart';
import 'package:medical_center_patient/pages/home_page/widgets/disease_external_link_widget.dart';
import 'package:medical_center_patient/pages/home_page/widgets/start_diagnosis_home_page_button.dart';
import '../../core/ui_utils/spacing_utils.dart';
import 'widgets/home_page_top_header_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<DiseaseExternalLink>> homeFeedFuture;

  @override
  void initState() {
    homeFeedFuture = getHomeFeed();
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
              setState(() {
                homeFeedFuture = getHomeFeed();
              });
            },
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              children: [
                AddVerticalSpacing(value: 10.h),
                const StartDiagnosisHomePageButton(),
                AddVerticalSpacing(value: 15.h),
                Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: Text(
                    'بعض المقالات التي اخترناها لك',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: primaryColor,
                    ),
                  ),
                ),
                CustomFutureBuilder(
                  future: homeFeedFuture,
                  widgetToDisplayWhileLoading: SizedBox(
                    height: 250.h,
                    child: const Center(
                      child: LinearLoadingIndicatorWidget(),
                    ),
                  ),
                  builder: (context, links) => ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    shrinkWrap: true,
                    itemCount: links.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => DiseaseExternalLinkWidget(
                      diseaseExternalLink: links[index],
                    ),
                    separatorBuilder: (BuildContext context, int index) {
                      return const CustomDivider();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<List<DiseaseExternalLink>> getHomeFeed() async {
    return await HttpService.parsedMultiGet(
      endPoint: 'feed/',
      mapper: DiseaseExternalLink.fromMap,
    );
  }
}
