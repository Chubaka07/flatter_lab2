import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_lab2/app/extensions/extensions.dart';
import 'package:flutter_lab2/app/widgets/widgets.dart';
import 'package:flutter_lab2/data/models/content.dart';
import 'package:flutter_lab2/di/di.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeBloc = getIt<HomeBloc>();

  @override
  void initState() {
    super.initState();
    _homeBloc.add(const HomeLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Библиотека')),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _homeBloc,
        builder: (context, state) {
          return switch (state) {
            HomeInitial() => const SizedBox.shrink(),
            HomeLoadInProgress() =>
              const Center(child: CircularProgressIndicator()),
            HomeLoadSuccess(:final content) => _buildSuccess(content),
            HomeLoadFailure(:final exception) =>
              _buildFailure(exception.toString()),
          };
        },
      ),
    );
  }

  Widget _buildSuccess(List<Content> content) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: content.length,
      separatorBuilder: (_, __) => 16.ph,
      itemBuilder: (context, index) {
        final item = content[index];
        return ContentCard(
          title: item.title,
          description: item.description,
          imagePath: item.image,
          onTap: () {
            context.push('/content/${item.id}');
          },
        );
      },
    );
  }

  Widget _buildFailure(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ошибка: $error',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _homeBloc.add(const HomeLoad()),
              child: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }
}