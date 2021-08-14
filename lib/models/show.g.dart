// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Show _$ShowFromJson(Map<String, dynamic> json) {
  return Show(
    id: json['_id'] as String,
    title: json['title'] as String,
    description: json['description'] as String?,
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$ShowToJson(Show instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };
