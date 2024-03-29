import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    super.key,
    this.size,
  });

  final double? size;
  @override
  Widget build(BuildContext context) {
    return FlutterLogo(
      size: size ?? 150.sp,
    );
  }
}
