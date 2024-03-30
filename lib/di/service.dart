

import 'package:dio/dio.dart';
import 'package:diplome/core/interceptor_app.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final service = GetIt.instance;

Future<void> init() async {
  service.registerLazySingleton(
    () => Dio(
      BaseOptions(
        headers: {"X-Api-Key": "Ihn3F2x44nf/EbWui5SOFA==YebHR8EAtQWefVF2"},
        baseUrl: 'https://api.api-ninjas.com/v1/',
      ),
    )..interceptors.addAll(
        [
          InterceptorsApp(),
          PrettyDioLogger(),
        ],
      ),
  );
}
