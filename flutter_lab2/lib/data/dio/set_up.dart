import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:flutter_lab2/di/di.dart';

void setUpDio(Dio dio) {
  dio.options.baseUrl = 'https://www.googleapis.com/books/v1';
  dio.options.queryParameters.addAll({
    'key': 'AIzaSyA1sp4nN-4hGX9lXoBTUVFUeXojmOnlAig',
  });
  dio.options.connectTimeout = const Duration(seconds: 10);
  dio.options.receiveTimeout = const Duration(seconds: 10);

  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestData: true,
        printResponseData: true,
      ),
    ),
  );
}