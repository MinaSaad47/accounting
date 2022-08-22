// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money_capital_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MoneyCapitalModel _$$_MoneyCapitalModelFromJson(Map<String, dynamic> json) =>
    _$_MoneyCapitalModel(
      id: json['id'] as int?,
      value: json['value'] as num,
      time: DateTime.parse(json['time'] as String),
      userName: json['user_name'] as String?,
      companyName: json['company_name'] as String?,
    );

Map<String, dynamic> _$$_MoneyCapitalModelToJson(
        _$_MoneyCapitalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'time': instance.time.toIso8601String(),
      'user_name': instance.userName,
      'company_name': instance.companyName,
    };
