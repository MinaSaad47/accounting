// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExpenseModel _$$_ExpenseModelFromJson(Map<String, dynamic> json) =>
    _$_ExpenseModel(
      id: json['id'] as String?,
      value: json['value'] as num,
      description: json['description'] as String,
      time: _$JsonConverterFromJson<String, DateTime>(
          json['time'], const DatetimeJsonConverter().fromJson),
      userName: json['user'] as String?,
      companyName: json['company'] as String?,
    );

Map<String, dynamic> _$$_ExpenseModelToJson(_$_ExpenseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'description': instance.description,
      'time': _$JsonConverterToJson<String, DateTime>(
          instance.time, const DatetimeJsonConverter().toJson),
      'user': instance.userName,
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
