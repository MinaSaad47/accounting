// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DocumentModel _$$_DocumentModelFromJson(Map<String, dynamic> json) =>
    _$_DocumentModel(
      name: json['name'] as String,
      path: json['path'] as String,
      time: const DatetimeJsonConverter().fromJson(json['time'] as String),
    );

Map<String, dynamic> _$$_DocumentModelToJson(_$_DocumentModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'time': const DatetimeJsonConverter().toJson(instance.time),
    };
