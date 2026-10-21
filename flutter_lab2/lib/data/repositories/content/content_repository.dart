import 'package:dio/dio.dart';
import 'package:flutter_lab2/data/dio/dio.dart';
import 'package:flutter_lab2/data/models/content.dart';
import 'content_repository_interface.dart';

class ContentRepository implements ContentRepositoryInterface {
  ContentRepository({required this.dio});

  final Dio dio;
  static const int _displayLimit = 10;

  @override
  Future<List<Content>> getContent() async {
    try {
      final Response response = await dio.get(
        Endpoints.content(query: 'flutter', limit: 40),
      );
      final items = (response.data['items'] as List?) ?? [];

      return items
          .map((e) => Content.fromJson(e as Map<String, dynamic>))
          .where((book) => _hasRealDescription(book.description))
          .take(_displayLimit)
          .toList();
    } on DioException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<Content> getContentById(String id) async {
    try {
      final Response response = await dio.get(Endpoints.contentById(id));
      return Content.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw e.message.toString();
    }
  }

  bool _hasRealDescription(String description) {
    final trimmed = description.trim();
    return trimmed.length > 20 && trimmed != 'Описание отсутствует';
  }
}