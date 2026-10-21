import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_lab2/app/theme/theme.dart';
import 'package:flutter_lab2/data/models/content.dart';
import 'package:flutter_lab2/di/di.dart';

import 'bloc/content_bloc.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key, required this.contentId});

  final String contentId;

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late final ContentBloc _contentBloc;

  @override
  void initState() {
    super.initState();
    _contentBloc = getIt<ContentBloc>();
    _contentBloc.add(ContentLoad(id: widget.contentId));
  }

  @override
  void dispose() {
    _contentBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentBloc, ContentState>(
      bloc: _contentBloc,
      builder: (context, state) {
        final title = switch (state) {
          ContentLoadSuccess(:final content) => content.title,
          _ => 'Подробнее',
        };

        return Scaffold(
          appBar: AppBar(
            title: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          body: switch (state) {
            ContentInitial() => const SizedBox.shrink(),
            ContentLoadInProgress() =>
              const Center(child: CircularProgressIndicator()),
            ContentLoadSuccess(:final content) => _buildSuccess(content),
            ContentLoadFailure(:final exception) =>
              _buildFailure(exception.toString()),
          },
        );
      },
    );
  }

  Widget _buildSuccess(Content content) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Обложка
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                content.image,
                width: 200,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 200,
                  height: 300,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.book,
                    size: 80,
                    color: Colors.grey,
                  ),
                ),
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    width: 200,
                    height: 300,
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Название
          Text(
            content.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),

          // Автор
          Text(
            content.author,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: ThemeColors.accent,
                ),
          ),
          const SizedBox(height: 16),

          const Divider(),
          const SizedBox(height: 16),

          // Заголовок «Описание»
          Text(
            'Описание',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),

          // Полное описание
          Text(
            content.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 32),

          // Кнопка
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Функция появится позже'),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Взять в библиотеке'),
            ),
          ),
        ],
      ),
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
              onPressed: () {
                _contentBloc.add(ContentLoad(id: widget.contentId));
              },
              child: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }
}