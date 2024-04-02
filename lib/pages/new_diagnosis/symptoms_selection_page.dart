import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medical_center_patient/config/theme/app_colors.dart';
import 'package:medical_center_patient/core/services/http_service.dart';
import 'package:medical_center_patient/core/ui_utils/spacing_utils.dart';
import 'package:medical_center_patient/core/ui_utils/text_fields/custom_text_field.dart';
import 'package:medical_center_patient/core/widgets/custom_future_builder.dart';
import 'package:medical_center_patient/managers/account_manager.dart';
import 'package:medical_center_patient/managers/diagnosis_history_manager.dart';
import 'package:medical_center_patient/models/symptom.dart';
import 'package:medical_center_patient/pages/diagnosis_details_page/diagnosis_details_page.dart';
import 'package:medical_center_patient/pages/diagnosis_details_page/models/medical_diagnosis_details.dart';
import 'package:medical_center_patient/pages/navigation_controller.dart';

class SymptomsSelectionPage extends StatefulWidget {
  const SymptomsSelectionPage({super.key});

  @override
  State<SymptomsSelectionPage> createState() => _SymptomsSelectionPageState();
}

class _SymptomsSelectionPageState extends State<SymptomsSelectionPage> {
  late Future<List<Symptom>> symptomsListFuture;

  Future<List<Symptom>> _getSymptoms() async {
    return await HttpService.parsedMultiGet(
        endPoint: 'symptoms/', mapper: Symptom.fromMap);
  }

  @override
  void initState() {
    symptomsListFuture = _getSymptoms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: CustomFutureBuilder(
          future: symptomsListFuture,
          widgetToDisplayWhileLoading: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.monitor_heart_rounded,
                  size: 130.sp,
                  color: primaryColor,
                ),
                AddVerticalSpacing(value: 10.h),
                Text(
                  'يتم الآن التحضير لعملية التشخيص...',
                  style: TextStyle(
                    fontSize: 17.sp,
                  ),
                ),
                AddVerticalSpacing(value: 13.h),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * .7,
                  child: const LinearProgressIndicator(),
                ),
              ],
            ),
          ),
          builder: (BuildContext context, List<Symptom> snapshot) =>
              _SymptomsSelectionPageBody(
            symptoms: snapshot,
          ),
        ),
      ),
    );
  }
}

class _SymptomsSelectionPageBody extends StatefulWidget {
  const _SymptomsSelectionPageBody({
    required this.symptoms,
  });

  final List<Symptom> symptoms;

  @override
  State<_SymptomsSelectionPageBody> createState() =>
      _SymptomsSelectionPageBodyState();
}

class _SymptomsSelectionPageBodyState
    extends State<_SymptomsSelectionPageBody> {
  List<Symptom> selectedSymptoms = [];

  String searchText = '';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchController.addListener(() {
      searchText = searchController.text;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final displayList = searchText.isEmpty
        ? widget.symptoms
        : widget.symptoms.where((e) => e.name.contains(searchText)).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddVerticalSpacing(
          value: MediaQuery.paddingOf(context).top,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4.h),
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: kToolbarHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    Icon(
                      Icons.medical_information,
                      size: 38.sp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    AddHorizontalSpacing(value: 8.w),
                    Padding(
                      padding: EdgeInsets.only(top: 9.h),
                      child: Text(
                        'ما الذي تشعر به؟',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'قم باختيار الأعراض التي تعاني منها من القائمة ادناه',
              ),
              AddVerticalSpacing(value: 6.h),
              Text(
                'لقد قمت باختيار ${selectedSymptoms.length} من اصل ${widget.symptoms.length} عرض',
              ),
              AddVerticalSpacing(value: 10.h),
              CustomTextField(
                controller: searchController,
                hintText: 'ابحث عن عرض',
                isDense: true,
              ),
              AddVerticalSpacing(value: 10.h),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            itemCount: displayList.length,
            itemBuilder: (context, index) => SelectableSymptomWidget(
              symptom: displayList[index],
              isSelected: selectedSymptoms.contains(displayList[index]),
              toggleSymptomCallback: (s) => toggleSymptom(s),
            ),
          ),
        ),
        AnimatedContainer(
          duration: 450.milliseconds,
          curve: Curves.fastLinearToSlowEaseIn,
          height: selectedSymptoms.isEmpty ? 0.h : 55.h,
          decoration: BoxDecoration(
            color: primaryContainer,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -4.h),
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
              ),
            ],
          ),
          child: InkWell(
            onTap: proceed,
            child: Center(
              child: Text(
                'متابعة',
                style: TextStyle(
                  fontSize: 19.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void toggleSymptom(Symptom symptom) {
    setState(
      () {
        if (selectedSymptoms.contains(symptom)) {
          selectedSymptoms.remove(symptom);
          return;
        }
        selectedSymptoms.add(symptom);
      },
    );
  }

  Future<void> proceed() async {
    bool dismissedLoaderSheet = false;
    try {
      Get.bottomSheet(
        const DiagnosingDiseaseBottomSheet(),
        isDismissible: false,
        enableDrag: false,
      );
      if (!AccountManager.instance.isLoggedIn) {
        NavigationController.toLoginPage();
      }
      var result = await HttpService.parsedPost(
        endPoint:
            'patients/${AccountManager.instance.user!.id}/diagnoseDisease/',
        body: {
          'symptomIds': selectedSymptoms.map((e) => e.id).toList(),
        },
        mapper: MedicalDiagnosisDetails.fromJson,
      );
      Get.back();
      dismissedLoaderSheet = true;
      Get.off(
        () => MedicalDiagnosisDetailsPage(diagnosisDetails: result),
      );
      DiagnosisHistoryManager.instance.updateHistory();
    } catch (e) {
      if (!dismissedLoaderSheet) {
        Get.back();
      }
    }
  }
}

class SelectableSymptomWidget extends StatelessWidget {
  const SelectableSymptomWidget({
    super.key,
    required this.symptom,
    required this.isSelected,
    required this.toggleSymptomCallback,
  });

  final Symptom symptom;
  final bool isSelected;
  final void Function(Symptom symptomId) toggleSymptomCallback;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(symptom.name),
      trailing: Checkbox(
        value: isSelected,
        onChanged: (_) {},
      ),
      onTap: () => toggleSymptomCallback(symptom),
    );
  }
}

class DiagnosingDiseaseBottomSheet extends StatelessWidget {
  const DiagnosingDiseaseBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        color: Colors.white,
      ),
      height: MediaQuery.of(context).size.height * .40,
      child: SizedBox.expand(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.monitor_heart_rounded,
                size: 100.sp,
                color: primaryColor,
              ),
              AddVerticalSpacing(value: 35.h),
              Text(
                'يتم الآن تشخيص الحالة المرضية\nيرجى الانتظار...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                ),
              ),
              AddVerticalSpacing(value: 20.h),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * .5,
                child: const LinearProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
