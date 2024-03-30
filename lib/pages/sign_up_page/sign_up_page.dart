import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medical_center_patient/config/theme/app_colors.dart';
import 'package:medical_center_patient/core/services/http_service.dart';
import 'package:medical_center_patient/core/services/snackbar_service.dart';
import 'package:medical_center_patient/core/ui_utils/buttons/custom_filled_button.dart';
import 'package:medical_center_patient/core/ui_utils/spacing_utils.dart';
import 'package:medical_center_patient/core/ui_utils/text_fields/custom_text_field.dart';
import 'package:medical_center_patient/core/widgets/date_time_input_widget.dart';
import 'package:medical_center_patient/core/widgets/gender_toggle_widget.dart';
import 'package:medical_center_patient/managers/account_manager.dart';
import 'package:medical_center_patient/models/patient_info.dart';
import 'package:medical_center_patient/pages/navigation_controller.dart';
import 'package:medical_center_patient/pages/sign_up_page/models/patient_sign_up_request_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  Rx<DateTime?> dateOfBirth = Rx<DateTime?>(null);
  Rx<bool> isMale = true.obs;

  Rx<CustomButtonStatus> signUpButtonStatus = CustomButtonStatus.enabled.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'إنشاء حساب جديد',
        ),
        foregroundColor: primaryColor,
        centerTitle: true,
      ),
      body: SizedBox.expand(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          children: [
            AddVerticalSpacing(value: 15.h),
            CustomTextField(
              controller: firstNameController,
              inputAction: TextInputAction.next,
              label: 'الاسم الأول',
            ),
            AddVerticalSpacing(value: 15.h),
            CustomTextField(
              controller: lastNameController,
              inputAction: TextInputAction.next,
              label: 'الاسم الأخير',
            ),
            AddVerticalSpacing(value: 15.h),
            CustomTextField(
              controller: usernameController,
              inputAction: TextInputAction.next,
              textDirection: TextDirection.ltr,
              label: 'اسم المستخدم',
            ),
            AddVerticalSpacing(value: 15.h),
            CustomTextField(
              controller: passwordController,
              inputAction: TextInputAction.next,
              textDirection: TextDirection.ltr,
              obscureText: true,
              label: 'كلمة المرور',
            ),
            AddVerticalSpacing(value: 15.h),
            CustomTextField(
              controller: passwordConfirmationController,
              textDirection: TextDirection.ltr,
              obscureText: true,
              label: 'تأكيد كلمة المرور',
            ),
            AddVerticalSpacing(value: 15.h),
            DateOfBirthInputWidget(
              dateOfBirth: dateOfBirth,
            ),
            AddVerticalSpacing(value: 15.h),
            GenderToggleWidget(
              isMale: isMale,
            ),
            AddVerticalSpacing(value: 20.h),
            CustomFilledButton(
              onTap: () => signUp(),
              buttonStatus: signUpButtonStatus,
              child: 'إنشاء حساب',
            ),
            AddVerticalSpacing(value: 13.h),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('لديك حساب بالفعل؟'),
                TextButton(
                  onPressed: () => NavigationController.toLoginPage(),
                  child: const Text('تسجيل الدخول'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String? validateForm() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        usernameController.text.isEmpty ||
        passwordConfirmationController.text.isEmpty ||
        passwordController.text.isEmpty ||
        dateOfBirth.value == null) {
      return 'يرجى ملئ جميع الحقول للمتابعة';
    }
    if (passwordConfirmationController.text != passwordController.text) {
      return 'كلمة المرور لا تطابق حقل تأكيد كلمة المرور';
    }
    return null;
  }

  Future<void> signUp() async {
    String? validationMessage = validateForm();
    if (validationMessage != null) {
      SnackBarService.showErrorSnackbar(validationMessage);
      return;
    }
    try {
      PatientSignUpForm loginForm = PatientSignUpForm(
        username: usernameController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        password: passwordController.text,
        isMale: isMale.value,
        dateOfBirth: dateOfBirth.value!,
      );
      signUpButtonStatus.value = CustomButtonStatus.processing;
      var requestResult = await HttpService.rawFullResponsePost(
        endPoint: 'patients/new/',
        body: loginForm.toMap(),
      );
      Map decodedResult = jsonDecode(requestResult.body) as Map;
      if (requestResult.statusCode == 201) {
        PatientInfo userInfo =
            PatientInfo.fromMap(decodedResult as Map<String, dynamic>);
        await AccountManager.instance.login(userInfo);
        NavigationController.toHomePage();
        return;
      }
      if (requestResult.statusCode == 400) {
        if (decodedResult.containsKey('username')) {
          SnackBarService.showErrorSnackbar(
            'اسم المستخدم المدخل تم اخذه من قبل مريض اخر, يرجى اختيار اسم بديل',
          );
          return;
        }
      }
    } finally {
      signUpButtonStatus.value = CustomButtonStatus.enabled;
    }
  }
}
