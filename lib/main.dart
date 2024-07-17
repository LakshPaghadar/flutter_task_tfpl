//import 'package:dummy_api_call_retrofit/l10n/app_localizations.dart';
import 'package:dummy_api_call_retrofit/screens/app_lang/app_db.dart';
import 'package:dummy_api_call_retrofit/screens/app_lang/app_language.dart';
import 'package:dummy_api_call_retrofit/screens/model/geofencing_location.dart';
import 'package:dummy_api_call_retrofit/screens/photos_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';
import 'locator/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive
    ..registerAdapter(GeofencingLocationAdapter())
    ..init(appDocumentDir.path);

  await setupLocator();
  await locator.isReady<AppDB>();
  AppLanguage appLanguage = locator<AppLanguage>();
  await appLanguage.fetchLocale();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en');
  // This widget is the root of your application.
  // void setLocale(Locale value) {
  //   setState(() {
  //     _locale = value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return appLanguage;
      },
      child: Consumer<AppLanguage>(
        builder: (BuildContext context, AppLanguage value, Widget? child) {
          return ScreenUtilInit(
            designSize: const Size(390, 810),
            builder: (context, child) {
              return MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home: const PhotosListPage(),
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                locale: value.appLocal,
                supportedLocales: [
                  const Locale(englishLocal, 'US'),
                  const Locale(arabicLocal, ''),
                  const Locale(japaneseLocal, ''),
                  ...S.delegate.supportedLocales
                ],
              );
            },
          );
        },
      ),
    );
  }
}
