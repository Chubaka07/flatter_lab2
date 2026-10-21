import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_lab2/app/features/content/bloc/content_bloc.dart';
import 'package:flutter_lab2/app/features/home/bloc/home_bloc.dart';
import 'package:flutter_lab2/data/dio/set_up.dart';
import 'package:flutter_lab2/data/repositories/content/content_repository.dart';
import 'package:flutter_lab2/data/repositories/content/content_repository_interface.dart';

final getIt = GetIt.instance;
final talker = TalkerFlutter.init();
final dio = Dio();

Future<void> setupLocator() async {
  // Настройка Dio
  setUpDio(dio);
  getIt.registerSingleton<Dio>(dio);

  // Регистрация репозитория
  getIt.registerSingleton<ContentRepositoryInterface>(
    ContentRepository(dio: getIt.get<Dio>()),
  );

  // Регистрация BLoC
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(getIt.get<ContentRepositoryInterface>()),
  );
  getIt.registerFactory<ContentBloc>(
    () => ContentBloc(getIt.get<ContentRepositoryInterface>()),
  );

  // Регистрация логгера
  getIt.registerSingleton(talker);
}