// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CompanyModel _$$_CompanyModelFromJson(Map<String, dynamic> json) =>
    _$_CompanyModel(
      id: json['id'] as int?,
      funders: (json['funders'] as List<dynamic>)
          .map((e) => FunderModel.fromJson((e as Map<String, dynamic>).map(
                (k, e) => MapEntry(k, e as Object),
              )))
          .toList(),
      commercialFeature: json['commercial_feature'] as String,
      isWorking: json['is_working'] as bool,
      legalEntity: json['legal_entity'] as String,
      fileNumber: json['file_number'] as String?,
      registerNumber: json['register_number'] as String,
      startDate:
          const DatetimeJsonConverter().fromJson(json['start_date'] as String),
      stopDate: _$JsonConverterFromJson<String, DateTime>(
          json['stop_date'], const DatetimeJsonConverter().fromJson),
      generalTaxMission: json['general_tax_mission'] as String,
      valueTaxMission: json['value_tax_mission'] as String?,
      activityNature: json['activity_nature'] as String,
      activityLocation: json['activity_location'] as String,
      accounts: json['accounts'] as String,
      joiningDate: _$JsonConverterFromJson<String, DateTime>(
          json['joining_date'], const DatetimeJsonConverter().fromJson),
      naturalId: json['natural_id'] as String?,
      moneyCapitals: (json['money_capitals'] as List<dynamic>?)
          ?.map(
              (e) => MoneyCapitalModel.fromJson((e as Map<String, dynamic>).map(
                    (k, e) => MapEntry(k, e as Object),
                  )))
          .toList(),
      recordSide: json['record_side'] as String?,
      recordNumber: json['record_number'] as String,
      userName: json['user_name'] as String,
      passport: json['passport'] as String?,
      verificationCode: json['verification_code'] as String?,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$_CompanyModelToJson(_$_CompanyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'funders': instance.funders,
      'commercial_feature': instance.commercialFeature,
      'is_working': instance.isWorking,
      'legal_entity': instance.legalEntity,
      'file_number': instance.fileNumber,
      'register_number': instance.registerNumber,
      'start_date': const DatetimeJsonConverter().toJson(instance.startDate),
      'stop_date': _$JsonConverterToJson<String, DateTime>(
          instance.stopDate, const DatetimeJsonConverter().toJson),
      'general_tax_mission': instance.generalTaxMission,
      'value_tax_mission': instance.valueTaxMission,
      'activity_nature': instance.activityNature,
      'activity_location': instance.activityLocation,
      'accounts': instance.accounts,
      'joining_date': _$JsonConverterToJson<String, DateTime>(
          instance.joiningDate, const DatetimeJsonConverter().toJson),
      'natural_id': instance.naturalId,
      'money_capitals': instance.moneyCapitals,
      'record_side': instance.recordSide,
      'record_number': instance.recordNumber,
      'user_name': instance.userName,
      'passport': instance.passport,
      'verification_code': instance.verificationCode,
      'email': instance.email,
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
