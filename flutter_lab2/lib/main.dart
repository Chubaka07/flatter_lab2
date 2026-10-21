import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

import 'di/di.dart';
import 'library_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  Bloc.observer = TalkerBlocObserver(talker: talker);

  FlutterError.onError = (details) {
    talker.handle(details.exception, details.stack);
  };

  runApp(const LibraryApp());
}