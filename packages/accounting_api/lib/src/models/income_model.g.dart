// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IncomeModel _$$_IncomeModelFromJson(Map<String, dynamic> json) =>
    _$_IncomeModel(
      id: json['id'] as int?,
      value: json['value'] as num,
      description: json['description'] as String,
      time: _$JsonConverterFromJson<String, DateTime>(
          json['time'], const DatetimeJsonConverter().fromJson),
      companyName: json['company'] as String?,
    );

Map<String, dynamic> _$$_IncomeModelToJson(_$_IncomeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'description': instance.description,
      'time': _$JsonConverterToJson<String, DateTime>(
          instance.time, const DatetimeJsonConverter().toJson),
      'company': instance.companyName,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
