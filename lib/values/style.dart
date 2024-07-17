import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

final TextStyle textThin = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w100,
  fontSize: 16.spMin,
  color: AppColor.black,
);
final TextStyle textExtraLight = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w200,
  fontSize: 16.spMin,
  color: AppColor.black,
  overflow: TextOverflow.ellipsis,
);
final TextStyle textLight = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w300,
  fontSize: 16.spMin,
  color: AppColor.black,
  overflow: TextOverflow.ellipsis,
);
final TextStyle textRegular = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w400,
  fontSize: 16.spMin,
  color: AppColor.black,
  overflow: TextOverflow.ellipsis,
);
final TextStyle textMedium = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w500,
  fontSize: 16.spMin,
  overflow: TextOverflow.ellipsis,
);
final TextStyle textSemiBold = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w600,
  fontSize: 16.spMin,
  overflow: TextOverflow.ellipsis,
);
final TextStyle textBold = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w700,
  fontSize: 16.spMin,
  overflow: TextOverflow.ellipsis,
);
final TextStyle textExtraBold = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w800,
  fontSize: 16.spMin,
  overflow: TextOverflow.ellipsis,
);
final TextStyle textBlack = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w900,
  fontSize: 26.spMin,
  overflow: TextOverflow.visible,
);

//App Style

final TextStyle textBlack26_700 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w700,
  fontSize: 26.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.black,
);

final TextStyle textAppColorBlue26_700 = textBlack26_700.copyWith(
  color: AppColor.appColorBlue,
);

final TextStyle textAppColorBlue24_800 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w800,
  fontSize: 24.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.appColorBlue,
);

final TextStyle text_B5B5B5_24_800 =
    textAppColorBlue24_800.copyWith(color: AppColor.colorB5B5B5);

final TextStyle textBlack24_800 =
    textAppColorBlue24_800.copyWith(color: AppColor.black);

final TextStyle text_4B4F52_14_400 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w400,
  fontSize: 14.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.color4B4F52,
);

final TextStyle text_4B4F52_16_600 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w600,
  fontSize: 16.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.color4B4F52,
);

final TextStyle textBlack14_400 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w400,
  fontSize: 14.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.black,
);

final TextStyle text_4B4E57_14_400_ = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w400,
  fontSize: 14.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.color4B4E57,
);

final TextStyle text_4B4E57_14_500 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w500,
  fontSize: 14.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.color4B4E57,
);

final TextStyle textBlack14_500 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w500,
  fontSize: 14.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.black,
);

final TextStyle textBlack12_600 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w600,
  fontSize: 12.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.black,
);

final TextStyle textBlack12_400 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w400,
  fontSize: 12.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.black,
);

final TextStyle text_858585_12_400 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w400,
  fontSize: 12.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.color858585,
);

final TextStyle text_4B4E57_12_400 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w400,
  fontSize: 12.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.color4B4E57,
);

final TextStyle text_7E879F_12_600 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w600,
  fontSize: 12.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.color7E879F,
);

final TextStyle text_7E879F_16_400 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w400,
  fontSize: 16.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.color7E879F,
);

final TextStyle text_7E879F_12_500 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w500,
  fontSize: 12.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.color7E879F,
);

final TextStyle text_7E879F_12_400 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w400,
  fontSize: 12.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.color7E879F,
);

final TextStyle text_7E879F_10_500 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w500,
  fontSize: 10.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.color7E879F,
);

final TextStyle text_7E879F_14_400 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w400,
  fontSize: 14.spMin,
  overflow: TextOverflow.visible,
  color: AppColor.color7E879F,
);

final TextStyle text_7E879F_19_500 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w500,
  fontSize: 19.spMin,
  overflow: TextOverflow.visible,
  color: AppColor.color7E879F,
);

final TextStyle textFont = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w600,
  fontSize: 14.spMin,
  overflow: TextOverflow.ellipsis,
);

final TextStyle text_2ECE95_14_500 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w500,
  fontSize: 14.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.color2ECE95,
);

final TextStyle text_151517_14_400 =
    textBlack14_400.copyWith(color: AppColor.color151517);

final TextStyle text_9A9CAD_12_400 =
    textBlack14_400.copyWith(color: AppColor.color9A9CAD);

final TextStyle textBlack16_600 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w600,
  fontSize: 16.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.black,
);

final TextStyle text_22263D_16_700 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w700,
  fontSize: 16.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.color22263D,
);

final TextStyle textBlack16_700 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w700,
  fontSize: 16.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.black,
);

final TextStyle textAppColorBlue16_700 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w700,
  fontSize: 16.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.appColorBlue,
);

final TextStyle text_1D242C_14_700 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w700,
  fontSize: 14.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.color1D242C,
);

final TextStyle text_575B60_14_500 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w500,
  fontSize: 15.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.color575B60,
);

final TextStyle textWhite12_600 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w600,
  fontSize: 12.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.white,
);

final TextStyle text_0A0912_14_600 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w600,
  fontSize: 14.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.color0A0912,
);

final TextStyle textBlack20_600 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w600,
  fontSize: 20.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.black,
);

final TextStyle textBlack18_700 =
    textBlack16_600.copyWith(fontSize: 18.spMin, fontWeight: FontWeight.w700);

final TextStyle textBlack14_700 = textBlack18_700.copyWith(fontSize: 14.spMin);

final TextStyle textBlack14_600 =
    textBlack14_700.copyWith(fontWeight: FontWeight.w600);

final TextStyle text4B4E5714_400 = textBlack14_700.copyWith(
    fontWeight: FontWeight.w400, color: AppColor.color4B4E57_80);

final TextStyle text_626161_16_400 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w400,
  fontSize: 16.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.color626161,
);

final TextStyle text_5380F1_16_400 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w500,
  fontSize: 12.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.color5380F1,
);

final TextStyle textAppColorBlue16_600 = text_9A9CAD_12_400.copyWith(
    fontWeight: FontWeight.w600, color: AppColor.appColorBlue);

final TextStyle textWhite16_600 =
    textBlack16_600.copyWith(color: AppColor.white);

final TextStyle textWhite16_400 =
    textWhite16_600.copyWith(fontWeight: FontWeight.w400);

final TextStyle textWhite14_400 = textWhite16_400.copyWith(fontSize: 14.spMin);

final TextStyle textWhite18_700 = TextStyle(
  decoration: TextDecoration.none,
  fontWeight: FontWeight.w700,
  fontSize: 18.spMin,
  overflow: TextOverflow.ellipsis,
  color: AppColor.white,
);
