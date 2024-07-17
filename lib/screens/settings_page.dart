import 'package:dummy_api_call_retrofit/main.dart';
import 'package:dummy_api_call_retrofit/screens/widgets/base_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../generated/l10n.dart';
import '../values/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<Language> lanList = [
    Language("English", true),//en
    Language("Arabic", false),//ar
    Language("Japanese", false),//ja
  ];
  ValueNotifier<bool> shippingSwitch = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        showTitle: true,
        title: S.of(context).settings,
        leadingIcon: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25).r,
          child: Column(
            children: [
              Text(S.of(context).changeLanguage),
              ListView.builder(
                itemCount: lanList.length,
                padding: EdgeInsets.zero,
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
                            debugPrint("TESTTEST"+value.toString());
                            if(value){
                              lanList.forEach((element) {
                                element.isSelected = false;
                              });
                              lanList[index].isSelected = value;
                            }

                            setState(() {});
                          },
                        ),
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void setLocaleApp(){
    if(lanList[0].isSelected){
      //MyApp.of(context).set
    }
  }
}

class Language {
  String lan;
  bool isSelected;

  Language(this.lan, this.isSelected);
}
