import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_center_patient/models/medicine.dart';

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
            minLeadingWidth: 40.w,
            title: Text(
              medicine.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                medicine.imageUrl,
                width: 40.w,
              ),
            ),
          );
        },
      ),
    );
  }
}
