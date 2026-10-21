import 'package:flutter/material.dart';

import 'app/app.dart';

class LibraryApp extends StatelessWidget {
  const LibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Библиотека',
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}