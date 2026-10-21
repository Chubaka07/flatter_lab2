// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
  id: json['id'] as String,
  title: json['title'] as String,
  author: json['author'] as String,
  description: json['description'] as String,
  image: json['image'] as String,
);

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'author': instance.author,
  'description': instance.description,
  'image': instance.image,
};
