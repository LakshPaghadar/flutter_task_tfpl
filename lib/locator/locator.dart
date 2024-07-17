import 'package:dummy_api_call_retrofit/notwork/api_client.dart';
import 'package:dummy_api_call_retrofit/notwork/repository/post_repo_implement.dart';
import 'package:dummy_api_call_retrofit/notwork/store/post_store.dart';
import 'package:dummy_api_call_retrofit/screens/app_lang/app_language.dart';
import 'package:get_it/get_it.dart';

import '../screens/app_lang/app_db.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  //register dio object and PostApi()
  await ApiClient.provideDio();

  locator.registerFactory(() => PostRepositoryImpl());
  locator.registerLazySingleton(() => PostStore());
  locator.registerSingleton<AppLanguage>(AppLanguage());
  locator.registerSingletonAsync<AppDB>(() => AppDB.getInstance());
}
