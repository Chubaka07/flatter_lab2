import 'package:html/parser.dart' as html_parser;
import 'package:json_annotation/json_annotation.dart';

part 'content.g.dart';

@JsonSerializable()
class Content {
  final String id;
  final String title;
  final String author;
  final String description;
  final String image;

  Content({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.image,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    final info = (json['volumeInfo'] as Map<String, dynamic>?) ?? {};
    final links = (info['imageLinks'] as Map<String, dynamic>?) ?? {};
    final authors = (info['authors'] as List<dynamic>?) ?? [];

    final rawImage = links['thumbnail'] as String? ?? '';
    final image = rawImage.replaceFirst('http://', 'https://');

    final rawDescription = info['description'] as String? ?? 'Описание отсутствует';

    return Content(
      id: json['id'] as String? ?? '',
      title: info['title'] as String? ?? 'Без названия',
      author: authors.isNotEmpty ? authors.join(', ') : 'Неизвестный автор',
      description: _stripHtml(rawDescription),
      image: image,
    );
  }

  Map<String, dynamic> toJson() => _$ContentToJson(this);

  static String _stripHtml(String raw) {
    final document = html_parser.parse(raw);
    final text = document.body?.text ?? raw;
    return text
        .replaceAll('\u00A0', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}