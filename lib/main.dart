import 'package:dummy_api_call_retrofit/screens/app_lang/app_db.dart';
import 'package:dummy_api_call_retrofit/screens/app_lang/app_language.dart';
import 'package:dummy_api_call_retrofit/screens/model/geofencing_location.dart';
import 'package:dummy_api_call_retrofit/screens/photos_list_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  // Fixing App Orientation.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) async {
      /// Disable debugPrint logs in production
      if (kReleaseMode) {
        debugPrint = (String? message, {int? wrapWidth}) {};
      }
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
                debugShowCheckedModeBanner: false,
                title: 'Practical Task',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home: const PhotosListPage(),
                localizationsDelegates: const [
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
