import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dummy_api_call_retrofit/locator/locator.dart';
import 'package:dummy_api_call_retrofit/notwork/data_source/api_utils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  static Future<void> provideDio() async {
    final dio = await setupDio();
    locator.registerSingleton(dio);
    locator.registerSingleton(PostApi(dio));
  }

  static FutureOr<Dio> setupDio() async {
    final dio = Dio();
    dio.options = BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com",
      responseType: ResponseType.plain,
      headers: {
        'content-type': 'text/plain',
        'contentType': 'text/plain',
        'responseType': 'text/plain',
      },
    );
    dio.interceptors.add(PrettyDioLogger());

    return dio;
  }
}
