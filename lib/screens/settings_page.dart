import 'package:dummy_api_call_retrofit/screens/widgets/base_app_bar.dart';
import 'package:dummy_api_call_retrofit/values/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../generated/l10n.dart';
import '../values/colors.dart';
import '../values/constants.dart';
import 'app_lang/app_db.dart';
import 'app_lang/app_language.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<Language> lanList = [];

  ValueNotifier<bool> shippingSwitch = ValueNotifier(true);
  ValueNotifier<bool> listNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      lanList.add(Language(S.of(context).english, false));
      lanList.add(Language(S.of(context).arabic, false));
      lanList.add(Language(S.of(context).japanese, false));
      if (appDB.appLanguage == ENGLISH) {
        lanList[0].isSelected = true;
      } else if (appDB.appLanguage == ARABIC) {
        lanList[1].isSelected = true;
      } else {
        lanList[2].isSelected = true;
      }
      listNotifier.value = true;
    });
  }

  @override
  void dispose() {
    shippingSwitch.dispose();
    listNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: BaseAppBar(
        showTitle: true,
        title: S.of(context).settings,
        leadingIcon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text(
              S.of(context).changeLanguage,
              style: textWhite18_700.copyWith(color: AppColor.color575B60),
            ),
            SizedBox(
              height: 20.h,
            ),
            ValueListenableBuilder(
              valueListenable: listNotifier,
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: lanList.length,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(child: Text(lanList[index].lan)),
                        FittedBox(
                          fit: BoxFit.fill,
                          child: Switch.adaptive(
                            activeColor: AppColor.appColorBlue,
                            value: lanList[index].isSelected,
                            onChanged: (value) {
                              if (value) {
                                lanList.forEach((element) {
                                  element.isSelected = false;
                                });
                                lanList[index].isSelected = value;
                              }

                              if (lanList[0].isSelected) {
                                appDB.appLanguage = ENGLISH;
                                appLanguage
                                    .changeLanguage(const Locale(englishLocal));
                              } else if (lanList[1].isSelected) {
                                appDB.appLanguage = ARABIC;
                                appLanguage
                                    .changeLanguage(const Locale(arabicLocal));
                              } else {
                                appDB.appLanguage = JAPANESE;
                                appLanguage.changeLanguage(
                                    const Locale(japaneseLocal));
                              }

                              setState(() {});
                            },
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class Language {
  String lan;
  bool isSelected;

  Language(this.lan, this.isSelected);
}
