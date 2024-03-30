
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class InterceptorsApp extends QueuedInterceptor {
  @override
  // ignore: unnecessary_overrides
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Api-Key'] = "Ihn3F2x44nf/EbWui5SOFA==YebHR8EAtQWefVF2";
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    }
    super.onResponse(response, handler);
  }
}
