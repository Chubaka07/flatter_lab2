import 'package:flutter_lab2/data/models/content.dart';

abstract interface class ContentRepositoryInterface {
  Future<List<Content>> getContent();
  Future<Content> getContentById(String id);
}