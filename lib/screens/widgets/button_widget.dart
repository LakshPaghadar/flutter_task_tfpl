import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../values/colors.dart';
import '../../values/style.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback callback;
  final double? elevation;
  final double? height;
  final double? radius;
  final double? padding;
  final bool buttonColor;

  const AppButton(
    this.label,
    this.callback, {
    super.key,
    double this.elevation = 0.0,
    this.height,
    this.radius,
    this.padding,
    this.buttonColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.h,
      child: MaterialButton(
        elevation: elevation,
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0).r,
        onPressed: callback,
        color: AppColor.appColorBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(const Radius.circular(20).r),
        ),
        child: Text(
          label,
          style: textMedium.copyWith(
            color: AppColor.white,
            fontSize: 16.spMin,
          ),
        ),
      ),
    );
  }
}
