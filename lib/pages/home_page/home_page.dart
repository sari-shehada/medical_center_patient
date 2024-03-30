import 'package:flutter/material.dart';
import 'package:medical_center_patient/core/ui_utils/buttons/custom_filled_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Center(
          child: CustomFilledButton(
            onTap: () {},
            child: 'القيام بفحص جديد',
          ),
        ),
      ),
    );
  }
}
