import 'package:flutter/material.dart';
import '../../config/string_constants.dart';
import '../../ui_utils/app_logo_widget.dart';
import '../../ui_utils/spacing_utils.dart';

class LoaderPage extends StatelessWidget {
  const LoaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox.expand(
        child: Column(
          children: [
            AppLogoWidget(),
            AddVerticalSpacing(
              value: 100,
            ),
            Text(StringConstants.appName)
          ],
        ),
      ),
    );
  }

  Future<void> _performInitialLoading() async {}
}
