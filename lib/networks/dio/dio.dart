import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../endpoints.dart';
import 'log.dart';

class DioSingleton {
  static final DioSingleton _singleton = DioSingleton._internal();
  static CancelToken cancelToken = CancelToken();
  DioSingleton._internal();

  static DioSingleton get instance => _singleton;

  late Dio dio;

  void create() {
    BaseOptions options = BaseOptions(
        baseUrl: url,
        connectTimeout: 100000,
        receiveTimeout: 100000,
        headers: {
          NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
          NetworkConstants.ACCEPT_LANGUAGE:
              NetworkConstants.ACCEPT_LANGUAGE_VALUE,
          NetworkConstants.APP_KEY: NetworkConstants.APP_KEY_VALUE,
        });
    dio = Dio(options)..interceptors.add(Logger());
  }

  void update(String auth) {
    if (kDebugMode) {
      print("Dio update");
    }
    BaseOptions options = BaseOptions(
      baseUrl: url,
      responseType: ResponseType.json,
      headers: {
        NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
        NetworkConstants.ACCEPT_LANGUAGE:
            NetworkConstants.ACCEPT_LANGUAGE_VALUE,
        NetworkConstants.APP_KEY: NetworkConstants.APP_KEY_VALUE,
        NetworkConstants.AUTHORIZATION: "Bearer $auth",
      },
      connectTimeout: 100000,
      receiveTimeout: 100000,
    );
    dio.options = options;
  }
}

Future postHttp(String path, [dynamic data]) => DioSingleton.instance.dio
    .post(path, data: data, cancelToken: DioSingleton.cancelToken);

Future getHttp(String path, [dynamic data]) =>
    DioSingleton.instance.dio.get(path, cancelToken: DioSingleton.cancelToken);

Future deleteHttp(String path, [dynamic data]) => DioSingleton.instance.dio
    .delete(path, data: data, cancelToken: DioSingleton.cancelToken);
